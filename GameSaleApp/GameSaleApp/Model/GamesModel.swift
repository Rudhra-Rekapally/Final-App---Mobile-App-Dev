/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GamesModel : Codable {
	let count : Int?
	let next : String?
	let previous : String?
	let results : [Results]?
	let seo_title : String?
	let seo_description : String?
//	let seo_seo_keywordswords : String?
	let seo_h1 : String?
	let noindex : Bool?
	let nofollow : Bool?
	let description : String?
	let filters : Filters?
	let nofollow_collections : [String]?

	enum CodingKeys: String, CodingKey {

		case count = "count"
		case next = "next"
		case previous = "previous"
		case results = "results"
		case seo_title = "seo_title"
		case seo_description = "seo_description"
//		case seo_keywords = "seo_keywords"
		case seo_h1 = "seo_h1"
		case noindex = "noindex"
		case nofollow = "nofollow"
		case description = "description"
		case filters = "filters"
		case nofollow_collections = "nofollow_collections"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		count = try values.decodeIfPresent(Int.self, forKey: .count)
		next = try values.decodeIfPresent(String.self, forKey: .next)
		previous = try values.decodeIfPresent(String.self, forKey: .previous)
		results = try values.decodeIfPresent([Results].self, forKey: .results)
		seo_title = try values.decodeIfPresent(String.self, forKey: .seo_title)
		seo_description = try values.decodeIfPresent(String.self, forKey: .seo_description)
//		seo_keywords = try values.decodeIfPresent(String.self, forKey: .seo_keywords)
		seo_h1 = try values.decodeIfPresent(String.self, forKey: .seo_h1)
		noindex = try values.decodeIfPresent(Bool.self, forKey: .noindex)
		nofollow = try values.decodeIfPresent(Bool.self, forKey: .nofollow)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		filters = try values.decodeIfPresent(Filters.self, forKey: .filters)
		nofollow_collections = try values.decodeIfPresent([String].self, forKey: .nofollow_collections)
	}

}
