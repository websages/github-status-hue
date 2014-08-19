class Hue
  include HTTParty

  CONTROL_ADDRESS = 'https://www.meethue.com/api/sendmessage'
  STATUS_ADDRESS  = 'https://www.meethue.com/api/getbridge'

  RED         = 0
  YELLOW      = 12750
  LIGHT_GREEN = 25500
  GREEN       = 36210
  BLUE        = 46920
  PURPLE      = 56100

  attr_reader :bridge_id, :access_token

  def initialize(bridge_id, access_token)
    @bridge_id    = bridge_id
    @access_token = access_token
  end

  def pulse_color(light, color)
    state = {
      'on'    => true,
      'bri'   => 255,
      'alert' => 'lselect',
      'sat'   => 255,
      'hue'   => color,
    }

    send_command("lights/#{light}/state", 'PUT', state.to_json)
  end

  def get_status
    response = HTTParty.get(STATUS_ADDRESS, {
      :headers  => { 'content-type' => 'application/x-www-form-urlencoded' },
      :query    => { :bridgeid => bridge_id, :token => access_token },
    })
  end

  def send_command(api, method, command)
    response = HTTParty.post(CONTROL_ADDRESS, {
      :headers  => { 'content-type' => 'application/x-www-form-urlencoded' },
      :query    => { 'token' => access_token },
      :body     => "clipmessage={ bridgeId: \"#{bridge_id}\", clipCommand: { url: \"/api/0/#{api}\", method: \"#{method}\", body: #{command} } }",
    })
  end
end
