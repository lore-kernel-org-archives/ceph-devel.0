From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 16:29:22 -0700
Message-ID: <1299886162.4750.445.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com>
 <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
 <1299867988.4750.394.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>
 <1299877982.4750.415.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111333190.23902@cobra.newdream.net>
 <1299882072.4750.434.camel@sale659.sandia.gov>
 <1299882409.4750.438.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103111444450.23902@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:59102 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1CKX3b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 18:29:31 -0500
In-Reply-To: <Pine.LNX.4.64.1103111444450.23902@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-11 at 15:45 -0700, Sage Weil wrote:
> On Fri, 11 Mar 2011, Jim Schutt wrote:
> > > So it occurs to me that one call to Message::put() entails many 
> > > calls to buffer::ptr::release(), depending on what the message 
> > > is, right?  Maybe time the "delete _raw" in there and assert() 
> > > if it's too long?
> > 
> > Also, any chance all incoming data is causing buffer_total_alloc
> > to be contended?  I don't have libatomic_ops either, so that
> > atomic_t is implemented via a pthread_spinlock_t, right?
> > How to check that?
> 
> Hmm, it could be.  I pushed a nobuffer branch that compiles out the 
> buffer_total_alloc accounting, if you want to give that a go.

That seems to have helped, although it's not a complete solution.

I still got some OSDs failed, but since I use

        osd min down reporters = 3
        osd min down reports = 2

only 1 OSD got marked down; it noticed quickly and marked
itself up, and my 64-client dd finished.  That's new for
me at 96 OSDs.

I saw this on this run:

# grep -Hn RefCountedObject::put osd.*.log | egrep "took [0-9][0-9]\." | wc -l 
192

# grep -Hn RefCountedObject::put osd.*.log | egrep "took [1-9]\." | wc -l
12578

which compares to a previous run in an earlier email:


> > > # grep -Hn RefCountedObject::put osd.*.log | egrep "took [1-9]\." | wc -l
> > > 8911
> > > 
> > > # grep -Hn RefCountedObject::put osd.*.log | egrep "took [0-9][0-9]\." | wc -l
> > > 415

-- Jim

> 
> sage
> 


