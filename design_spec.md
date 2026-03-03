# 裝修工程追蹤與託管平台 - 系統設計規格書 (System Design Specification)

## 1. 系統概述 (Overview)
本系統旨在解決裝修工程中的信任問題，提供工程進度追蹤、資金託管 (Escrow) 和記錄共享功能。
核心流程：
1. **簽約 (Contract)**: 雙方確認工程項目、階段付款比例和總金額。
2. **託管 (Escrow)**: 客戶將資金支付至平台託管帳戶。
3. **施工 (Execution)**: 師傅按階段施工並上傳照片/影片證據。
4. **驗收 (Verification)**: 客戶審核證據，確認無誤後釋放該階段款項。
5. **完工 (Completion)**: 工程結束，雙方互評。

## 2. 技術架構 (Technology Stack)
*   **前端 (Frontend)**: React.js (Create React App 或 Vite), Ant Design (UI Library), Axios (API Client)
*   **後端 (Backend)**: Node.js, Express.js
*   **數據庫 (Database)**: MongoDB (使用 Mongoose ORM)
*   **身份驗證 (Auth)**: JWT (JSON Web Tokens)
*   **文件存儲 (Storage)**: 本地模擬 (開發階段) / AWS S3 (生產階段)
*   **支付模擬 (Payment)**: 模擬 Stripe API (開發階段)

## 3. 數據庫設計 (Database Schema)

### 3.1 Users (用戶)
| Field | Type | Description |
| :--- | :--- | :--- |
| `_id` | ObjectId | Unique ID |
| `username` | String | 用戶名 |
| `email` | String | 電子郵件 (Unique) |
| `password` | String | 加密密碼 (Hash) |
| `role` | String | 'client' (客戶) 或 'contractor' (師傅) |
| `createdAt` | Date | 創建時間 |

### 3.2 Projects (項目)
| Field | Type | Description |
| :--- | :--- | :--- |
| `_id` | ObjectId | Unique ID |
| `title` | String | 項目標題 |
| `description` | String | 項目描述 |
| `client` | ObjectId | Ref to User (Client) |
| `contractor` | ObjectId | Ref to User (Contractor) |
| `totalAmount` | Number | 總金額 |
| `status` | String | 'pending', 'in_progress', 'completed', 'cancelled' |
| `stages` | Array | 階段列表 (見下) |
| `createdAt` | Date | 創建時間 |

#### Stage Schema (內嵌於 Project)
| Field | Type | Description |
| :--- | :--- | :--- |
| `title` | String | 階段名稱 (e.g., "拆除工程") |
| `description` | String | 階段描述 |
| `amount` | Number | 該階段金額 |
| `status` | String | 'pending', 'working', 'reviewing', 'paid' |
| `evidence` | Array | 照片/文件 URL 列表 |
| `dueDate` | Date | 預計完成日期 |

### 3.3 Payments (支付記錄)
| Field | Type | Description |
| :--- | :--- | :--- |
| `_id` | ObjectId | Unique ID |
| `project` | ObjectId | Ref to Project |
| `stageIndex` | Number | 對應階段索引 |
| `amount` | Number | 支付金額 |
| `status` | String | 'held' (託管中), 'released' (已釋放), 'refunded' (已退款) |
| `transactionId` | String | 支付網關交易 ID |
| `createdAt` | Date | 創建時間 |

## 4. API 接口設計 (API Endpoints)

### 4.1 Auth
*   `POST /api/auth/register`: 註冊新用戶
*   `POST /api/auth/login`: 用戶登入 (返回 JWT)
*   `GET /api/auth/me`: 獲取當前用戶信息

### 4.2 Projects
*   `POST /api/projects`: 創建新項目 (Client only)
*   `GET /api/projects`: 獲取用戶相關的所有項目
*   `GET /api/projects/:id`: 獲取特定項目詳情
*   `PUT /api/projects/:id/stages/:stageIndex/evidence`: 上傳施工證據 (Contractor only)
*   `PUT /api/projects/:id/stages/:stageIndex/verify`: 確認驗收並釋放款項 (Client only)

### 4.3 Payments (模擬)
*   `POST /api/payments/escrow`: 模擬客戶支付款項到託管帳戶

## 5. 前端頁面規劃 (Frontend Pages)
1.  **Landing Page**: 登入/註冊入口。
2.  **Dashboard**: 顯示項目列表概覽。
3.  **Create Project**: 創建新項目表單 (Client)。
4.  **Project Detail**:
    *   項目信息與進度條。
    *   階段列表 (Accordion/Collapse)。
    *   每個階段顯示：描述、金額、狀態、證據上傳區 (師傅)、驗收按鈕 (客戶)。

