module DatatableHelper
	#converts an object array into DataTable format
	#example output:
	#{"sEcho": 1, "iTotalRecords": 57, "iTotalDisplayRecords": 57, 
	#{"aaData": [ 
	#["Gecko","Firefox 1.0","Win 98+ / OSX.2+","1.7","A"],["Gecko","Firefox 1.5","Win 98+ / OSX.2+","1.8","A"],["Gecko","Firefox 2.0","Win 98+ / OSX.2+","1.8","A"],["Gecko","Firefox 3.0","Win 2k+ / OSX.3+","1.9","A"],["Gecko","Camino 1.0","OSX.2+","1.8","A"],["Gecko","Camino 1.5","OSX.3+","1.8","A"],["Gecko","Netscape 7.2","Win 95+ / Mac OS 8.6-9.2","1.7","A"],["Gecko","Netscape Browser 8","Win 98SE+","1.7","A"],["Gecko","Netscape Navigator 9","Win 98+ / OSX.2+","1.8","A"],["Gecko","Mozilla 1.0","Win 95+ / OSX.1+","1","A"]
	#] }
	
	def self.to_table(data, params = {})
		
		if params[:columns]
			return self.table_by_columns(data, params)
		else 
			return self.table_by_attributes(data, params)
		end
	end
	
	def self.table_by_columns(data, params = {})
		total = params[:total] ? params[:total] : data.count
		output = "{\"iTotalRecords\":" + total.to_s + ",\"iTotalDisplayRecords\":" + total.to_s + ",\"aaData\":"

		rows = Array.new
		data.each do |d|
			row = Array.new
			params[:columns].each do |c|
				if (d.attributes[c])
					row << d.attributes[c]
				elsif (d.instance_variable_defined?("@" + c))
					row << d.instance_variable_get("@" + c)
				elsif (d.methods.include?(c))
					row << d.method(c).call
				else 
					row << nil
				end
			end
			rows << row if (row.count > 0)
		end
		output += rows.to_json
		output += "}"
		return output
	end
	
	def self.table_by_attributes(data, params = {})
		output = "{\"iTotalRecords\":" + data.count.to_s + ",\"iTotalDisplayRecords\":" + data.count.to_s + ",\"aaData\":["
		output += data.collect { |d| d.attributes.values }.to_json
		output += "}"
		
		return output
	end
	
	def self.get_sorting(columns, params = {})
		output = ""		
 		columns.each_index do |i|		
				break if (!params["iSortCol_" + i.to_s])
				index = params["iSortCol_" + i.to_s].to_i
				output += columns[index] + " " + params["sSortDir_" + i.to_s] + ","
		end
		return output == "" ? nil : output.chomp(",")
	end
end