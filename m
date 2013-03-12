From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: OSD memory leaks?
Date: Tue, 12 Mar 2013 17:01:22 -0400
Message-ID: <201303122101.r2CL1MjI012059@ayesha.phys.virginia.edu>
References: <CAOLwVUkBeu+=4XHv8NV+xRm7CaEvByO-uuo5eeZ+iHUg1XQ1sw@mail.gmail.com>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:34973 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542Ab3CLVBX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 17:01:23 -0400
In-reply-to: Your message of "Tue, 12 Mar 2013 21:10:40 BST."
             <CAOLwVUkBeu+=4XHv8NV+xRm7CaEvByO-uuo5eeZ+iHUg1XQ1sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han.sebastien@gmail.com
Cc: ceph-devel@vger.kernel.org


han.sebastien@gmail.com said:
> Well to avoid un necessary data movement, there is also an _experimental_
> feature to change on fly the number of PGs in a pool.
> ceph osd pool set <poolname> pg_num <numpgs> --allow-experimental-feature 

I've been following the instructions here:

http://ceph.com/docs/master/rados/configuration/osd-config-ref/

under "data placement", trying to set the number of pgs in ceph.conf.
I've added these lines in the "global" section:

        osd pool default pg num = 500
        osd pool default pgp num = 500

but they don't seem to have any effect on how mkcephfs behaves.
Before I added these lines, mkcephfs created a data pool with
3904 pgs.  After wiping everything, adding the lines and 
re-creating the pool, it still ends up with 3904 pgs.  What
am I doing wrong?

					Thanks,
					Bryan
-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


