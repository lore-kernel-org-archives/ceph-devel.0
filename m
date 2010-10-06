From: Sage Weil <sage@newdream.net>
Subject: Re: No space left while there are still available disk space
Date: Tue, 5 Oct 2010 22:08:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010052203210.21681@cobra.newdream.net>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
 <AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
 <AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49452 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab0JFFGY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 01:06:24 -0400
In-Reply-To: <AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

On Wed, 6 Oct 2010, Leander Yu wrote:
> Thanks, we found that even after I clean some disk space and make sure
> all the osd disk usage is less than 90%, I still can not write any
> data to the filesystem(not a single byte).
> Henry have check the kernel client debug info and found the osdmap is
> out of date and the flag is keep at full.
> He will post more detail information later.
> I guess there are some error handling problem there so that the client
> didn't keep updating the osdmap when disk is fulled.

You mean the monitor's osdmap is not marked full, but the client's old one 
still is?  That makes sense.  Something as simple as calling

		ceph_monc_request_next_osdmap(&osdc->client->monc);

before returning ENOSPC in ceph_aio_write() will mostly work; it means 
there will be at least one ENOSPC failure before we get an updated map.  
Maybe, in addition to that, we should also periodically check for a new 
map (maybe every minute?) so that if usage does drop and a new writer 
comes along they won't get that initial ENOSPC.

sage


> 
> Any suggestion for further trouble shooting ?
> 
> Regards,
> Leander Yu.
> 
> On Wed, Oct 6, 2010 at 12:48 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> > On Tue, Oct 5, 2010 at 9:40 PM, Leander Yu <leander.yu@gmail.com> wrote:
> >> Hi,
> >> I just found my ceph cluster report no space left error. I check the
> >> df and every osd disk. it still has space available and after delete
> >> some file, I still can't write any data to the file system.
> >> Any suggestion for trouble shooting this case?
> > As with all distributed filesystems, Ceph still doesn't handle things
> > very well when even one disk runs out of space. Some sort of solution
> > will appear, but isn't on the roadmap yet. The most likely cause is
> > that you have disks of different sizes and haven't balanced their
> > input (via the CRUSH map) to match. Unfortunately, the best fix is
> > either to keep deleting data or to put a larger disk in whichever OSD
> > is full. The logs should tell you which one reported full.
> >
> > Keep in mind that to prevent more nasty badness from the local
> > filesystem, Ceph reports a disk "full" at some percentage below full
> > (I think it's 95%, but it may actually be less).
> > -Greg
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
