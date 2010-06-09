From: Sage Weil <sage@newdream.net>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Tue, 8 Jun 2010 22:54:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006082246540.3595@cobra.newdream.net>
References: <20100531125156.GJ1211@skl-net.de> <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net>
 <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
 <20100604084521.GO1211@skl-net.de> <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net>
 <20100607080754.GU1211@skl-net.de> <20100607080932.GV1211@skl-net.de>
 <Pine.LNX.4.64.1006071016470.20365@cobra.newdream.net> <20100608122838.GA9152@skl-net.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40147 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0FIFyG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jun 2010 01:54:06 -0400
In-Reply-To: <20100608122838.GA9152@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

Hmm, okay.  Unfortunately the logs don't have any clues.  I'm giving on up 
solving the mystery this time around.  You can go ahead and stop all the 
daemons and re-run mkcephfs. 

I've added a 'scripts/check_pglog.sh $osddatadir' script that will just 
look for any corruption.  Running that periodically will let you verify 
that you haven't hit the same corruption without having to restart cosd.  
Ideally we can figure out what kind of workloads are triggering the 
problem, and then reproduce it with sufficient logging enabled to find 
where the race is taking place.

If you have any details about the workload or any failure/recovery 
activity that may have been going on at the time that may shed some light 
on it...

FYI, this is http://tracker.newdream.net/issues/114

Thanks!
sage


On Tue, 8 Jun 2010, Andre Noll wrote:

> On Mon, Jun 07, 10:20, Sage Weil wrote:
> 
> > Do you have osd logs?
> 
> Should all be there. At least I did not remove anything.
> 
> > This is the same corruption I've seen previously, but I've just
> > reaudited the code I suspect and it looks ok.  Some insight into what
> > happened to the cluster would help.  Which osd is it?
> 
> It's osd6 running on node142. I was running osd from ceph-v0.20.2 but
> also tried the osd compiled from the "testing" branch of the git repo.
> 
> > Do you still have the logs (/var/log/ceph/osd$n*)?  The osdmap
> > sequence (tarball of $mon_data/osdmap) would be helpful too.
> 
> I created a tarball of the full /var/log/ceph directory of node142
> (which is only a storage node) and will send it to you off-line.
> 
> We have three monitors. I'll send a tarball of /var/ceph/mon0/monmap/
> of mon0 (node141) as well.
> 
> Thanks
> Andre
> -- 
> The only person who always got his work done by Friday was Robinson Crusoe
> 
