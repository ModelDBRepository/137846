function take_snapshot

	openfile {snapshotname} w

    str thiscompt

	if ({exists {cellpath}})
		if ({getfield {cellpath} chanmode} > 1)
			call {cellpath} HSAVE
		end
	end

    str thischan 
    str thisCaPool
    str thisSynapse

    echo taking snapshot {snapshotname}...

    int first_time = 1
    //save {cellpath} {snapshotname} 
    foreach thiscompt ({el {cellpath}/##[][OBJECT=compartment]})
        echo {thiscompt}

        // saving compartment states
        if ( {first_time} == 1)
            first_time = 0
            save {thiscompt} {snapshotname}
	else
            save {thiscompt} {snapshotname} -append
        end

        // saving tabchannel states
        foreach thischan ({el {thiscompt}/##[OBJECT=tabchannel]})
            echo {thischan}
            save {thischan} {snapshotname} -append
        end

        foreach thisSynapse ({el {thiscompt}/##[OBJECT=synchan]})
            echo {thisSynapse}
            save {thisSynapse} {snapshotname} -append
        end

        // saving Ca pool states

        foreach thisCaPool ({el {thiscompt}/##[OBJECT=Ca_concen]})
            echo {thisCaPool}
            save {thisCaPool} {snapshotname} -append
        end
    end

	closefile {snapshotname}
	//closefile {allcompsfilename}
end
	
function restore_snapshot
    echo restoring snapshot {snapshotname}...

    restore {snapshotname} 
    call {cellpath} HRESTORE
    echo restoring done...
end
    
