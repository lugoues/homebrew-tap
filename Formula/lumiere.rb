# Bluetooth TCC requires a LaunchAgent: use brew services WITHOUT sudo. With
# sudo Homebrew creates a LaunchDaemon, which macOS never grants Bluetooth.
class Lumiere < Formula
  desc "Daemon and web UI for controlling Neewer BLE lights"
  homepage "https://github.com/lugoues/lumiere"
  url "https://github.com/lugoues/lumiere/releases/download/v0.1.1/lumiere-0.1.1-aarch64-apple-darwin.tar.gz"
  sha256 "89df0d9222805f7c9588de645a05728859bda13177ae6ade17e4d3b370e8d7f6"
  version "0.1.1"

  def install
    bin.install "lumiere-daemon"
    bin.install "lumiere"
  end

  service do
    run [opt_bin/"lumiere-daemon"]
    keep_alive true
    log_path var/"log/lumiere.log"
    error_log_path var/"log/lumiere.log"
    environment_variables PATH: std_service_path_env,
                          LUMIERE_CONFIG_DIR: var/"lumiere/config",
                          LUMIERE_DATA_DIR: var/"lumiere/data"
  end

  test do
    assert_match "lumiere probe", shell_output("#{bin}/lumiere 2>&1", 1)
  end
end
