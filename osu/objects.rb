module Objects
  PADDING = 20
  def menu
    draw_rotating_star_backgrounds

    @text.draw PADDING, PADDING, 0
  end

  def draw_rotating_star_backgrounds
    # Disregard the math in this method, it doesn't look as good as I thought it
    # would. =(

    angle = Gosu.milliseconds / 50.0
    scale = (Gosu.milliseconds % 1000) / 1000.0

    [1, 0].each do |extra_scale|
      @background.draw_rot WIDTH * 0.5, HEIGHT * 0.75, 0, angle, 0.5, 0.5,
        scale + extra_scale, scale + extra_scale
    end
  end
end
