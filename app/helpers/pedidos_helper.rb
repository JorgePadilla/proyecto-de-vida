module PedidosHelper
  def getMesString mes_dia
    if mes_dia == 1
      return "Enero"
    end
    if mes_dia == 2
      return "Febrero"
    end
    if mes_dia == 3
      return "Marzo"
    end
    if mes_dia == 4
      return "Abril"
    end
    if mes_dia == 5
      return "Mayo"
    end
    if mes_dia == 6
      return "Junio"
    end
    if mes_dia == 7
      return "Julio"
    end
    if mes_dia == 8
      return "Agosto"
    end
    if mes_dia == 9
      return "Septiembre"
    end
    if mes_dia == 10
      return "Octubre"
    end
    if mes_dia == 11
      return "Noviembre"
    end
    if mes_dia == 12
      return "Diciembre"
    end
    return "error"
  end
end
