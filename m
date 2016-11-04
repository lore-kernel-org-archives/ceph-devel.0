From: Sage Weil <sweil@redhat.com>
Subject: RE: rocksdb wal proposed improvement
Date: Fri, 4 Nov 2016 17:33:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611041732090.20331@piezo.us.to>
References: <alpine.DEB.2.11.1611041605190.20331@piezo.us.to> <BY2PR02MB396573EAF55652571831CE3F4A20@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934911AbcKDRdv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 13:33:51 -0400
In-Reply-To: <BY2PR02MB396573EAF55652571831CE3F4A20@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "g.marripudi@samsung.com" <g.marripudi@samsung.com>

On Fri, 4 Nov 2016, Somnath Roy wrote:
> Sage,
> My understanding was rocksdb is already doing this kind of merge before 
> flush. I thought It will always go through 
> min_write_buffer_number_to_merge memTable files and merge the updates, 
> but, it will not be able to merge if same key update came beyond 
> min_write_buffer_number_to_merge files. Am I missing anything ?

It is always merging some range of keys (whether it's in one buffer or 
several buffers doesn't really matter).  The key is that it is merging the 
same set of keys that it is writing to l0.  So whatever the cutoff (in 
time) is, at that point there will always be some number of short-lived 
keys that were alive, and those will get written to l0.

The difference here is that we are using the *next* buffer to strip out 
updated or delete keys, but not actually writing that next buffer's 
contents to l0.

sage


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
> 
> 
