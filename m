From: Alex Elder <elder@inktank.com>
Subject: Re: drivers/block/rbd.c:2170:19: sparse: symbol 'rbd_dev_create'
 was not declared. Should it be static?
Date: Sun, 23 Dec 2012 10:27:48 -0600
Message-ID: <50D73104.7020805@inktank.com>
References: <20121223013756.GB11275@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40142 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2LWQ1s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Dec 2012 11:27:48 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so8066892ieb.5
        for <ceph-devel@vger.kernel.org>; Sun, 23 Dec 2012 08:27:47 -0800 (PST)
In-Reply-To: <20121223013756.GB11275@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: ceph-devel@vger.kernel.org

On 12/22/2012 07:37 PM, Fengguang Wu wrote:
> Hi Alex,
> 
> FYI, there are new sparse warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
> head:   c3e946ce7276faf0b302acd25c7b874edbeba661
> commit: c53d589337e9a211413484a604c76072e8474dc0 rbd: define rbd_dev_{create,destroy}() helpers
> date:   7 weeks ago

Quote a few of these have been addressed already in some upcoming
patches that didn't get reviewed in time for this cycle.  I appreciate
the notice though, and I'll fix this up soon.

Thanks a lot.

					-Alex

> drivers/block/rbd.c:1293:42: sparse: Using plain integer as NULL pointer
> drivers/block/rbd.c:1341:26: sparse: incorrect type in assignment (different base types)
> drivers/block/rbd.c:1341:26:    expected unsigned long long [unsigned] [usertype] ver
> drivers/block/rbd.c:1341:26:    got restricted __le64 [usertype] <noident>
> drivers/block/rbd.c:1351:46: sparse: Using plain integer as NULL pointer
> drivers/block/rbd.c:1395:26: sparse: incorrect type in assignment (different base types)
> drivers/block/rbd.c:1395:26:    expected unsigned long long [unsigned] [usertype] ver
> drivers/block/rbd.c:1395:26:    got restricted __le64 [usertype] <noident>
> drivers/block/rbd.c:1396:29: sparse: incorrect type in assignment (different base types)
> drivers/block/rbd.c:1396:29:    expected unsigned long long [unsigned] [usertype] cookie
> drivers/block/rbd.c:1396:29:    got restricted __le64 [usertype] <noident>
> drivers/block/rbd.c:1434:29: sparse: incorrect type in assignment (different base types)
> drivers/block/rbd.c:1434:29:    expected unsigned long long [unsigned] [usertype] cookie
> drivers/block/rbd.c:1434:29:    got restricted __le64 [usertype] <noident>
> + drivers/block/rbd.c:2170:19: sparse: symbol 'rbd_dev_create' was not declared. Should it be static?
> drivers/block/rbd.c:2529:17: sparse: incorrect type in assignment (different base types)
> drivers/block/rbd.c:2529:17:    expected restricted __le64 [usertype] snap_id
> drivers/block/rbd.c:2529:17:    got unsigned long long [unsigned] [long] [long long] <noident>
> drivers/block/rbd.c:2530:46: sparse: incorrect type in argument 2 (different base types)
> drivers/block/rbd.c:2530:46:    expected unsigned long long [unsigned] [usertype] snap_id
> drivers/block/rbd.c:2530:46:    got restricted __le64 [usertype] snap_id
> drivers/block/rbd.c:2533:50: sparse: incorrect type in argument 2 (different base types)
> drivers/block/rbd.c:2533:50:    expected unsigned long long [unsigned] [usertype] snap_id
> drivers/block/rbd.c:2533:50:    got restricted __le64 [usertype] snap_id
> drivers/block/rbd.c:1551:32: sparse: context imbalance in 'rbd_rq_fn' - unexpected unlock
> 
> Please consider folding the attached diff :-)
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation
> 

