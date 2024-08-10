require 'socket'

# Example string from FoxTelem logs
# 20240803012906,7,23,971,1,0,0,349,2048,2048,2048,2073,0,110,47,91,170,15,108,2048,2183,2048,2103,2048,2053,500,2048,0,0,0,2048,365,2048,2048,2048,0,2208,2048,2048,1,0,1,0,1,0,1,1,0,1,1,0
# See https://ruby-doc.org/current/packed_data_rdoc.html for encoding definitions
FORMAT = [
  # ["RECEIVE_TIME", "AAAAAAAAAAAAAA"], # YYYYMMDDHHMMSS in UTC. This is not currently being parsed due to string convertion issues between Ruby pack and OpenC3
  ["FOX_ID", "C"],
  ["EPOCH", "C"],
  ["UPTIME", "L"],
  ["ID", "C"],
  ["BATT_A_V", "g"],
  ["BATT_B_V", "g"],
  ["BATT_V", "g"],
  ["SatelliteXAxisAcceleration", "g"],
  ["SatelliteYAxisAcceleration", "g"],
  ["SatelliteZAxisAcceleration", "g"],
  ["TOTAL_BATT_I", "N"],
  ["Temperature", "g"],
  ["PANEL_PLUS_X_V", "g"],
  ["PANEL_MINUS_X_V", "g"],
  ["PANEL_PLUS_Y_V", "g"],
  ["PANEL_MINUS_Y_V", "g"],
  ["PANEL_PLUS_Z_V", "g"],
  ["PANEL_MINUS_Z_V", "g"],
  ["PANEL_PLUS_X_I", "N"],
  ["PANEL_MINUS_X_I", "N"],
  ["PANEL_PLUS_Y_I", "N"],
  ["PANEL_MINUS_Y_I", "N"],
  ["PANEL_PLUS_Z_I", "N"],
  ["PANEL_MINUS_Z_I", "N"],
  ["PSUVoltage", "g"],
  ["SPIN", "n"],
  ["Pressure", "N"],
  ["Altitude", "N"],
  ["Resets", "n"],
  ["RSSI", "n"],
  ["IHUTemperature", "g"],
  ["SatelliteXAxisAngularVelocity", "n"],
  ["SatelliteYAxisAngularVelocity", "n"],
  ["SatelliteZAxisAngularVelocity", "n"],
  ["Humidity", "g"],
  ["PSUCurrent", "N"],
  ["Sensor1", "g"],
  ["Sensor2", "N"],
  ["STEMPayloadStatus", "C"],
  ["SafeMode", "C"],
  ["SimulatedTelemetry", "C"],
  ["PayloadStatus1", "C"],
  ["I2CBus0Failure", "C"],
  ["I2CBus1Failure", "C"],
  ["I2CBus3Failure", "C"],
  ["CameraFailure", "C"],
  ["GroundCommands", "N"],
  ["RXAntenna", "C"],
  ["TXAntenna", "C"],
].collect(&:last).join()

def detect_file()
  (Dir.glob("FOXDB/FOX7rttelemetry*.log") + Dir.glob("FOXDB/FOX99rttelemetry*.log")).max_by {|f| File.mtime(f)}
end

def open_file(path)
  puts("Tailing #{path} for real-time telemetry")
  File.open(path)
end

def upload(data)
  puts("Sending telemetry packet to OpenC3")

  retries = 0
  begin
    @socket ||= TCPSocket.new("openc3-operator", 8081)
    @socket.write(data)
    @socket.flush
  rescue => error
    puts(error)
    @socket.close unless @socket.nil?
    @socket = nil
    retry unless (retries += 1) > 1
  end
end

def process_data(payload)
  fields = payload.split(",").map { |s| s.to_i }
  fields[1..-2].pack(FORMAT) # Last value always needs to be stripped off as it is the padding value. First value is currently being stripped due to string conversion isssues, see RECEIVE_TIME
end

# Wait for telemetry file to be available
while detect_file().nil?
  sleep(1)
end

file = open_file(detect_file())

while true
  while line = file.gets
    upload(process_data(line))
    sleep(0.1) # allow OpenC3 to detect packet boundry
  end

  sleep(1)

  newest_telemetry_file = detect_file()
  if file.path != newest_telemetry_file
    file.close
    file = open_file(newest_telemetry_file)
  end
end
