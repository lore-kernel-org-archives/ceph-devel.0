From: Sage Weil <sweil@redhat.com>
Subject: RE: rocksdb wal proposed improvement
Date: Fri, 4 Nov 2016 17:38:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611041735530.20331@piezo.us.to>
References: <alpine.DEB.2.11.1611041605190.20331@piezo.us.to> <BY2PR02MB396573EAF55652571831CE3F4A20@BY2PR02MB396.namprd02.prod.outlook.com> <BY2PR02MB396C98FBEF3854409E23BB5F4A20@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935292AbcKDRiH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 13:38:07 -0400
In-Reply-To: <BY2PR02MB396C98FBEF3854409E23BB5F4A20@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "g.marripudi@samsung.com" <g.marripudi@samsung.com>

On Fri, 4 Nov 2016, Somnath Roy wrote:
> Ohh I see what you are saying, you are saying rather than merging two 
> files completely, take the first file and check for updates for in the 
> 2nd and flush only the 1st..May be we should take 1st one and check for 
> updates for the min_write_buffer_number_to_merge and flush the 1st 
> one..Likewise for others..

Exactly :)

Could probably get fancy by adding options like 
min_write_buffer_to_merge_against or something so that we merge N + M and 
write N, but I don't think it matters too much.

Either way, we're spending some extra CPU examining the next buffer, but 
we save on IO, and probably eventually save on CPU in the long term once 
you factor in compaction.

sage


> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Friday, November 04, 2016 10:07 AM
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org; g.marripudi@samsung.com
> Subject: RE: rocksdb wal proposed improvement
> 
> Sage,
> My understanding was rocksdb is already doing this kind of merge before flush. I thought It will always go through min_write_buffer_number_to_merge memTable files and merge the updates, but, it will not be able to merge if same key update came beyond min_write_buffer_number_to_merge files. Am I missing anything ?
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, November 04, 2016 9:06 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org; g.marripudi@samsung.com
> Subject: rocksdb wal proposed improvement
> 
> Here's a quick write-up of what I think we should improve in rocksdb:
> 
> http://pad.ceph.com/p/rocksdb-wal-improvement
> 
> sage
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
