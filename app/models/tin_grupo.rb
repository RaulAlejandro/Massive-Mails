class TinGrupo < ActiveRecord::Base

  #establish_connection "intranet_#{Rails.env}".to_sym

  establish_connection :intranet     
  self.table_name = 'tin_grupos'

  has_many :tin_sistemas_grupos, foreign_key: :grupo_id

  # Estos métodos garantizan que la tabla o modelo se utilice solo como LECTURA
  def readonly? #---------------------------------------------------------------------------------------------------------
    true
  end

  def self.delete_all #---------------------------------------------------------------------------------------------------
    raise ActiveRecord::ReadOnlyRecord
  end

  def destroy #-----------------------------------------------------------------------------------------------------------
    raise ActiveRecord::ReadOnlyRecord
  end

  def delete #------------------------------------------------------------------------------------------------------------
    raise ActiveRecord::ReadOnlyRecord
  end  
  
  def self.buscar_grupo(sistema_id, usuario_id) #-------------------------------------------------------------------------------------

    # RAILS 4
      select( "descripcion AS grupo, estatus" ).
      joins( tin_sistemas_grupos: :tin_usuarios_grupos ).
      where( [ "sistema_id = ? AND usuario_id = ?", sistema_id, usuario_id ] )

  end


    # def admin?
    #    self.role.name ==  "ADMINISTRADOR"
    # end

    # def defensor?
    #     self.role.descripcion == "DEFENSOR"
    # end

    # def user?
    #     self.role.descripcion == "USUARIO"
    # end

    # def desarrollador?
    #     self.role.descripcion == "DESARROLLADOR"
    # end

  
end
