require 'socket'

# Format:
# FIELD_NAME, FORMAT, VALUE
# See https://ruby-doc.org/current/packed_data_rdoc.html for format definitions
mock_data = [
  ["ID", "C", 1],
  ["BATT_A_V", "g", 0],
  ["BATT_B_V", "g", 0],
  ["BATT_V", "g", 381],
  ["SatelliteXAxisAcceleration", "g", 2044],
  ["SatelliteYAxisAcceleration", "g", 2048],
  ["SatelliteZAxisAcceleration", "g", 2181],
  ["TOTAL_BATT_I", "N", 2380],
  ["Temperature", "g", 299],
  ["PANEL_PLUS_X_V", "g", 388],
  ["PANEL_MINUS_X_V", "g", 130],
  ["PANEL_PLUS_Y_V", "g", 104],
  ["PANEL_MINUS_Y_V", "g", 398],
  ["PANEL_PLUS_Z_V", "g", 48],
  ["PANEL_MINUS_Z_V", "g", 89],
  ["PANEL_PLUS_X_I", "N", 2048],
  ["PANEL_MINUS_X_I", "N", 2048],
  ["PANEL_PLUS_Y_I", "N", 2048],
  ["PANEL_MINUS_Y_I", "N", 2050],
  ["PANEL_PLUS_Z_I", "N", 2048],
  ["PANEL_MINUS_Z_I", "N", 2048],
  ["PSUVoltage", "g", 505],
  ["SPIN", "n", 2048],
  ["Pressure", "N", 1005],
  ["Altitude", "N", 703],
  ["Resets", "n", 0],
  ["RSSI", "n", 2048],
  ["IHUTemperature", "g", 444],
  ["SatelliteXAxisAngularVelocity", "n", 2048],
  ["SatelliteYAxisAngularVelocity", "n", 2048],
  ["SatelliteZAxisAngularVelocity", "n", 2055],
  ["Humidity", "g", 15],
  ["PSUCurrent", "N", 2263],
  ["Sensor1", "g", 2048],
  ["Sensor2", "N", 2048],
  ["STEMPayloadStatus", "C", 1],
  ["SafeMode", "C", 0],
  ["SimulatedTelemetry", "C", 1],
  ["PayloadStatus1", "C", 1],
  ["I2CBus0Failure", "C", 0],
  ["I2CBus1Failure", "C", 0],
  ["I2CBus3Failure", "C", 0],
  ["CameraFailure", "C", 0],
  ["GroundCommands", "N", 0],
  ["RXAntenna", "C", 1],
  ["TXAntenna", "C", 1],
]

formats = []
values = []

mock_data.each do |item|
  formats.push(item[1])
  values.push(item[2])
end

data = values.pack(formats.join())

socket = TCPSocket.new("127.0.0.1", 8081)
socket.write(data)
socket.flush
socket.close
