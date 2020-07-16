# CollectionView move to next cell automatically swift

![48cuyk](https://user-images.githubusercontent.com/29371886/87573105-517ec500-c6ee-11ea-9ddd-4b3b0448399a.gif)


## Code

   override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        }
  
    func startTimer() {
        _ =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
        
    @objc func scrollAutomatically(){
        
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width-25, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        
        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width+25.0
        {
            collectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        } else {
            
         
            collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        }
        
        
    }
