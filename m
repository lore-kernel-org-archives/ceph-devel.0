From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Wed, 17 Sep 2014 14:20:27 -0700
Message-ID: <5419FB1B.4020202@inktank.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F27845984@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35868 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584AbaIQV2o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 17:28:44 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F27845984@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/17/2014 01:55 PM, Somnath Roy wrote:
> Hi Sage,
> We are experiencing severe librbd performance degradation in Giant over firefly release. Here is the experiment we did to isolate it as a librbd problem.
>
> 1. Single OSD is running latest Giant and client is running fio rbd on top of firefly based librbd/librados. For one client it is giving ~11-12K  iops (4K RR).
> 2. Single OSD is running Giant and client is running fio rbd on top of Giant based librbd/librados. For one client it is giving ~1.9K  iops (4K RR).
> 3. Single OSD is running latest Giant and client is running Giant based ceph_smaiobench on top of giant librados. For one client it is giving ~11-12K  iops (4K RR).
> 4. Giant RGW on top of Giant OSD is also scaling.
>
>
> So, it is obvious from the above that recent librbd has issues. I will raise a tracker to track this.

For giant the default cache settings changed to:

rbd cache = true
rbd cache writethrough until flush = true

If fio isn't sending flushes as the test is running, the cache will
stay in writethrough mode. Does the difference remain if you set rbd
cache writethrough until flush = false ?

Josh
