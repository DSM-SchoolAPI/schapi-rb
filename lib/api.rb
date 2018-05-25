module Schapi
    module Kind
        KINDERGARTEN = 1
        ELEMENTARY = 2
        MIDDLE = 3
        HIGH = 4
    end

    module Region
        SEOUL = 'stu.sen.go.kr'
        BUSAN = 'stu.pen.go.kr'
        DAEGU = 'stu.dge.go.kr'
        INCHEON = 'stu.ice.go.kr'
        GWANGJU = 'stu.gen.go.kr'
        DAEJEON = 'stu.dje.go.kr'
        ULSAN = 'stu.use.go.kr'
        SEJONG = 'stu.sje.go.kr'
        GYEONGGI = 'stu.cbe.go.kr'
        KANGWON = 'stu.kwe.go.kr'
        CHUNGBUK = 'stu.cbe.go.kr'
        CHUNGNAM = 'stu.cne.go.kr'
        JEONBUK = 'stu.jbe.go.kr'
        JEONNAM = 'stu.jne.go.kr'
        GYEONGBUK = 'stu.gbe.go.kr'
        GYEONGNAM = 'stu.gne.go.kr'
        JEJU = 'stu.jje.go.kr'
    end

    module URL
        MONTHLY_MENUS = 'http://%s/sts_sci_md00_001.do?schulCode=%s&schulCrseScCode=%d&schulCrseScScore=%02d&schYm=%d%02d'
    end

    class SchoolAPI
        require 'nokogiri'
        require 'open-uri'
        require File.dirname(__FILE__) + '/domain'

        def initialize(kind, region, code)
            @kind = kind
            @region = region
            @code = code
        end
        
        def get_monthly_menus_url(year, month)
            return URL::MONTHLY_MENUS % [@region, @code, @kind, @kind, year, month]
        end

        def get_menu_hash_from_data(data)
            menu = Hash.new
            chunks = data.scan(/[가-힣]+\([가-힣]+\)|[가-힣]+/)
            
            timings = ['조식', '중식', '석식']
            timing = 0
            
            chunks.each do |t|
                if t.match /[조중석]식/
                    timing = timings.index(t)
                    menu[timing] = Array.new
                else
                    menu[timing].push(t)
                end
            end

            return menu
        end

        def get_monthly_menus_from_doc(doc) 
            menus = Hash.new

            doc.css('.tbl_calendar.tbl_type3 td').select{ |e| e.text != ' ' }.each.with_index do |e, i|
                menus[i + 1] = self.get_menu_hash_from_data(e.text)
            end

            return menus
        end

        def get_monthly_menus(year, month)
            menus = Hash.new
            doc = Nokogiri::HTML open(self.get_monthly_menus_url(year, month))
            
            self.get_monthly_menus_from_doc(doc).each_pair do |d, m|
                breakfast, lunch, dinner = m[0], m[1], m[2]
                menus[d] = Menu.new breakfast, lunch, dinner
            end

            return menus
        end
    end
end