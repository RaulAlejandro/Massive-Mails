# -*- encoding : utf-8 -*-
class Procesos
  
  # rails runner "Procesos.prueba"
  
   #para correr scraut
  #rails running -e production "Proceso.iniciar"
  
  def self.iniciar
#SystemMailer.prueba.deliver!

#    busca_nuevos_ingresos_egresos_jubilados
   # busca_dependencias_sin_padre
    #busca_coord_regionales_delegados
    #lunes_agenda_unica_data_homologar
    #busca_sigefirrhh_vacio
    #jueves_resultas_atrasadas_ccs
    dossier_noticias
    #------------------------------
  end
  

  private
  
  def self.dossier_noticias
    emails = TinUsuario.where(dependencia_id: 2929).distinct  # Solo para probar conexión con BD. Si no hay, dará error y no enviará el correo.
   # emails = TinUsuario.where(id: 9414)  # Solo para probar conexión con BD. Si no hay, dará error y no enviará el correo.
    
    
    SystemMailer.dossier_noticias(emails).deliver!
  end
=begin
  VIEJO
  def self.busca_nuevos_ingresos_egresos_jubilados
    puts '=====>> INICIANDO:  busca_nuevos_ingresos_egresos_jubilados'
    registro = TsaDeTinUsuario.nuevos_registros
    if registro.length > 0
      puts '        Enviará correo.'
      begin
        SystemMailer.tsa_de_tin_usuario(registro).deliver!
        TsaDeTinUsuario.where( id: registro.collect(&:id) ).update_all( enviado: true )
      rescue => e
        puts "Error busca_nuevos_ingresos_egresos_jubilados.<br/>#{e.message}"
      end
    else
      puts '        Sin resultados.'
    end
    puts '<<===== FINALIZADO:  busca_nuevos_ingresos_egresos_jubilados'
  end
=end
  
  def self.jueves_resultas_atrasadas_ccs
    puts '=====>> INICIANDO:  resultas_atrasadas'
    if Date.today.cwday == 4  # Es JUeves
      registro = TsgAgendaAudiencia.jueves_resultas_atrasadas_ccs

      if registro.length > 0
        puts '        Enviará correo.'
        begin
          SystemMailer.jueves_resultas_atrasadas_ccs(registro).deliver!
        rescue => e
          puts "Error resultas_atrasadas.<br/>#{e.message}"
        end
      else
        puts '        Todo bien con las resultas: No hay resultadas atrasadas.'
      end
    else
      puts '        No es jueves.'
    end
    puts '<<===== FINALIZADO:  resultas_atrasadas'
  end
  
=begin
  # NUEVO
  def self.busca_nuevos_ingresos_egresos_jubilados
    puts '=====>> INICIANDO:  busca_nuevos_ingresos_egresos_jubilados'
    archivo = TsaDeTinUsuario.nuevos_registros_to_csv

    if archivo.size > 300  # Si el archivo contiene más de 300 caracteres, enviará el correo
      puts '        Enviará correo.'
      begin
        SystemMailer.tsa_de_tin_usuario(archivo).deliver!
        TsaDeTinUsuario.where( enviado: false ).update_all( enviado: true )
      rescue => e
        puts "Error busca_nuevos_ingresos_egresos_jubilados.<br/>#{e.message}"
      end
    else
      puts '        Sin resultados.'
    end
    puts '<<===== FINALIZADO:  busca_nuevos_ingresos_egresos_jubilados'
  end
=end
  
  # Envía un correo a RRHH (Cesar Sulbaran) de las dependencias (tin_dependencias) sin padre (padre_id)
  def self.busca_dependencias_sin_padre
    puts '=====>> INICIANDO:  busca_dependencias_sin_padre'
    registro = TinDependencia.dependencias_sin_padre
    registro = Dependencia.dependencias_sin_padre  if registro.blank?
    if registro.length > 0
      puts '        Enviará correo.'
      begin
        SystemMailer.dependencias_sin_padre(registro).deliver!
      rescue => e
        puts "Error busca_dependencias_sin_padre.<br/>#{e.message}"
      end
    else
      puts '        Sin resultados.'
    end
    puts '<<===== FINALIZADO:  busca_dependencias_sin_padre'
  end
  
  # Busca que los usuarios con grupo Coordinador Regional y Delegado Extensión tengan el cargo y dependencia adecuados
  def self.busca_coord_regionales_delegados
    puts '=====>> INICIANDO:  busca_coord_regionales_delegados'
    registro = TinUsuario.coord_regionales_delegados_sin_encargaduria
    if registro.length > 0
      puts '        Enviará correo.'
      begin
        SystemMailer.coord_regionales_delegados_sin_encargaduria(registro).deliver!
      rescue => e
        puts "Error busca_coord_regionales_delegados.<br/>#{e.message}"
      end
    else
      puts '        Sin resultados.'
    end
    puts '<<===== FINALIZADO:  busca_coord_regionales_delegados'
  end
  
  # Envía un correo a la DEM y MP de los actos agendados la semana pasada
  def self.lunes_agenda_unica_data_homologar
    puts '=====>> INICIANDO:  lunes_agenda_unica_data_homologar'
    if Date.today.cwday == 1  # Es Lunes
      hasta   = (Date.today - 1).strftime("%d-%m-%Y")  # Domingo
      desde   = (Date.today - 7).strftime("%d-%m-%Y")  # Lunes anterior
      archivo = TsgReservaAudiencia.registros_semanales_to_csv(desde, hasta)

      if archivo.size > 0
        puts '        Enviará correo.'
        begin
          SystemMailer.agenda_unica_registros_semanales(archivo, desde, hasta).deliver!
        rescue => e
          puts "Error lunes_agenda_unica_data_homologar.<br/>#{e.message}"
        end
      else
        puts '        Sin resultados.'
      end
    else
      puts '        No es lunes.'
    end
    puts '<<===== FINALIZADO:  lunes_agenda_unica_data_homologar'
  end
  
  def self.busca_sigefirrhh_vacio
    puts '=====>> INICIANDO:  busca_sigefirrhh_vacio'
    if Trabajador.count < 7000
      puts '        Enviará correo.'
      begin
        SystemMailer.sigefirrhh_vacio.deliver!
      rescue => e
        puts "Error busca_sigefirrhh_vacio.<br/>#{e.message}"
      end
    else
      puts '        Sin resultados.'
    end
    puts '<<===== FINALIZADO:  busca_sigefirrhh_vacio'
  end
  
end


