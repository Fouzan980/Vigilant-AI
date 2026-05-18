import { useEffect } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import 'leaflet.heat';

// Fix for leaflet marker icon
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png',
  iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png',
});

function HeatmapLayer({ points }) {
  const map = useMap();
  useEffect(() => {
    if (!map) return;
    const heat = L.heatLayer(points, { radius: 25, blur: 15, maxZoom: 17 }).addTo(map);
    return () => { map.removeLayer(heat); };
  }, [map, points]);
  return null;
}

function LiveMap({ reports, heatPoints }) {
  return (
    <div className="flex-1 rounded-lg overflow-hidden relative z-0">
      <MapContainer center={[40.7128, -74.0060]} zoom={12} style={{ height: '100%', width: '100%' }}>
        <TileLayer
          url="https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
        />
        <HeatmapLayer points={heatPoints} />
        {reports.map(r => (
          r.latitude && r.longitude && (
            <Marker key={r.id} position={[r.latitude, r.longitude]}>
              <Popup>
                <strong>{r.category}</strong><br/>
                {r.description}<br/>
                <span className="text-sm text-gray-500">{new Date(r.timestamp).toLocaleString()}</span>
              </Popup>
            </Marker>
          )
        ))}
      </MapContainer>
    </div>
  );
}

export default LiveMap;
