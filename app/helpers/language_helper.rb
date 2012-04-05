module LanguageHelper
  def pluralize_pages(n)
    case n
    when 0
      "nobene strani"
    when 1
      "eno stran"
    when 2
      "dve strani"
    else
      "#{n} strani"
    end    
  end

  def pluralize_page_kinds(n)
    case n
    when 0
      "nobene tipične strani"
    when 1
      "eno tipično stran"
    when 2
      "dve tipični strani"
    else
      "#{n} tipičnih strani"
    end    
  end
  
  def pluralize_sections(n)
    case n
    when 0
      "nobene sekcije"
    when 1
      "eno sekcijo"
    when 2
      "dve sekciji"
    when 3
      "#{n} sekcije"
    else
      "#{n} sekcij"
    end
  end
  
  def pluralize_orders(n)
    case n
    when 0
      "nobenega naročila"
    when 1
      "eno naročilo"
    when 2
      "dva naročila"
    when 3..4
      "#{n} naročila"
    else
      "#{n} naročil"
    end
  end
  
  def format_user_kind(kind)
    case kind.kind
    when "admin"
      "Administrator"
    when "reviewer"
      "Lektor"
    when "designer"
      "Oblikovalec"
    when "editor"
      "Urednik"
    end
  end
  
  def pluralize_prints(n)
    case n
    when 1
      "1 izvod"
    when 2
      "2 izvoda"
    when 3..4
      "#{n} naročila"
    else
      "#{n} izvodov"
    end
  end
end