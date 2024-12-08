import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    // markers: Array
    marker: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

    #addMarkersToMap() {
      const marker = this.markerValue;
      console.log("marker", marker)
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    }

    #fitMapToMarkers() {
      const marker = this.markerValue;
      const bounds = new mapboxgl.LngLatBounds();
      bounds.extend([marker.lng, marker.lat]);
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    }
  }
