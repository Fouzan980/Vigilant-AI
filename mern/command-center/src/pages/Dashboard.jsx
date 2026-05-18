import { useState, useEffect } from 'react';
import LiveMap from '../components/Map';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3001/api/v1';

function Dashboard() {
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchReports = async () => {
      try {
        const response = await fetch(`${API_BASE_URL}/reports`);
        const data = await response.json();
        setReports(data);
      } catch (error) {
        console.error('Error fetching reports:', error);
      } finally {
        setLoading(false);
      }
    };
    fetchReports();
    const interval = setInterval(fetchReports, 30000); // Refresh every 30s
    return () => clearInterval(interval);
  }, []);

  const heatPoints = reports.map(r => [r.latitude || 40.7128, r.longitude || -74.0060, 1.0]);
  const criticalCount = reports.filter(r => r.severity === 'Critical').length;

  return (
    <div className="flex-1 p-4 md:p-8 overflow-y-auto">
      <header className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <h2 className="text-2xl md:text-3xl font-semibold">Command Center Overview</h2>
        <div className="flex items-center space-x-4">
          <div className="bg-red-500/20 text-red-400 px-4 py-2 rounded-full font-medium text-sm md:text-base">
            {criticalCount} Critical Incidents
          </div>
        </div>
      </header>
      
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="col-span-1 bg-gray-800 rounded-xl p-6 border border-gray-700">
          <h3 className="text-xl font-medium mb-4">Recent Reports</h3>
          {loading ? (
            <div className="text-gray-400">Loading reports...</div>
          ) : (
            <div className="space-y-4">
              {reports.length === 0 && <div className="text-gray-500">No reports found</div>}
              {reports.map(r => (
                <div key={r.id} className="bg-gray-700 p-4 rounded-lg">
                  <div className="flex justify-between items-start mb-2">
                    <span className={`font-medium ${r.severity === 'Critical' ? 'text-red-400' : 'text-yellow-400'}`}>
                      {r.category || 'Incident'}
                    </span>
                    <span className="text-sm text-gray-400">
                      {new Date(r.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                    </span>
                  </div>
                  <p className="text-sm text-gray-300">{r.description}</p>
                  <p className="text-xs text-gray-500 mt-2">{r.address || 'Location data unavailable'}</p>
                </div>
              ))}
            </div>
          )}
        </div>
        
        <div className="col-span-1 lg:col-span-2 bg-gray-800 rounded-xl p-6 border border-gray-700 flex flex-col h-[500px]">
          <h3 className="text-xl font-medium mb-4">Live Heatmap</h3>
          <LiveMap reports={reports} heatPoints={heatPoints} />
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
