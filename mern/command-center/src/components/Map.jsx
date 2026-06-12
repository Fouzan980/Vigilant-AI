import { useEffect } from "react";
import { MapContainer, TileLayer, Marker, Popup, useMap } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

// Fix for leaflet marker icon
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl:
    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon-2x.png",
  iconUrl:
    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-icon.png",
  shadowUrl:
    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.7.1/images/marker-shadow.png",
});

function HeatmapLayer({ points }) {
  const map = useMap();
  useEffect(() => {
    if (!map) return;
    let heat;
    import("leaflet")
      .then((L_module) => {
        window.L = L_module.default || L_module;
        return import("leaflet.heat");
      })
      .then(() => {
        heat = window.L.heatLayer(points, {
          radius: 25,
          blur: 15,
          maxZoom: 17,
        }).addTo(map);
      })
      .catch((err) => console.error("Error loading leaflet.heat:", err));

    return () => {
      if (heat && map) map.removeLayer(heat);
    };
  }, [map, points]);
  return null;
}

function LiveMap({ reports, heatPoints }) {
  const validReports = reports.filter(
    (r) =>
      Number.isFinite(Number(r.latitude)) &&
      Number.isFinite(Number(r.longitude)),
  );

  return (
    <div className="flex-1 rounded-lg overflow-hidden relative z-0">
      <MapContainer
        center={[40.7128, -74.006]}
        zoom={12}
        style={{ height: "100%", width: "100%" }}
      >
        <TileLayer
          url="https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
        />
        <HeatmapLayer points={heatPoints} />
        {validReports.map((r) => (
          <Marker
            key={r.id}
            position={[Number(r.latitude), Number(r.longitude)]}
          >
            <Popup>
              <strong>{r.category || "Incident"}</strong>
              <br />
              {r.description || "No description"}
              <br />
              <span className="text-sm text-gray-500">
                {r.timestamp
                  ? new Date(r.timestamp).toLocaleString()
                  : "Unknown time"}
              </span>
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}

export default LiveMap;
