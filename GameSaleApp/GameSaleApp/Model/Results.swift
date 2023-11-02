/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Results : Codable {
	let id : Int?
	let slug : String?
	let name : String?
	let released : String?
	let tba : Bool?
	let background_image : String?
	let rating : Double?
	let rating_top : Int?
	let ratings : [Ratings]?
	let ratings_count : Int?
	let reviews_text_count : Int?
	let added : Int?
	let added_by_status : Added_by_status?
	let metacritic : Int?
	let playtime : Int?
	let suggestions_count : Int?
	let updated : String?
	let user_game : String?
	let reviews_count : Int?
	let saturated_color : String?
	let dominant_color : String?
	let platforms : [Platforms]?
	let parent_platforms : [Parent_platforms]?
	let genres : [Genres]?
	let stores : [Stores]?
	let clip : String?
	let tags : [Tags]?
	let esrb_rating : Esrb_rating?
	let short_screenshots : [Short_screenshots]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case slug = "slug"
		case name = "name"
		case released = "released"
		case tba = "tba"
		case background_image = "background_image"
		case rating = "rating"
		case rating_top = "rating_top"
		case ratings = "ratings"
		case ratings_count = "ratings_count"
		case reviews_text_count = "reviews_text_count"
		case added = "added"
		case added_by_status = "added_by_status"
		case metacritic = "metacritic"
		case playtime = "playtime"
		case suggestions_count = "suggestions_count"
		case updated = "updated"
		case user_game = "user_game"
		case reviews_count = "reviews_count"
		case saturated_color = "saturated_color"
		case dominant_color = "dominant_color"
		case platforms = "platforms"
		case parent_platforms = "parent_platforms"
		case genres = "genres"
		case stores = "stores"
		case clip = "clip"
		case tags = "tags"
		case esrb_rating = "esrb_rating"
		case short_screenshots = "short_screenshots"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		released = try values.decodeIfPresent(String.self, forKey: .released)
		tba = try values.decodeIfPresent(Bool.self, forKey: .tba)
		background_image = try values.decodeIfPresent(String.self, forKey: .background_image)
		rating = try values.decodeIfPresent(Double.self, forKey: .rating)
		rating_top = try values.decodeIfPresent(Int.self, forKey: .rating_top)
		ratings = try values.decodeIfPresent([Ratings].self, forKey: .ratings)
		ratings_count = try values.decodeIfPresent(Int.self, forKey: .ratings_count)
		reviews_text_count = try values.decodeIfPresent(Int.self, forKey: .reviews_text_count)
		added = try values.decodeIfPresent(Int.self, forKey: .added)
		added_by_status = try values.decodeIfPresent(Added_by_status.self, forKey: .added_by_status)
		metacritic = try values.decodeIfPresent(Int.self, forKey: .metacritic)
		playtime = try values.decodeIfPresent(Int.self, forKey: .playtime)
		suggestions_count = try values.decodeIfPresent(Int.self, forKey: .suggestions_count)
		updated = try values.decodeIfPresent(String.self, forKey: .updated)
		user_game = try values.decodeIfPresent(String.self, forKey: .user_game)
		reviews_count = try values.decodeIfPresent(Int.self, forKey: .reviews_count)
		saturated_color = try values.decodeIfPresent(String.self, forKey: .saturated_color)
		dominant_color = try values.decodeIfPresent(String.self, forKey: .dominant_color)
		platforms = try values.decodeIfPresent([Platforms].self, forKey: .platforms)
		parent_platforms = try values.decodeIfPresent([Parent_platforms].self, forKey: .parent_platforms)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		stores = try values.decodeIfPresent([Stores].self, forKey: .stores)
		clip = try values.decodeIfPresent(String.self, forKey: .clip)
		tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
		esrb_rating = try values.decodeIfPresent(Esrb_rating.self, forKey: .esrb_rating)
		short_screenshots = try values.decodeIfPresent([Short_screenshots].self, forKey: .short_screenshots)
	}

}
