"Latex Related

:command LatexTree call LatexTree() | lopen

func LatexTree()
	
	let items = systemlist('grep -Hn section{ ./*.tex')
	let nums = []
	let filenames = []
	let newItems = []	
	let texts = []
	for item in items
		call add(nums, split(item, ":")[1])
		let name = split(split(split(item, ":")[2], "{")[1], "}")[0]
		if match(item, 'subsection') != -1
			let name = "---" . name	
		endif	
			if match(item, 'subsubsection') != -1
			let name = '---' . name
		endif

		call add(filenames, split(item, ":")[0])
		call add(texts, name) 
	endfor

	let idx = 0

	while idx < len(items)
		call add(newItems, {'filename':filenames[idx], 'lnum':nums[idx], 'text':texts[idx]})
		let idx+=1
	endwhile

	call setloclist(winnr(), [], 'r', {'items': newItems}) 

endfunc

autocmd Bufwrite *.tex call timer_start(200, { tid -> execute('LatexTree')})



