From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: common/Mutex.h:102: FAILED assert(nlock > 0)
Date: Fri, 22 Oct 2010 15:09:13 -0600
Message-ID: <1287781753.6806.84.camel@sale659.sandia.gov>
References: <1287773810.6806.74.camel@sale659.sandia.gov>
 <AANLkTikL=9eXGTGyMzs2b71kQfaEieayp-KFNUrLy2k2@mail.gmail.com>
 <1287779106.6806.78.camel@sale659.sandia.gov>
 <AANLkTikW98mUnNh84QNdDcyiVFL78TzKVzSRiH_jz09Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:48456 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab0JVVJc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Oct 2010 17:09:32 -0400
In-Reply-To: <AANLkTikW98mUnNh84QNdDcyiVFL78TzKVzSRiH_jz09Y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2010-10-22 at 14:39 -0600, Gregory Farnum wrote:
> On Fri, Oct 22, 2010 at 1:25 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi Greg,
> >
> > On Fri, 2010-10-22 at 13:40 -0600, Gregory Farnum wrote:
> >> If you pull the newest unstable you'll find this fixed, it was a
> >> short-lived error in the tree. :)
> >
> > What's the tip of the unstable branch for you?
> >
> > My latest pull as of 14:23:00 MDT has 242b5992f307 as
> > the tip, and it's still showing this problem?
> >
> > Thanks -- Jim
> Oh, there was a merge issue --- it's reverted now.

That did the trick for me!

> Sorry!

No problem - thanks for the quick turnaround!

-- Jim

> -Greg
> 


