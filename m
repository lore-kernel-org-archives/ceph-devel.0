From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 15:34:31 -0700
Message-ID: <1299191671.4750.144.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov>
 <1299106628.4750.62.camel@sale659.sandia.gov>
 <AANLkTikU_F_mRaYC6xE5V9OHaDbyjWJ7fnpVCXkz=tK=@mail.gmail.com>
 <1299182603.4750.128.camel@sale659.sandia.gov>
 <1299185234.4750.137.camel@sale659.sandia.gov>
 <AANLkTikmVL8soYOR3nQyD3=FXjv-aurcydAVvJVvAOJR@mail.gmail.com>
 <1299188722.4750.140.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103031421410.8512@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:47145 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759013Ab1CCWel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 17:34:41 -0500
In-Reply-To: <Pine.LNX.4.64.1103031421410.8512@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2011-03-03 at 15:22 -0700, Sage Weil wrote:
> On Thu, 3 Mar 2011, Jim Schutt wrote:
> > That seems to have fixed this issue.  At least, before
> > OSDs would start dying within a few minutes of starting
> > up a new file system; it's been over a half hour since
> > I started one up with this patch, and all OSDs are still
> > running.
> 
> That's good news; good catch with SIGPIPE!
> 
> Does that mean the original problem with the OSDs getting marked down has 
> also gone away for you too?

I don't know yet - I'm just starting to retest that.

I'll let you know as soon as I know something.

Thanks -- Jim

> 
> sage
> 


