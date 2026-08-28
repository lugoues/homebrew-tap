# Bluetooth TCC requires a LaunchAgent: use brew services WITHOUT sudo. With
# sudo Homebrew creates a LaunchDaemon, which macOS never grants Bluetooth.
class Lumiere < Formula
  desc "Daemon and web UI for controlling Neewer BLE lights"
  homepage "https://github.com/lugoues/lumiere"
  url "https://github.com/lugoues/lumiere/releases/download/v1.2.0/lumiere-1.2.0-aarch64-apple-darwin.tar.gz"
  sha256 "b02096c4c753b822756d0cbd08e80aa98b6211869b77d1b70938f20890b49a31"
  version "1.2.0"

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
