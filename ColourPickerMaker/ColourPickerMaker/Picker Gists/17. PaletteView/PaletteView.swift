import SwiftUI

struct RGBAPaletteView: PalettePickable {
  typealias DataType = RGBAData
  let data: RGBAData
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
    }
}

struct HSBAPaletteView: PalettePickable {
  typealias DataType = HSBAData
  let data: HSBAData
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}

struct CMYKAPaletteView: PalettePickable {
  typealias DataType = CMYKAData
  let data: DataType
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}

struct GreyscalePaletteView: PalettePickable {
  typealias DataType = GreyscaleData
  let data: DataType
  let size: (rows: Int, columns: Int)
  
  init(data: DataType, rows: Int = 10, columns: Int = 10) {
    self.data = data
    self.size = (rows: rows, columns: columns)
  }
}
