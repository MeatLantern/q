class AddCreatorToTransformation < ActiveRecord::Migration
  def change
  	add_column :transformations, :creator, :string
  	tfs = Transformation.all
  	tfs.each do |tf|
      if tf.nil?
  		  
      else
        #Transformation.delete(tf)
        if tf.character.nil?
          #Transformation.delte(tf)
        else
          creator = tf.character.creator
          tf.creator = creator
          upvotes = tf.character.upvotes
          tf.upvotes = upvotes
          tf.save
        end
 
      end
  	end
  end
end
