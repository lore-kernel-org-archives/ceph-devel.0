From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: severe librbd performance degradation in Giant
Date: Wed, 17 Sep 2014 21:29:20 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F278459F8@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F27845984@SACMBXIP02.sdcorp.global.sandisk.com>
 <5419FB1B.4020202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:21531
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757330AbaIQVah convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 17:30:37 -0400
In-Reply-To: <5419FB1B.4020202@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I set the following in the client side /etc/ceph/ceph.conf where I am running fio rbd.

rbd_cache_writethrough_until_flush = false

But, no difference. BTW, I am doing Random read, not write. Still this setting applies ?

Next, I tried to tweak the rbd_cache setting to false and I *got back* the old performance. Now, it is similar to firefly throughput !

So, loks like rbd_cache=true was the culprit.

Thanks Josh !

Regards
Somnath

-----Original Message-----
From: Josh Durgin [mailto:josh.durgin@inktank.com]
Sent: Wednesday, September 17, 2014 2:20 PM
To: Somnath Roy; ceph-devel@vger.kernel.org
Subject: Re: severe librbd performance degradation in Giant

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

If fio isn't sending flushes as the test is running, the cache will stay in writethrough mode. Does the difference remain if you set rbd cache writethrough until flush = false ?

Josh

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

