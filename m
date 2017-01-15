From: Alex Elder <elder@ieee.org>
Subject: Re: bad crc in data caused by a race condtion in
 write_partial_message_data
Date: Sun, 15 Jan 2017 10:26:38 -0600
Message-ID: <c76646be-7b1f-0627-9fa0-05624f4e4fb4@ieee.org>
References: <20170115074525.GA35305@T530I>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36752 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdAOQ0l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jan 2017 11:26:41 -0500
Received: by mail-io0-f174.google.com with SMTP id j13so76834855iod.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 Jan 2017 08:26:40 -0800 (PST)
In-Reply-To: <20170115074525.GA35305@T530I>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: caifeng.zhu@uniswdc.com, ceph-devel@vger.kernel.org

On 01/15/2017 01:45 AM, caifeng.zhu@uniswdc.com wrote:
> Hi, all
> 
> Let's look at the problem first. We have a lot of 'bad crc in data' 
> warnings at OSDs, like below:
>     2017-01-14 23:25:54.671599 7f67201b3700  0 bad crc in data 1480547403 != exp 3751318843
>     2017-01-14 23:25:54.681146 7f67201b3700  0 bad crc in data 3044715775 != exp 3018112170
>     2017-01-14 23:25:54.681822 7f67201b3700  0 bad crc in data 2815383560 != exp 1455746011
>     2017-01-14 23:25:54.686106 7f67205da700  0 bad crc in data 1781929234 != exp 498105391
>     2017-01-14 23:25:54.688092 7f67205da700  0 bad crc in data 1845054835 != exp 3337474350
>     2017-01-14 23:25:54.693225 7f67205da700  0 bad crc in data 1518733907 != exp 3781627678
>     2017-01-14 23:25:54.755653 7f6724115700  0 bad crc in data 1173337243 != exp 3759627242
>     ...
> This problem occurs when we are testing(by fio) an NFS client, whose NFS server is
> built on an XFS + RBD combination. The bad effect of the problem is that: OSD will close 
> the connection of crc error and drop all reply messages sent through the connection. 
> But the kernel rbd client will hold the requests and wait for the already dropped
> replies which will never come. A deadlock occurs.

The first problem is the reports of bad CRCs.  And the OSD reporting
this for messages sent by the RBD kernel client makes sense, given
what you say below.

Your statement that a deadlock occurs after that doesn't sound right.
Are these services (OSDs, RBD client, NFS client) running on different
machines?

> After some analysis, we suspect write_partial_message_data may have a race condtion. 
> (Code below is got from gitbub.)
>     1562		page = ceph_msg_data_next(cursor, &page_offset, &length,
>     1563					  &last_piece);
>     1564		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
>     1565					length, !last_piece);
>     ...
>     1572		if (do_datacrc && cursor->need_crc)
>     1573			crc = ceph_crc32c_page(crc, page, page_offset, length);
> At line 1564 ~ 1572, a worker thread of libceph workquue may send the page out by TCP 
> and compute the CRC. But simultaneously, at the VFS/XFS level, there may be another thread
> writing to file position cached by the sending-out page. If page sending and crc compution 
> is interleaved by data writing, bad CRC will be complained by the receiving OSD.

This should not be happening.  Data supplied to the Ceph messenger
for sending can no longer be subject to modification.

> To verify our suspection, we add the debug patch below:

Your patch does indeed seem to show that a page is modified
during the call to ceph_tcp_sendpage().  But again, that should
not be happening.

I hope I'm not missing something obvious here...

> (Code below is based on our linux version.)
> @@ -1527,9 +1527,14 @@ static int write_partial_message_data(st
>                 bool last_piece;
>                 bool need_crc;
>                 int ret;
> +               u32 crc2 = 0;
> 
>                 page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
>                                                         &last_piece);
> +
> +               if (do_datacrc && cursor->need_crc)
> +                       crc2 = ceph_crc32c_page(crc, page, page_offset, length);
> +
>                 ret = ceph_tcp_sendpage(con->sock, page, page_offset,
>                                       length, last_piece);
>                 if (ret <= 0) {
> @@ -1538,8 +1543,12 @@ static int write_partial_message_data(st
> 
>                         return ret;
>                 }
> -               if (do_datacrc && cursor->need_crc)
> +               if (do_datacrc && cursor->need_crc) {
>                         crc = ceph_crc32c_page(crc, page, page_offset, length);
> +                       if (crc2 != crc)
> +                               pr_warn("tampered page %p: "
> +                                   "before 0x%x, current 0x%x\n", page, crc2, crc);
> +               }
>                 need_crc = ceph_msg_data_advance(&msg->cursor, (size_t)ret);
>         }
> And get the the warning messages below
>     [Sun Jan 15 14:11:29 2017] libceph: tampered page ffffea002a8fb140: before 0x1aa3b794, current 0x5fe707d6
>     [Sun Jan 15 14:11:29 2017] libceph: tampered page ffffea002122f680: before 0xec71a744, current 0x9b7d382f
>     [Sun Jan 15 14:11:29 2017] libceph: tampered page ffffea002372b740: before 0xa1849173, current 0x888a93c1
>     [Sun Jan 15 14:11:30 2017] libceph: tampered page ffffea0027a5a500: before 0x6fcb56ac, current 0x1b9aeced
> 
> A possible solution may be that: if crc checking is enabled, the page should be copied 
> for sending and crc computation. Is that OK?

Sending a copied page would ensure the page you're sending doesn't
change.  But if someone else is modifying the original, there's no
way of knowing whether the copied page is really intact either.

Sending a copy would treat a symptom and not the underlying problem.
So I'd say "no, that's not OK."

					-Alex

> 
> Best Regards.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

