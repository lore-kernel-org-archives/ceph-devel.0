From: Sage Weil <sage@inktank.com>
Subject: Re: OSD memory leaks?
Date: Fri, 22 Feb 2013 16:44:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302221642570.5703@cobra.newdream.net>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com> <8366806.170.1357747859058.JavaMail.dspano@it1> <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com> <CAF6-1L4WOGHNU=qLOuOWktsDirc-nO2ZM0+nQL9vxF2KKuWVqg@mail.gmail.com>
 <CAPYLRziCObXZaOcqA8CDfheJTYce1w3m5754+0Dz-ToYJYKuDg@mail.gmail.com> <CAOLwVUkA5G+RyzembvZnv2gA5h-E+kNR_me_Hgoisjk0dmSWSg@mail.gmail.com> <CAPYLRzjx24oOEpjcvKa2ELJYb6QAxTegVatysMAobbP-h1v8Xg@mail.gmail.com>
 <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45223 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952Ab3BWAoe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 19:44:34 -0500
In-Reply-To: <CAOLwVUn0SetsDgE2vqioFn+53xDi7Uh9TivDX2JOH6Qu5pEEUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Dave Spano <dspano@optogenics.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Fri, 22 Feb 2013, S?bastien Han wrote:
> Hi all,
> 
> I finally got a core dump.
> 
> I did it with a kill -SEGV on the OSD process.
> 
> https://www.dropbox.com/s/ahv6hm0ipnak5rf/core-ceph-osd-11-0-0-20100-1361539008
> 
> Hope we will get something out of it :-).

AHA!  We have a theory.  The pg log isnt trimmed during scrub (because teh 
old scrub code required that), but the new (deep) scrub can take a very 
long time, which means the pg log will eat ram in the meantime.. 
especially under high iops.

Can you try wip-osd-log-trim (which is bobtail + a simple patch) and see 
if that seems to work?  Note that that patch shouldn't be run in a mixed 
argonaut+bobtail cluster, since it isn't properly checking if the scrub is 
class or chunky/deep.

Thanks!
sage


 > --
> Regards,
> S?bastien Han.
> 
> 
> On Fri, Jan 11, 2013 at 7:13 PM, Gregory Farnum <greg@inktank.com> wrote:
> > On Fri, Jan 11, 2013 at 6:57 AM, S?bastien Han <han.sebastien@gmail.com> wrote:
> >>> Is osd.1 using the heap profiler as well? Keep in mind that active use
> >>> of the memory profiler will itself cause memory usage to increase ?
> >>> this sounds a bit like that to me since it's staying stable at a large
> >>> but finite portion of total memory.
> >>
> >> Well, the memory consumption was already high before the profiler was
> >> started. So yes with the memory profiler enable an OSD might consume
> >> more memory but this doesn't cause the memory leaks.
> >
> > My concern is that maybe you saw a leak but when you restarted with
> > the memory profiling you lost whatever conditions caused it.
> >
> >> Any ideas? Nothing to say about my scrumbing theory?
> > I like it, but Sam indicates that without some heap dumps which
> > capture the actual leak then scrub is too large to effectively code
> > review for leaks. :(
> > -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
