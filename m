From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Regarding ceph rbd write path
Date: Sat, 4 Apr 2015 12:46:38 +0800
Message-ID: <CACJqLyaP5AGcgRS2XjDd+OroYpoJVB0rMjqP1b2TcJFF6ob73g@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB9849@SACMBXIP01.sdcorp.global.sandisk.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28CB9860@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36449 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbDDEqj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Apr 2015 00:46:39 -0400
Received: by iebrs15 with SMTP id rs15so16946090ieb.3
        for <ceph-devel@vger.kernel.org>; Fri, 03 Apr 2015 21:46:38 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB9860@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Apr 4, 2015 at 8:30 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> In fact, we can probably do it from the OSD side like this.
>
> 1. A thread in the sharded opWq is taking the ops within a pg by acquiring lock in the pg_for_processing data structure.
>
> 2. Now, before taking the job, it can do a bit processing to look for the same object transaction in the map till that time and coalesce that to a single job.
>
> Let me know if I am missing anything.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Friday, April 03, 2015 5:17 PM
> To: ceph-devel@vger.kernel.org
> Subject: Regarding ceph rbd write path
>
>
> Hi Sage/Sam,
> Here is my understanding on ceph rbd write path.
>
> 1. Based on the image order rbd will decide the rados object size, say 4MB.
>
> 2. Now, from application say 64K chunks are being written to the rbd image.
>
> 3. rbd will calculate the objectids (one of the 4MB objects) and start populating the 4MB objects with 64K chunks.
>
> 4. Now, for each of this 64K chunk OSD will write 2 setattrs and the OMAP attrs.
>
> If the above flow is correct, it is updating the same metadata for every 64K chunk write to the same object (and same pg). So, my question is, is there any way to optimize (coalesce) that in either rbd/osd layer ?
> I couldn't find any way in the osd layer as it is holding pg->lock till a transaction complete. But, is there any way in the rbd side so that it can intelligently stage/coalesce the writes for the same object and do a batch commit?
> This should definitely improve WA/performance for seq writes, may not be much for random though.

Do you consider to use RBDCache? It could cover most of cases you said I think.

>
> Let me know your opinion on this.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
