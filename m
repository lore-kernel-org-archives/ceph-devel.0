From: Sage Weil <sage@inktank.com>
Subject: RE: max useful journal size
Date: Sat, 19 Jan 2013 09:42:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301190940510.29915@cobra.newdream.net>
References: <CACkq2mokPwwgue_OjsZngzGLLt5XODZiJdD5YwCDJ1um5TQ9eA@mail.gmail.com> <CAPYLRzjkw92FU-q7tDWJSCuOjOE5OBaYZfPE0NT67cK532Gdwg@mail.gmail.com> <CACkq2mpwzsAtTRh7Cg0-c3GXTf8-V3OnrO6ojxE5gDnks9MMDQ@mail.gmail.com> <alpine.DEB.2.00.1301181454460.8622@cobra.newdream.net>
 <CACkq2mrKccAP+w2OUwTtDBU0GKrFFV=7aXKwbewmZaooEWRS4Q@mail.gmail.com> <alpine.DEB.2.00.1301182055580.29915@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC5E1F65@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59122 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3ASRmh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 12:42:37 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5E1F65@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 19 Jan 2013, Chen, Xiaoxi wrote:
> Does the sync really sync between Journal and Data disk?
> From the code it seems just call syncfs on data disk and report the synced lenth to journal.Below is my understanding about this topic:
> 
> Assume journal ahead disk with 1GB,the sync will not make the disk write the 1GB and catch up with journal, instead, it just call a syncfs to make some *finished but still in pagecache* writes go actually to disk.After doing so, this is a consistent point, it's safe to trim the space which the synced writes had taken(say 800M maybe).

Right.  Although I'm not sure what you mean by about 800MB.

> >>osd journal size = {2 * (expected throughput * filestore max sync interval)}
> 
> Journal will trigger a sync(by signal the condition of sync_thread) when 
> it exceed "haft-full", so basically, sync will happen only when:1) 
> journal reach haft full 2) reach max_sync_interval. The factor 2 seems 
> to prevent 1 ) from happen, that is, try to make sync only happen when 
> it reach max interval.

The half full and max sync interval thresholds will be about the same 
point in time if the journal is sized that way.  Is that what you mean?  
I'm not sure I'm following...

sage


> 
> 													Xiaoxi
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: 2013?1?19? 12:56
> To: Travis Rhoden
> Cc: ceph-devel
> Subject: Re: max useful journal size
> 
> On Fri, 18 Jan 2013, Travis Rhoden wrote:
> > Thanks for the clarifcation, Sage. That makes sense. Especially when I 
> > think about it in the sense that if I have an SSD capable of 
> > 400MB/sec, and the journal doesn't flush for 5 seconds, there is 2GB 
> > of data sync. The disk only does 100-150MB/sec, so this could take up 
> > to twenty seconds to write out. And all the while more data is coming 
> > in. Now I see the purpose of having the bigger journal.
> > 
> > Of course it only goes so far, and when its full, its full. I get that too.
> > 
> > I submitted a pull request to change the docs to specify filestore max 
> > sync instead of min.
> 
> Pulled, thanks!
> 
> sage
> 
> 
> > 
> > On Fri, Jan 18, 2013 at 5:56 PM, Sage Weil <sage@inktank.com> wrote:
> > > On Fri, 18 Jan 2013, Travis Rhoden wrote:
> > >> On Fri, Jan 18, 2013 at 5:43 PM, Gregory Farnum <greg@inktank.com> wrote:
> > >> > On Fri, Jan 18, 2013 at 2:20 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> > >> >> Hey folks,
> > >> >>
> > >> >> The Ceph docs give the following recommendation on sizing your journal:
> > >> >>
> > >> >> osd journal size = {2 * (expected throughput * filestore min 
> > >> >> sync interval)}
> > >> >>
> > >> >> The default value of min sync interval is .01.  If you use 
> > >> >> throughput of a mediocre 7200RPM drive of 100MB/sec, this comes 
> > >> >> to 2 MB.  That seems like the lower bound to have the journal do anything at all.
> > >> >
> > >> > Ah. This should refer to the max sync interval, not the min!
> > >>
> > >> I wondered about that.  But wasn't confident enough to ask about it.
> > >> >
> > >> >> My question is what is the upper bound?  There's clearly a limit 
> > >> >> to how big make, such that it just becomes wasted space.  The 
> > >> >> reason I want to know is that since I will be journals on SSDs, 
> > >> >> with each journal being a dedicated partition, there is a 
> > >> >> benefit to not making the partition bigger than it needs to be.  
> > >> >> All that unpartitioned space can be used by the SSD firmware for 
> > >> >> wear-leveling and other things (so long as it remains unpartitioned).
> > >> >>
> > >> >> Would the following calc be appopriate?
> > >> >>
> > >> >> Assume an SSD write speed of 400MB/sec.  Default max sync interval is 5.
> > >> >>
> > >> >> 2 * (400 MB/sec * 5sec) = 4 GB.
> > >> >>
> > >> >> So is it appropriate to assume that if I can't write to an SSD 
> > >> >> faster than 400 MB/sec, and I keep the default sync interval 
> > >> >> values, a journal greater than 4GB is just a waste?
> > >> >>
> > >> >> I had been using 10GB journals...  seems like overkill.
> > >> >>
> > >> >> Or put another way, if I want to use 10GB journals, I should 
> > >> >> bump the max sync interval to 12.5.
> > >> >
> > >> > It can of course grow as large as you let it, and I would leave 
> > >> > some extra room as a margin. The main consideration is that the 
> > >> > journal doesn't like getting too far ahead of the filestore, and 
> > >> > that's what the above calculation uses to set size.
> > >>
> > >> Is "max sync interval" a hard stop, though?  I mean, once 5 seconds 
> > >> pass, it's going to flush/sync no matter what, right? So there is 
> > >> no point in making it much bigger than what can be written to the 
> > >> journal in those 5 seconds.  I feel like I must be missing 
> > >> something, though, otherwise the recommendation wouldn't to make 
> > >> the journal 2x that size.
> > >
> > > The sync itself can take time, and we *initiate* the sync at that time.
> > > Hence the 2x.  When the journal fills up there is a hefty 
> > > performance hit, too.  When you adjust this down, check back at some 
> > > ponit and make sure you don't see JOURNAL FULL messages in your log 
> > > that point to a problem (with the code or the tuning logic).
> > >
> > > Thanks!
> > > sage
> > >
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
