From: Sage Weil <sage@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Thu, 27 Dec 2012 10:43:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212271042500.22449@cobra.newdream.net>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <50C774FD.9030107@inktank.com> <50C78D09.5050403@inktank.com> <CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail.com> <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com>
 <50CB57E2.10703@inktank.com> <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csid7_LV3RKYbiTdB+09g@mail.gmail.com> <50CB69E5.7080001@inktank.com> <CAPud5_5PuF0kMzaWVb84_zB6XyZ4QexUsmqoCTdp8vsFNDE=LA@mail.gmail.com> <50D0951F.6050106@inktank.com>
 <CAPud5_5DnafqOZ1y3NHXY9Ryj_wSeKz+mvWbXqWFD1yjgbNgtw@mail.gmail.com> <50D230E4.6060805@inktank.com> <50D242C3.3070409@inktank.com> <CAPud5_6b=8m7jrrG-6TAyXjGj8dL1yrsNaeUTTp8NC7HpNMeeQ@mail.gmail.com> <50D38A4B.9070307@inktank.com>
 <CAPud5_68Q8mgKqCxkKugkJ_Ws=PiZJThq0TGf0hKNkS4wL04Dg@mail.gmail.com> <50DB6DD7.3050308@inktank.com> <CAPud5_7XhgA9+=+KxZxzXgWg7ijmu0Z+sXA2=xu7g2V9FjZ0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41206 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2L0Sno (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 13:43:44 -0500
In-Reply-To: <CAPud5_7XhgA9+=+KxZxzXgWg7ijmu0Z+sXA2=xu7g2V9FjZ0zA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Alex Elder <elder@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 27 Dec 2012, Nick Bartos wrote:
> I have some exciting news.  After 215 test runs, no hung processes
> were detected.  I think we may actually have it this time.  Thanks for
> all your hard work!

Sweet!  I think it was the new branch naming scheme that did it.

sage

> 
> -Nick
> 
> On Wed, Dec 26, 2012 at 1:36 PM, Alex Elder <elder@inktank.com> wrote:
> > On 12/26/2012 11:45 AM, Nick Bartos wrote:
> >> Here's a log with a hang on the updated branch:
> >>
> >> https://gist.github.com/raw/4381750/772476e1bae1e6366347a223f34aa6c440b92765/rdb-hang-1356543132.log
> >
> > OK, new naming scheme.  Please try:  wip-nick-1
> >
> > I added another simple fix, but then collapsed three commits
> > into one, and added one more (somewhat unrelated).
> >
> > I've done simple testing with this and will subject it to
> > more rigorous testing shortly.  I wanted to make it available
> > to you quickly though.
> >
> >                                         -Alex
> 
> 
