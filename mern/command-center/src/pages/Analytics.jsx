function AdminAnalytics() {
  return (
    <div className="flex-1 p-4 md:p-8 overflow-y-auto">
      <h2 className="text-2xl md:text-3xl font-semibold mb-8">Admin Analytics</h2>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-gray-800 p-6 rounded-xl border border-gray-700">
          <h4 className="text-gray-400 mb-2">Total Users</h4>
          <p className="text-3xl font-bold text-blue-400">1,245</p>
        </div>
        <div className="bg-gray-800 p-6 rounded-xl border border-gray-700">
          <h4 className="text-gray-400 mb-2">Active Reports</h4>
          <p className="text-3xl font-bold text-yellow-400">42</p>
        </div>
        <div className="bg-gray-800 p-6 rounded-xl border border-gray-700">
          <h4 className="text-gray-400 mb-2">Resolved Today</h4>
          <p className="text-3xl font-bold text-green-400">18</p>
        </div>
      </div>
      <div className="bg-gray-800 rounded-xl p-6 border border-gray-700 h-[400px] flex items-center justify-center">
        <p className="text-gray-400">Detailed Chart Component Pending</p>
      </div>
    </div>
  );
}

export default AdminAnalytics;
