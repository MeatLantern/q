class AddCreatorToTransformation < ActiveRecord::Migration
  def change
  	add_column :transformations, :creator, :string
  	tfs = Transformation.all
  	tfs.each do |tf|
      if tf.character != nil?
  		  tf.creator = tf.character.creator
  		  upvotes = tf.character.upvotes
  		  tf.upvotes = upvotes
  		  tf.save
      else
        Transformation.delete(tf)
      end
  	end
  end
end
