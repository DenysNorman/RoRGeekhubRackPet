class Pet
  def initialize(name)
    @name = name
    @links = "<a href='/feed'>Feed #{@name}</a> |
                <a href='/play'>Play with #{@name}</a> |
                <a href='/putToBed'>Put #{@name} to bed</a> |
                <a href='/wakeUp'>Wake a #{@name}</a> |
                <a href=' /stroking'>Stroking #{@name}</a> |
                <a href='/scare'>Scare #{@name}</a> |
                <a href='/wash'>Wash #{@name}</a> |
                <a href='/walk'>Walk with #{@name}</a> |"
    @param = [10, false, 10, 0] # health | asleep | stuffInBelly | excitement
  end

  def put_param
    "Health: #{@param[0]}<br>Food: #{@param[2]}<br>Excitement: #{@param[3]}"
    end

  def sleep
    [200, { 'Content-Type' => 'text/html' }, [" #{@links} <br> #{put_param}
      <br>Attention: #{@name} sleep
      <br>
      <img src='http://www.cats.org.uk/uploads/images/news/eacdeea1-66e4-4dbe-9b0b-d8bfdd4b8f0e.jpg'>"]]
    end

  def wants
    if @param[0] <= 0
      @status = "#{@name} was dead"
      @statusImage = "<br><img src='http://bestauto74.ru/image/catalogs/accessory/87344.jpg'>"
    elsif @param[2] <= 3
      @param[0] -= 2
      @status = "#{@links} <br>#{put_param}<br>Attention: Feed #{@name}"
      @statusImage = "<br><img src='http://s41.radikal.ru/i093/1301/5b/09c764a82f41.jpg'>"

    elsif @param[3] < 0
      @param[0] -= 2
      @status = "#{@links} <br>#{put_param}<br>Attention: Put #{@name} to bad"
      @statusImage = "<br><img src='http://i.sibstik.ru/u/c8/97ef8e7fab11e5a4dff3ff2fddd179/-/kot-sonja-450x450.svg.png'>"
    elsif @param[3] > 5
      @param[0] -= 2
      @status = " #{@links} <br>#{put_param}<br>Attention: Walk or play with #{@name}"
      @statusImage = "<br> <img src='http://cstor.nn2.ru/userfiles/data/ufiles/1/9/31/25/9312575.saymon_deret_stenu_s_carapkami.jpg'>"
    else
      @status = " #{@links} <br>#{put_param}"
    end
    [200, { 'Content-Type' => 'text/html' }, ["#{@status}  #{@statusImage}"]]
  end

  def call(env)
    req = Rack::Request.new(env)

    case req.path_info
      when /main/
        [200, { 'Content-Type' => 'text/html' }, ["Welcome! What you wand to do with #{@name} <br>#{@links}"]]

      when /feed/
        if @param[1]
          sleep
        else
        if @param[0] < 10
          @param[0] += 1
        end
        @param[2] = 10
        @param[3] += 1
        @statusImage = "<br><img src='http://poletelo.ru/image/cache/data/goods/nakleyki-na-avto/kot-saymona/538-kot-saymona-est-konservy.svg-500x500.png'>"
        wants
        end
      when /play/
        if @param[1]
          sleep
        else
        @param[2] -= 1
        @param[3] -= 3
        @statusImage = "<br><img src='https://h-a.d-cd.net/6aeb34u-480.jpg'>"
        wants
        end
      when /putToBed/
        if @param[1]
          sleep
        else
        if @param[3] <= 0
          if @param[0] < 10
            @param[0] += 1
          end
          @param[1] = true
          @param[2] -= 1
          @param[3] = 0
          @statusImage = "<br><img src='http://www.cats.org.uk/uploads/images/news/eacdeea1-66e4-4dbe-9b0b-d8bfdd4b8f0e.jpg'>"
          wants
        else
          [200, { 'Content-Type' => 'text/html' }, [" #{@links} <br> #{put_param}<br>Attention: #{@name} dont want to sleep
            <br><img src='https://avatanplus.com/files/resources/original/56781d50ce8e5151c53283ce.png'>"]]
        end
        end
      when /wakeUp/
        if @param[1]
          @param[1] = false
          @param[3] += 1
          @statusImage = "<br><img src='http://kohuku.ru/uploads/forum/images/2014-03/139627568344788404a9a7eee60c80ad849e3efb7b.png'>"
          wants
        else
          [200, { 'Content-Type' => 'text/html' }, [" #{@links} <br> #{put_param}<br>Attention: #{@name} not sleep
          <br><img src='https://avatanplus.com/files/resources/original/56781d50ce8e5151c53283ce.png'>"]]
        end
      when /stroking/
        if @param[1]
          [200, { 'Content-Type' => 'text/html' } , [" #{@links} <br> #{put_param}<br>Attention: #{@name} purring and snorting
            <br><img src='http://www.cats.org.uk/uploads/images/news/eacdeea1-66e4-4dbe-9b0b-d8bfdd4b8f0e.jpg'>"]]
        else
          @param[3] += 1
          @param[2] -= 1
          @statusImage = "<br><img src ='http://s1.maminklub.lv/cache/4d/8e/4d8e710b0d05983704c638583d5db2cf.jpg'>"
          wants
        end
      when /scare/
        @param[0] -= 2
        @param[1] = false
        @param [2] -= 1
        @param [3] += 1
        @statusImage = "<br><img src ='http://vape.c10583.shared.hc.ru/assets/img/2.png'>"
        wants
      when /wash/
        if @param[1]
          sleep
        else
          if @param[0] < 10
            @param[0] += 1
          end
          @param [2] -= 1
          @param [3] += 1
          @statusImage = "<br><img src ='http://cs622631.vk.me/v622631306/1a7b4/6a_nVtGJV1s.jpg'>"
          wants
        end
      when /walk/
        if @param[1]
          sleep
        else
          if @param[0] < 10
            @param[0] += 1
          end
          @param [2] -= 1
          @param [3] -= 4
          @statusImage = "<br><img src ='http://cs9952.vkontakte.ru/u118457598/l_80c341cb.png'>"
          wants
        end
      else
        [404, { 'Content-Type' => 'text/html' }, ["<a href='/main'>Main menu</a>"]]
    end
  end
end

run Pet.new 'Simon'
