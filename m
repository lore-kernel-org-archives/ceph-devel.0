From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 9 Mar 2011 11:37:04 -0800
Message-ID: <144B52A5BA504DCB992CD253287A397A@gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63834 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1CIThI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 14:37:08 -0500
Received: by qyk7 with SMTP id 7so4157823qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 11:37:08 -0800 (PST)
In-Reply-To: <1299695809.4750.346.camel@sale659.sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>


On Wednesday, March 9, 2011 at 10:36 AM, Jim Schutt wrote:
> Here's another example with more debugging. The
> PG count during this interval is:
> 
> 2011-03-09 10:35:58.306942 pg v379: 25344 pgs: 25344 active+clean; 12119 MB data, 12025 MB used, 44579 GB / 44787 GB avail
> 2011-03-09 10:36:42.177728 pg v462: 25344 pgs: 25344 active+clean; 46375 MB data, 72672 MB used, 44520 GB / 44787 GB avail
> 
> Check out the interval 10:36:23.473356 -- 10:36:27.922262
> 
> It looks to me like a heartbeat message submission is 
> waiting on something?

Yes, it sure does. The only thing that should block between those output messages is getting the messenger lock, which *ought* be fast. Either there are a lot of threads trying to send messages and the heartbeat thread is just getting unlucky, or there's a mistake in where and how the messenger locks (which is certainly possible, but in a brief audit it looks correct).
-Greg



