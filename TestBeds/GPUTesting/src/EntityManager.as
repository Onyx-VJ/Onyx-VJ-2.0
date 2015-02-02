// Stage3D Shoot-em-up Tutorial Part 1
// by Christer Kaitila - www.mcfunkypants.com

// EntityManager.as
// The entity manager handles a list of all known game entities.
// This object pool will allow for reuse (respawning) of
// sprites: for example, when enemy ships are destroyed,
// they will be re-spawned when needed as an optimization 
// that increases fps and decreases ram use.
// This is where you would add all in-game simulation steps,
// such as gravity, movement, collision detection and more.

package
{
	import flash.display.Bitmap;
	import flash.display3D.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class EntityManager
	{
		// the sprite sheet image
		private var _spriteSheet : LiteSpriteSheet;
		private const SpritesPerRow:int = 8;
		private const SpritesPerCol:int = 8;
		[Embed(source="../assets/spritesheet.png")]
		private var SourceImage : Class;
		
		// a reusable pool of entities
		private var _entityPool : Vector.<Entity>;
		
		// all the polygons that make up the scene
		public var _batch : LiteSpriteBatch;
		
		// for statistics
		public var numCreated : int = 0;
		public var numReused : int = 0;
		
		private var maxX:int;
		private var minX:int;
		private var maxY:int;
		private var minY:int;
		
		public function EntityManager(view:Rectangle)
		{
			_entityPool = new Vector.<Entity>();
			setPosition(view);	
		}
		
		public function setPosition(view:Rectangle):void 
		{
			// allow moving fully offscreen before looping around
			maxX = view.width + 32;
			minX = view.x - 32;
			maxY = view.height;
			minY = view.y;
		}
		
		public function createBatch(context3D:Context3D) : LiteSpriteBatch 
		{
			var sourceBitmap:Bitmap = new SourceImage();

			// create a spritesheet with 8x8 (64) sprites on it
			_spriteSheet = new LiteSpriteSheet(sourceBitmap.bitmapData, 4, 7);
			
			// Create new render batch 
			_batch = new LiteSpriteBatch(context3D, _spriteSheet);
			
			return _batch;
		}
		
		// search the entity pool for unused entities and reuse one
		// if they are all in use, create a brand new one
		public function respawn(sprID:uint=0):Entity
		{
			var currentEntityCount:int = _entityPool.length;
			var anEntity:Entity;
			var i:int = 0;
			// search for an inactive entity
			for (i = 0; i < currentEntityCount; i++ ) 
			{
				anEntity = _entityPool[i];
				if (!anEntity.active && (anEntity.sprite.spriteId == sprID))
				{
					//trace('Reusing Entity #' + i);
					anEntity.active = true;
					anEntity.sprite.visible = true;
					numReused++;
					return anEntity;
				}
			}
			// none were found so we need to make a new one
			//trace('Need to create a new Entity #' + i);
			var sprite:LiteSprite;
			sprite = _batch.createChild(sprID);
			anEntity = new Entity(sprite);
			_entityPool.push(anEntity);
			numCreated++;
			return anEntity;
		}
		
		// for this test, create random entities that move 
		// from right to left with random speeds and scales
		public function addEntity(numEntities:int = 1):void 
		{
			
			while (numEntities--) {
				
				var anEntity:Entity;
				var randomSpriteID:uint = 0; //Math.floor(Math.random() * 64);
				// try to reuse an inactive entity (or create a new one)
				anEntity = respawn(randomSpriteID);
				// give it a new position and velocity
				anEntity.sprite.position.x = maxX;
				anEntity.sprite.position.y = Math.random() * maxY;
				anEntity.speedX = (-1 * Math.random() * 10) - 2;
				anEntity.speedY = (Math.random() * 5) - 2.5;
				anEntity.sprite.scaleX = 0.5 + Math.random() * 1.5;
				anEntity.sprite.scaleY = anEntity.sprite.scaleX;
				anEntity.sprite.rotation = 0;// 15 - Math.random() * 30;
			}
		}
		
		// called every frame: used to update the simulation
		// this is where you would perform AI, physics, etc.
		public function update(currentTime:Number) : void {
			
			var anEntity:Entity;
			for(var i:int=0; i<_entityPool.length;i++)
			{
				anEntity = _entityPool[i];
				if (anEntity.active)
				{
					anEntity.sprite.position.x += anEntity.speedX;
					anEntity.sprite.position.y += anEntity.speedY;
					anEntity.sprite.rotation += 0.1;
					
					if (anEntity.sprite.position.x > maxX)
					{
						anEntity.speedX *= -1;
						anEntity.sprite.position.x = maxX;
					}
					else if (anEntity.sprite.position.x < minX)
					{
						// if we go past the left edge, become inactive
						// so the sprite can be respawned
						anEntity.die();
					}
					if (anEntity.sprite.position.y > maxY)
					{
						anEntity.speedY *= -1;
						anEntity.sprite.position.y = maxY;
					}
					else if (anEntity.sprite.position.y < minY)
					{
						anEntity.speedY *= -1;
						anEntity.sprite.position.y = minY;
					}
				}
			}
		}
	} // end class
} // end package