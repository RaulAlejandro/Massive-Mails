# encoding: utf-8
class SystemMailer < ActionMailer::Base
  default from: "no-reply@defensapublica.gob.ve"

=begin
  def tsa_de_tin_usuario( registro )
    @registro = registro
    mail(to:      'servidores@defensapublica.gob.ve',
         cc:      'sistemas@defensapublica.gob.ve',
         subject: 'Nuevos trabajadores Ingresados, Egresados o Jubilados')
  end
=end

  def tsa_de_tin_usuario( archivo )
    attachments["trabajadores_ing_egr_jub_tra.csv"] = archivo

    mail(to:      'servidores@defensapublica.gob.ve',
         cc:      'sistemas@defensapublica.gob.ve',
         subject: 'Nuevos trabajadores Ingresados, Egresados o Jubilados')
  end


  def dependencias_sin_padre( registro )
    @registro = registro
    mail(to:      'ruben.bernal@defensapublica.gob.ve,',
  ##concatena con simbolo + y a continuación se coloca la otradirección de correo, Ejemplo:
                  #+
                  #'mileidy.linares@defensapublica.gob.ve',

         cc:      'sistemas@defensapublica.gob.ve,' <<
                  'drisley.triana@defensapublica.gob.ve',
         subject: 'Dependencias subordinadas sin Dependencia padre')
  end


  def coord_regionales_delegados_sin_encargaduria( registro )
    @registro = registro
    mail(to:      'analiesse.tarre@defensapublica.gob.ve,'+
                  'ruben.bernal@defensapublica.gob.ve,',
                  #+
                  # 'mileidy.linares@defensapublica.gob.ve',
         cc:      'gabriel.cedeno@defensapublica.gob.ve,'+
                  'patricia.hernandez@defensapublica.gob.ve,'+
                  'sistemas@defensapublica.gob.ve,' <<
                  'drisley.triana@defensapublica.gob.ve',
         subject: 'Coordinadores o Delegados sin Encargaduría aparente')
  end


  def jueves_resultas_atrasadas_ccs( registro )
    @registro = registro
    mail(to:      #'yepemirx@tsj-dem.gob.ve,' +
                  'gomimari@tsj-dem.gob.ve,' +
                  'emmanuel.marcano@defensapublica.gob.ve,' +
                  'jmpr8804@hotmail.com,',
         cc:      'analiesse.tarre@defensapublica.gob.ve,' +
                  'patricia.hernandez@defensapublica.gob.ve,' +
                  'gabriel.cedeno@defensapublica.gob.ve,' +
                  'sistemas@defensapublica.gob.ve',
         subject: 'Agenda Única: Audiencias Realizadas Sin Resultas')
  end



  def sigefirrhh_vacio
    mail(to:      'servidores@defensapublica.gob.ve',
         cc:      'sistemas@defensapublica.gob.ve',
         subject: 'Problemas en el Respaldo Nocturno')
  end


  def agenda_unica_registros_semanales(archivo, desde, hasta)
    @desde = desde
    @hasta = hasta

    attachments["actos_agendados_del_#{desde}_al_#{hasta}.csv"] = archivo
=begin
    mail(to:      "Maria Victoria Idrobo <odromaro@tsj\-dem.gob.ve>,
                   Hugo Barbagallo <hbarbagallo@tsj\-dem.gob.ve>",
         cc:      "Hector Depablos <hdepablos@tsj\-dem.gob.ve>,
                   Ana Zambrano <zambanac@tsj\-dem.gob.ve>,
                   Marinellys Eladia Figueroa <mfigueroa@tsj\-dem.gob.ve>,
                   Fabiola Parra <fparra@tsj\-dem.gob.ve>,
                   dba@mp.gob.ve,
                   sistemas@defensapublica.gob.ve",
         subject: "Señalamientos de audiencias del #{desde} al #{hasta}")
=end
=begin
    mail(to:      'Maria Victoria Idrobo <odromaro@tsj-d-e-m.gob.ve>,
                   Hugo Barbagallo <hbarbagallo@tsj-d-e-m.gob.ve>',
         cc:      'Hector Depablos <hdepablos@tsj-d-e-m.gob.ve>,
                   Ana Zambrano <zambanac@tsj-d-e-m.gob.ve>,
                   Marinellys Eladia Figueroa <mfigueroa@tsj-d-e-m.gob.ve>,
                   Fabiola Parra <fparra@tsj-d-e-m.gob.ve>,
                   dba@-m-p-.gob.ve,
                   carlos.bagnoli@defensapublica.gob.ve',
         subject: "Señalamientos de audiencias del #{desde} al #{hasta}")
=end
    mail(to:      'Maria Victoria Idrobo <odromaro@tsj-dem.gob.ve>,'+
                  'Hugo Barbagallo <hbarbagallo@tsj-dem.gob.ve>',
         cc:      'Hector Depablos <hdepablos@tsj-dem.gob.ve>,' +
                  'Ana Zambrano <zambanac@tsj-dem.gob.ve>,' +
                  'Marinellys Eladia Figueroa <mfigueroa@tsj-dem.gob.ve>,' +
                  'sistemas@defensapublica.gob.ve',
         subject: "Señalamientos de audiencias del #{desde} al #{hasta}")
  end


  def dossier_noticias(e)

    #puts emails
    emails = e.collect(&:correo_inst).join(",")
    
    #emails.each do |v|

     # ok = "'#{v.correo_inst}'"

      #puts ok

      mail(to: ' ',
           #bcc:      emails,
           bcc:      'funcionarios@defensapublica.gob.ve',
           subject: "Asunto:  Dossier de Noticias Diario DP")

    #end

  end

end
