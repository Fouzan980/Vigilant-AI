import { useState, createContext, useContext } from 'react';

const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [user, setUser] = useState({ role: 'admin', name: 'Admin User', token: 'dummy_jwt' }); // Mock logged in user
  
  const login = (role) => {
    setUser({ 
      role, 
      name: role === 'admin' ? 'Admin User' : 'Standard User', 
      token: 'dummy_jwt' 
    });
  };

  const logout = () => setUser(null);

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

// eslint-disable-next-line react-refresh/only-export-components
export const useAuth = () => useContext(AuthContext);
export default AuthContext;
