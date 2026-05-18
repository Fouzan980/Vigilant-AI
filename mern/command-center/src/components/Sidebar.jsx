import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

function Sidebar() {
  const { user, logout } = useAuth();
  const location = useLocation();
  const isActive = (path) => location.pathname === path ? "bg-blue-600 hover:bg-blue-500" : "hover:bg-gray-700";

  return (
    <div className="w-64 bg-gray-800 p-4 border-r border-gray-700 flex flex-col hidden md:flex">
      <h1 className="text-2xl font-bold text-blue-500 mb-8">Vigilant AI</h1>
      <nav className="flex-1 space-y-2">
        <Link to="/" className={`block p-3 rounded transition-colors ${isActive('/')}`}>Dashboard</Link>
        <Link to="/reports" className={`block p-3 rounded transition-colors ${isActive('/reports')}`}>Real-Time Reports</Link>
        {user?.role === 'admin' && (
          <Link to="/analytics" className={`block p-3 rounded transition-colors ${isActive('/analytics')}`}>Admin Analytics</Link>
        )}
      </nav>
      <div className="mt-auto pt-4 border-t border-gray-700">
        <p className="text-sm text-gray-400 mb-2">Logged in as {user?.name}</p>
        <button onClick={logout} className="w-full bg-red-600 hover:bg-red-500 text-white p-2 rounded transition-colors">Logout</button>
      </div>
    </div>
  );
}

export default Sidebar;
