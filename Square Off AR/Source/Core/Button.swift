//
//  Button.swift
//  Kulki
//
//  Created by Rafal Grodzinski on 28/06/16.
//  Copyright © 2016 UnalignedByte. All rights reserved.
//

import SpriteKit

class Button: SKSpriteNode {
    // MARK: Variables
    fileprivate var defaultTexture: SKTexture? = nil
    fileprivate var pressedTexture: SKTexture? = nil

    // MARK: - Callbacks -
    var callback: (() -> Void)?

    // MARK: - Initialization -
    init(defaultTexture: SKTexture, pressedTexture: SKTexture? = nil) {
        self.defaultTexture = defaultTexture
        self.pressedTexture = pressedTexture

        super.init(texture: defaultTexture, color: UIColor.clear, size: defaultTexture.size())

        self.isUserInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    // MARK: - Control -
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showPressed()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesCancelled(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showDefault()

        for touch in touches {
            let location = touch.location(in: self.parent!)

            if self.contains(location) {
                if let callback = self.callback {
                    callback()
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self.parent!)

            if self.contains(location) {
                self.showPressed()
                return
            }
        }

        self.showDefault()
    }

    // MARK: - Internal Control -
    fileprivate func showDefault() {
        self.texture = self.defaultTexture
        self.colorBlendFactor = 0.0
    }

    fileprivate func showPressed() {
        if let pressedTexture = self.pressedTexture {
            self.texture = pressedTexture
        } else {
            self.color = UIColor(white: 0.0, alpha: 1.0)
            self.colorBlendFactor = 0.5
        }
    }
}
