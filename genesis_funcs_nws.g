// Adds leading zeros to a num to preserve number of digits (for alphabetization)

function pad_num (num, width)
    str tempfilename = {"/var/tmp/tmp_pad_" @ {num}}
    printf {"%0" @ {width} @ "d"} {num} >! {tempfilename}
    openfile {tempfilename} r
    str padded_num_str = {readfile {tempfilename}}
    closefile {tempfilename}
    rm {tempfilename}
    return {padded_num_str}
end

// Genesis version of above function that does not have race conditions
function pad_num_gen (num, width)
    str padded_num_str = "";
    if ({num} < 10)
	width = {width} - 1;
    elif ({num} < 100)
	width = {width} - 2;
    elif ({num} < 1000)
	width = {width} - 3;
    end
    for (i=0; i<{width}; i=i+1)
      padded_num_str = {padded_num_str} @ "0";
    end
    return {padded_num_str} @ {num}
end


// Compresses data file and returns new file name.
// If fails, returns original filename.
function compress_data_file (raw_filename)
  str comp_filename={strsub {raw_filename} .bin .genflac}
  // TODO: check if 86-84 architecture
  str success = {sh convertgenesis16bit-x86_64 {raw_filename} {comp_filename}}
  if ({success} == "0")
    // successfully compressed file
    rm {raw_filename}
    return {comp_filename}
  else
    echo "*** Warning: Failed to compress data file " @ {raw_filename} @ "."
    return {raw_filename}
  end
end

