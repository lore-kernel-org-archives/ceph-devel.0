From: Sage Weil <sage@inktank.com>
Subject: Re: max useful journal size
Date: Fri, 18 Jan 2013 20:56:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301182055580.29915@cobra.newdream.net>
References: <CACkq2mokPwwgue_OjsZngzGLLt5XODZiJdD5YwCDJ1um5TQ9eA@mail.gmail.com> <CAPYLRzjkw92FU-q7tDWJSCuOjOE5OBaYZfPE0NT67cK532Gdwg@mail.gmail.com> <CACkq2mpwzsAtTRh7Cg0-c3GXTf8-V3OnrO6ojxE5gDnks9MMDQ@mail.gmail.com> <alpine.DEB.2.00.1301181454460.8622@cobra.newdream.net>
 <CACkq2mrKccAP+w2OUwTtDBU0GKrFFV=7aXKwbewmZaooEWRS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab3ASE4I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 23:56:08 -0500
In-Reply-To: <CACkq2mrKccAP+w2OUwTtDBU0GKrFFV=7aXKwbewmZaooEWRS4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 18 Jan 2013, Travis Rhoden wrote:
> Thanks for the clarifcation, Sage. That makes sense. Especially when I
> think about it in the sense that if I have an SSD capable of
> 400MB/sec, and the journal doesn't flush for 5 seconds, there is 2GB
> of data sync. The disk only does 100-150MB/sec, so this could take up
> to twenty seconds to write out. And all the while more data is coming
> in. Now I see the purpose of having the bigger journal.
> 
> Of course it only goes so far, and when its full, its full. I get that too.
> 
> I submitted a pull request to change the docs to specify filestore max
> sync instead of min.

Pulled, thanks!

sage


> 
> On Fri, Jan 18, 2013 at 5:56 PM, Sage Weil <sage@inktank.com> wrote:
> > On Fri, 18 Jan 2013, Travis Rhoden wrote:
> >> On Fri, Jan 18, 2013 at 5:43 PM, Gregory Farnum <greg@inktank.com> wrote:
> >> > On Fri, Jan 18, 2013 at 2:20 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> >> >> Hey folks,
> >> >>
> >> >> The Ceph docs give the following recommendation on sizing your journal:
> >> >>
> >> >> osd journal size = {2 * (expected throughput * filestore min sync interval)}
> >> >>
> >> >> The default value of min sync interval is .01.  If you use throughput
> >> >> of a mediocre 7200RPM drive of 100MB/sec, this comes to 2 MB.  That
> >> >> seems like the lower bound to have the journal do anything at all.
> >> >
> >> > Ah. This should refer to the max sync interval, not the min!
> >>
> >> I wondered about that.  But wasn't confident enough to ask about it.
> >> >
> >> >> My question is what is the upper bound?  There's clearly a limit to
> >> >> how big make, such that it just becomes wasted space.  The reason I
> >> >> want to know is that since I will be journals on SSDs, with each
> >> >> journal being a dedicated partition, there is a benefit to not making
> >> >> the partition bigger than it needs to be.  All that unpartitioned
> >> >> space can be used by the SSD firmware for wear-leveling and other
> >> >> things (so long as it remains unpartitioned).
> >> >>
> >> >> Would the following calc be appopriate?
> >> >>
> >> >> Assume an SSD write speed of 400MB/sec.  Default max sync interval is 5.
> >> >>
> >> >> 2 * (400 MB/sec * 5sec) = 4 GB.
> >> >>
> >> >> So is it appropriate to assume that if I can't write to an SSD faster
> >> >> than 400 MB/sec, and I keep the default sync interval values, a
> >> >> journal greater than 4GB is just a waste?
> >> >>
> >> >> I had been using 10GB journals...  seems like overkill.
> >> >>
> >> >> Or put another way, if I want to use 10GB journals, I should bump the
> >> >> max sync interval to 12.5.
> >> >
> >> > It can of course grow as large as you let it, and I would leave some
> >> > extra room as a margin. The main consideration is that the journal
> >> > doesn't like getting too far ahead of the filestore, and that's what
> >> > the above calculation uses to set size.
> >>
> >> Is "max sync interval" a hard stop, though?  I mean, once 5 seconds
> >> pass, it's going to flush/sync no matter what, right? So there is no
> >> point in making it much bigger than what can be written to the journal
> >> in those 5 seconds.  I feel like I must be missing something, though,
> >> otherwise the recommendation wouldn't to make the journal 2x that
> >> size.
> >
> > The sync itself can take time, and we *initiate* the sync at that time.
> > Hence the 2x.  When the journal fills up there is a hefty performance
> > hit, too.  When you adjust this down, check back at some ponit and make
> > sure you don't see JOURNAL FULL messages in your log that point to a
> > problem (with the code or the tuning logic).
> >
> > Thanks!
> > sage
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
