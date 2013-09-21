package app.theme
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import app.display.screen.MixScreen;
	import app.display.screen.PersListScreen;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class SerendipiTheme extends DisplayListWatcher
	{
		[Embed(source="/../assets/images/serendipi_calline.png")]
		protected static const ATLAS_IMAGE:Class;
		
		[Embed(source="/../assets/images/serendipi_calline.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;
		
		[Embed(source="/../assets/fonts/SourceSansPro-Regular.ttf",fontName="SourceSansPro",mimeType="application/x-font",embedAsCFF="false")]
		protected static const SOURCE_SANS_PRO_REGULAR:Class;
		
		[Embed(source="/../assets/fonts/SourceSansPro-Bold.ttf",fontName="SourceSansProBold",fontWeight="bold",mimeType="application/x-font",embedAsCFF="false")]
		protected static const SOURCE_SANS_PRO_BOLD:Class;
		
		[Embed(source="/../assets/fonts/SourceSansPro-BoldIt.ttf",fontName="SourceSansProBoldItalic",fontWeight="bold",fontStyle="italic",mimeType="application/x-font",embedAsCFF="false")]
		protected static const SOURCE_SANS_PRO_BOLD_ITALIC:Class;

		
		protected static const LIST_ITEM_RENDERER_NAME:String = "traintimes-times-list-item-renderer";
		
		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;
		
		protected static const HEADER_SCALE9_GRID:Rectangle = new Rectangle(0, 0, 4, 5);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;
		
		protected static const PRIMARY_TEXT_COLOR:uint = 0xffffff;
		protected static const DETAIL_TEXT_COLOR:uint = 0x64908a;
		
		protected var scale:Number = 1;
		
		protected var primaryBackground:TiledImage;
		
		protected var defaultTextFormat:TextFormat;
		protected var selectedTextFormat:TextFormat;
		protected var headerTitleTextFormat:TextFormat;
		protected var stationListNameTextFormat:TextFormat;
		protected var stationListDetailTextFormat:TextFormat;
		
		protected var atlas:TextureAtlas;
		protected var atlasBitmapData:BitmapData;
		protected var mainBackgroundTexture:Texture;
		protected var headerBackgroundTextures:Scale9Textures;
		protected var stationListNormalIconTexture:Texture;
		protected var stationListFirstNormalIconTexture:Texture;
		protected var stationListLastNormalIconTexture:Texture;
		protected var stationListSelectedIconTexture:Texture;
		protected var stationListFirstSelectedIconTexture:Texture;
		protected var stationListLastSelectedIconTexture:Texture;
		protected var menuIconTexture:Texture;
		protected var editIconTexture:Texture;
		protected var cancelIconTexture:Texture;
		protected var backIconTexture:Texture;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;

		
		

		
		public function SerendipiTheme(container:DisplayObjectContainer = null, scaleToDPI:Boolean = true)
		{
			if(!container)
			{
				container = Starling.current.stage;
			}
			super(container);
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}
		
		protected static function textRendererFactory():ITextRenderer
		{
			const renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.embedFonts = true;
			return renderer;
		}
		protected var _originalDPI:int;
		
		public function get originalDPI():int
		{
			return this._originalDPI;
		}
		
		protected var _scaleToDPI:Boolean;
		
		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}
		
		protected function initialize():void
		{
			const scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			
			this.scale = scaledDPI / this._originalDPI;
			
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			//FeathersControl.defaultTextEditorFactory = textEditorFactory;
			
			//PopUpManager.overlayFactory = popUpOverlayFactory;
			/*Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				Callout.stagePaddingLeft = 16 * this.scale;*/
			
			const atlasBitmapData:BitmapData = (new ATLAS_IMAGE()).bitmapData;
			this.atlas = new TextureAtlas(Texture.fromBitmapData(atlasBitmapData, false), XML(new ATLAS_XML()));
			if(Starling.handleLostContext)
			{
				this.atlasBitmapData = atlasBitmapData;
			}
			else
			{
				atlasBitmapData.dispose();
			}
			
			this.mainBackgroundTexture = this.atlas.getTexture("serendipi_calline_bg");
			this.headerBackgroundTextures = new Scale9Textures(this.atlas.getTexture("serendipi_calline_navigation_bar"), HEADER_SCALE9_GRID);

			this.menuIconTexture = this.atlas.getTexture("serendipi_calline_icon_button_menu");
			this.editIconTexture = this.atlas.getTexture("serendipi_calline_icon_pen");
			
			this.backIconTexture = this.atlas.getTexture("serendipi_calline_icon_button_back");
			/*this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);*/
			
			//we need to use different font names because Flash runtimes seem to
			//have a bug where setting defaultTextFormat on a TextField with a
			//different TextFormat that has the same font name as the existing
			//defaultTextFormat value causes the new TextFormat to be ignored,
			//even if the new TextFormat has different bold or italic values.
			//wtf, right?
			const regularFontName:String = "SourceSansPro";
			const boldFontName:String = "SourceSansProBold";
			const boldItalicFontName:String = "SourceSansProBoldItalic";
			this.defaultTextFormat = new TextFormat(regularFontName, Math.round(44 * this.scale), PRIMARY_TEXT_COLOR);
			this.selectedTextFormat = new TextFormat(boldFontName, Math.round(44 * this.scale), PRIMARY_TEXT_COLOR, true);
			this.headerTitleTextFormat = new TextFormat(regularFontName, Math.round(44 * this.scale), PRIMARY_TEXT_COLOR);
		
			
			if(this.root.stage)
			{
				this.initializeRoot();
			}
			else
			{
				this.root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}
			
			this.setInitializerForClassAndSubclasses(Screen, screenInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Header, header1Initializer);
			this.setInitializerForClass(Label, labelInitializer);
			//this.setInitializerForClass(Button, editButtonInitializer, PersListScreen.EDIT_BUTTON);
			//this.setInitializerForClass(Button, menuButtonInitializer, MixScreen.MIN_BUTTON);
			//this.setInitializerForClass(Header, header1Initializer,  MixScreen.HEADER1);
			this.setInitializerForClass(List, persListInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, persListItemRendererInitializer);
			/*this.setInitializerForClass(Button, nothingInitializer, SimpleScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(Label, stationListNameLabelInitializer, StationListItemRenderer.CHILD_NAME_STATION_LIST_NAME_LABEL);
			this.setInitializerForClass(Label, stationListDetailLabelInitializer, StationListItemRenderer.CHILD_NAME_STATION_LIST_DETAILS_LABEL);
			this.setInitializerForClass(Header, headerInitializer);
			this.setInitializerForClass(List, stationListInitializer, StationScreen.CHILD_NAME_STATION_LIST);
			this.setInitializerForClass(List, timesListInitializer, TimesScreen.CHILD_NAME_TIMES_LIST);
			this.setInitializerForClass(DefaultListItemRenderer, timesListItemRendererInitializer, TIMES_LIST_ITEM_RENDERER_NAME);
			this.setInitializerForClass(StationListItemRenderer, stationListItemRendererInitializer);*/
			
		}
		protected function imageLoaderFactory():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}
		
		private function persListItemRendererInitializer(renderer:DefaultListItemRenderer):void
		{
			const defaultSkin:Quad = new Quad(20 * this.scale, 1 * this.scale, 0x000000);
			defaultSkin.alpha = 1;
			renderer.defaultSkin = defaultSkin;
			
			
			const defaultSelectedSkin:Quad = new Quad( 20* this.scale, 20 * this.scale, 0xcc2a41);
			renderer.defaultSelectedSkin = defaultSelectedSkin;
		
			renderer.defaultLabelProperties.textFormat = this.defaultTextFormat;
			renderer.defaultSelectedLabelProperties.textFormat = this.selectedTextFormat;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.minWidth = renderer.minHeight = 40 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 40 * this.scale;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			//renderer.paddingLeft = 8 * this.scale;
			//renderer.paddingRight = 16 * this.scale;
			//renderer.y = 0.5*this.scale;
		}
		
		private function persListInitializer(list:List):void
		{			
			list.itemRendererName = LIST_ITEM_RENDERER_NAME;			
		}
		
		private function header1Initializer(header:Header):void
		{
			header.minWidth = 40 * this.scale;
			header.minHeight = 100 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
			header.paddingLeft = 14 * this.scale;
			header.titleAlign = Header.VERTICAL_ALIGN_TOP;
			
			const backgroundSkin:Scale9Image = new Scale9Image(this.headerBackgroundTextures, this.scale);
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.textFormat = this.headerTitleTextFormat;			
		}
		
		private function editButtonInitializer(button:Button):void
		{
			const defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.editIconTexture;
			defaultIcon.textureScale = this.scale;
			defaultIcon.snapToPixels = true;
			button.defaultIcon = defaultIcon;
			button.minWidth = button.minHeight = 44 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
			
		}
		
		private function menuButtonInitializer(button:Button):void
		{
			const defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.menuIconTexture;
			defaultIcon.textureScale = this.scale;
			defaultIcon.snapToPixels = true;
			button.defaultIcon = defaultIcon;
			button.minWidth = button.minHeight = 44 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}
		protected function initializeRoot():void
		{
			this.primaryBackground = new TiledImage(this.mainBackgroundTexture);
			this.primaryBackground.width = root.stage.stageWidth;
			this.primaryBackground.height = root.stage.stageHeight;
			this.root.addChildAt(this.primaryBackground, 0);
			this.root.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			this.root.addEventListener(Event.REMOVED_FROM_STAGE, root_removedFromStageHandler);
		}
		
		protected function root_addedToStageHandler(event:Event):void
		{
			this.root.removeEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			this.initializeRoot();
		}
		protected function root_removedFromStageHandler(event:Event):void
		{
			this.root.removeEventListener(Event.REMOVED_FROM_STAGE, root_removedFromStageHandler);
			this.root.stage.removeEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			this.root.removeChild(this.primaryBackground, true);
			this.primaryBackground = null;
		}
		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.primaryBackground.width = event.width;
			this.primaryBackground.height = event.height;
		}
		
		protected function screenInitializer(screen:Screen):void
		{
			screen.originalDPI = this._originalDPI;
		}

		protected function buttonInitializer(button:Button):void
		{
			const defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.backIconTexture;
			defaultIcon.textureScale = this.scale;
			defaultIcon.snapToPixels = true;
			button.defaultIcon = defaultIcon;
			button.minWidth = button.minHeight = 44 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}
		
		protected function headerInitializer(header:Header):void
		{
			header.minWidth = 40 * this.scale;
			header.minHeight = 40 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.titleAlign = Header.TITLE_ALIGN_PREFER_RIGHT;
			
			const backgroundSkin:Scale9Image = new Scale9Image(this.headerBackgroundTextures, this.scale);
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.textFormat = this.headerTitleTextFormat;
		}
		
		protected function labelInitializer(label:Label):void
		{
			label.textRendererProperties.textFormat = this.defaultTextFormat;
		}


	}
}