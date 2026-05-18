import { useState } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

function MobileNav() {
  const { user, logout } = useAuth();
  const [isOpen, setIsOpen] = useState(false);
  
  if (!user) return null;
  return (
    <div className="md:hidden bg-gray-800 p-4 border-b border-gray-700 flex justify-between items-center">
      <h1 className="text-xl font-bold text-blue-500">Vigilant AI</h1>
      <button onClick={() => setIsOpen(!isOpen)} className="text-white p-2">&#9776;</button>
      {isOpen && (
        <div className="absolute top-16 left-0 w-full bg-gray-800 border-b border-gray-700 p-4 z-50 flex flex-col space-y-2">
          <Link to="/" onClick={() => setIsOpen(false)} className="block p-3 rounded hover:bg-gray-700">Dashboard</Link>
          <Link to="/reports" onClick={() => setIsOpen(false)} className="block p-3 rounded hover:bg-gray-700">Real-Time Reports</Link>
          {user?.role === 'admin' && <Link to="/analytics" onClick={() => setIsOpen(false)} className="block p-3 rounded hover:bg-gray-700">Admin Analytics</Link>}
          <button onClick={() => { logout(); setIsOpen(false); }} className="w-full bg-red-600 hover:bg-red-500 text-white p-2 rounded mt-2">Logout</button>
        </div>
      )}
    </div>
  );
}

export default MobileNav;
