import React from 'react';
import { Button } from 'antd';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <h1>Renovation Tracking Platform</h1>
        <Button type="primary">Get Started</Button>
        <Routes>
          <Route path="/" element={<div>Home Page</div>} />
          {/* Add more routes here */}
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
