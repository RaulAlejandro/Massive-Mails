class TinUsuario < ActiveRecord::Base
  

    establish_connection :intranet     
    self.table_name = 'tin_usuarios'  
    self.primary_key = :id



    belongs_to  :tin_dependencia ,     foreign_key: :dependencia_id
    has_many    :tin_usuarios_grupos , foreign_key: :usuario_id
  
    
    
    def self.buscarUsuario(usuario, clave)
          where( usuario: usuario,
                 clave:   clave,
                 estatus: "A" ).
          select( "tin_usuarios.id, trabajador_id, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, descripcion_cargo, sexo, descripcion as dependencia" ).
          joins (:tin_dependencia)
    end

    
    def self.get_trabajador(trabajador)
        select( "id").
        where( trabajador_id: trabajador,
               estatus: "A" )
        
    end


    def self.validarUsuario( sistema_id, usuario_id ) #----------------------------------------------------------------------------------------------------------------
        select( " * " ).
        joins( { tin_usuarios_grupos: { tin_sistemas_grupo: :tin_grupo } }).
        #joins( :tin_grupo ).        
        where( "sistema_id = #{sistema_id} and tin_usuarios.id = #{usuario_id}" )
        
    end   

    #  def self.BuscarDependencia(trabajador_id)
    #  	# @trabajador = trabajador_id;
    #   #    	find_by_sql("SELECT tin_dependencias.descripcion as descripcion
		# 	# 		FROM tin_usuarios
		# 	# 		JOIN tin_dependencias
		# 	# 		ON tin_usuarios.dependencia_id=tin_dependencias.dependencia_id
		# 	# 		WHERE tin_usuarios.trabajador_id=#{@trabajador}")

    #   # empleado = Empleado.select("id, nombre, apellido").where(:legajo => params[:legajo]);

    #   # find_by_sql ("SELECT * from tin_usuarios")
    # end 


    # def self.buscar_usuario_clave(usuario, clave) #----------------------------------------------------------------------------------------------------------------
    #   where( usuario: StringMetodos::a_mayusculas(usuario),
    #          clave:   clave,
    #          estatus: 'A' ).
    #   select( "tin_usuarios.id, primer_nombre, primer_apellido, tin_dependencias.id AS dep_id" )
    # end
    
end
