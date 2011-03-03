From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 14:22:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103031421410.8512@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov> <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov> <1299106628.4750.62.camel@sale659.sandia.gov>
 <AANLkTikU_F_mRaYC6xE5V9OHaDbyjWJ7fnpVCXkz=tK=@mail.gmail.com>
 <1299182603.4750.128.camel@sale659.sandia.gov> <1299185234.4750.137.camel@sale659.sandia.gov>
 <AANLkTikmVL8soYOR3nQyD3=FXjv-aurcydAVvJVvAOJR@mail.gmail.com>
 <1299188722.4750.140.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33217 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758263Ab1CCWUj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 17:20:39 -0500
In-Reply-To: <1299188722.4750.140.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 3 Mar 2011, Jim Schutt wrote:
> That seems to have fixed this issue.  At least, before
> OSDs would start dying within a few minutes of starting
> up a new file system; it's been over a half hour since
> I started one up with this patch, and all OSDs are still
> running.

That's good news; good catch with SIGPIPE!

Does that mean the original problem with the OSDs getting marked down has 
also gone away for you too?

sage
