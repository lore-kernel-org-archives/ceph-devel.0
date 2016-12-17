From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore performance bottleneck
Date: Sat, 17 Dec 2016 08:32:10 -0600
Message-ID: <c833aac3-8046-e73b-cef6-70de3417a50d@redhat.com>
References: <5E3E05AED7F0F044904275810D0CB465039482@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbcLQOcM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 17 Dec 2016 09:32:12 -0500
In-Reply-To: <5E3E05AED7F0F044904275810D0CB465039482@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/16/2016 09:22 PM, Somnath Roy wrote:
> Sage,
> Some update on this. Without decode_some within fault_range() I am able to drive Bluestore + rocksdb close to ~38K iops compare to ~20K iops with decode_some. I had to disable data write because I am skipping decode but in this device data write is not a bottleneck. I have seen enabling/disabling data write is giving similar result. So, in NVME device if we can optimize decode_some() for performance Bluestore performance should bump up by ~2X.
> I did some print around decode_some() and it seems it is taking ~60-121 micro sec to finish depending on bytes to decode.

Interesting!  varint decoding is pretty inefficient afaik.  I had been 
meaning to go back and trying some alternate encoding/decoding schemes. 
Sounds like this is a good reason to go back and give it a go.

Mark

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, December 15, 2016 7:30 PM
> To: Sage Weil (sweil@redhat.com)
> Cc: ceph-devel
> Subject: Bluestore performance bottleneck
>
> Sage,
> Today morning I was talking about 2x performance drop for Bluestore without data/db writes for 1G vs 60G volumes and it turn out the decode_some() is the culprit for that. Presently, I am drilling down that function to identify what exactly causing this issue, but, most probably it is blob decode and le->blob->get_ref() combination. Will confirm that soon. If we can fix that we should be able to considerably bump up end-to-end pick performance with rocks/ZS on faster NVME. Slower devices most likely we will not be able to see any benefits other than saving some cpu cost.
>
> Thanks & Regards
> Somnath
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
