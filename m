From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: rgw: possibility to put several small S3 objects into single
 rados object
Date: Sat, 23 Dec 2017 01:38:39 +0000
Message-ID: <robbat2-20171223T012457-622692797Z@orbis-terrarum.net>
References: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
Reply-To: Ceph Development <ceph-devel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54860 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756885AbdLWBin (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 22 Dec 2017 20:38:43 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 5158433D4A6
        for <ceph-devel@vger.kernel.org>; Sat, 23 Dec 2017 01:38:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 21, 2017 at 07:35:26PM +0300, Aleksei Gutikov wrote:
> Hi all.
> 
> While rgw bucket index, theoretically, with reasonable latency can 
> handle up to 10M objects (100 shards of 100k each),
> and rgw user's bucket index can handle, theoretically again, up to 100k 
> buckets.
One of the scaling concerns I'd talked about before was bucket indices:
even with shards as you note, performance of large buckets isn't great.
I have pondered about how to redesign the index for performance, and one
of the better performing options I decided at least for the moment was
probably going to be via multiple levels of index.

> Or, maybe it is possible to store small pieces of data in omap?
> As I understand space overhead would be much smaller in this case.
> And what about backfilling and remapping for omap?
I'd go for the OMAP rather than packing into a single RADOS object.
However, how small are you talking about?
Beyond 128 bytes I think it would still be better in an object.

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
