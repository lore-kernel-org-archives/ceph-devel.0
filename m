From: Sage Weil <sage@inktank.com>
Subject: Re: Increase number of pg in running system
Date: Tue, 5 Feb 2013 17:49:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302051743380.19543@cobra.newdream.net>
References: <CAD3n6hFb=m_PL27sWZ5BSBAYP3xmTGZS_DrL-4ozF2+JbndMCA@mail.gmail.com> <loom.20130205T153942-509@post.gmane.org> <CA+jddaN5zjDEhknDq2RCsTmXQUDbJB-VKV0K3JcT09Ai0Pdz=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35798 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3BFBt4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 20:49:56 -0500
In-Reply-To: <CA+jddaN5zjDEhknDq2RCsTmXQUDbJB-VKV0K3JcT09Ai0Pdz=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Feb 2013, Mandell Degerness wrote:
> I would like very much to specify pg_num and pgp_num for the default
> pools, but they are defaulting to 64 (no OSDs are defined in the
> config file).  I have tried using the options indicated by Artem, but
> they didn't seem to have any effect on the data and rbd pools which
> are created by default.  Is there something I am missing?

Ah, I see.  Specifying this is awkward.  In [mon] or [global],

 osd pg bits = N
 osd pgp bits = N

where N is the the number of bits to shift 1 to the left.  So for 1024 
PGs, you'd do 10.  (What it's actually doing is MIN(1, num_osds) << N.  
The default N is 6, so you're probaby seeing 64 PGs per pool by default.)

sage


> 
> On Tue, Feb 5, 2013 at 6:40 AM, ArtemGr <artemciy@gmail.com> wrote:
> > Martin B Nielsen <martin <at> unity3d.com> writes:
> >> Hi,
> >>
> >> Looking at:
> >> http://ceph.com/docs/master/rados/operations/pools/
> >>
> >> It has this description roughly in the middle:
> >>
> >> ---------------
> >> Important
> >> Increasing the number of placement groups in a pool after you create
> >> the pool is still an experimental feature in Bobtail (v 0.56). We
> >> recommend defining a reasonable number of placement groups and
> >> maintaining that number until Ceph?s placement group splitting and
> >> merging functionality matures.
> >> ---------------
> >>
> >> However, I cannot find any references how to do this?
> >>
> >> I'm asking since we have a test system with 10TB data with only the
> >> default 8 PG's created.
> >
> > Here's how I do it in ceph.conf:
> >
> > [osd]
> >   ; Increase groups number in order to decrease scrub size
> >   osd pool default pg num = 64
> >   osd pool default pgp num = 64
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
