import { useAuth } from '../context/AuthContext';

function Login() {
  const { login } = useAuth();
  return (
    <div className="flex-1 flex items-center justify-center bg-gray-900">
      <div className="bg-gray-800 p-8 rounded-xl border border-gray-700 max-w-md w-full">
        <h2 className="text-3xl font-bold text-center text-blue-500 mb-8">Vigilant AI Login</h2>
        <button onClick={() => login('admin')} className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold py-3 px-4 rounded mb-4 transition-colors">
          Login as Admin
        </button>
        <button onClick={() => login('user')} className="w-full bg-gray-700 hover:bg-gray-600 text-white font-bold py-3 px-4 rounded transition-colors">
          Login as Standard User
        </button>
      </div>
    </div>
  );
}

export default Login;
