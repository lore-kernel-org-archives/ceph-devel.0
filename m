From: Samuel Just <sam.just@inktank.com>
Subject: Re: Bucket index op - lock contention hang op threads
Date: Thu, 5 Feb 2015 11:52:04 -0800
Message-ID: <CA+4uBUbN_mW=M0oAW64CF=xWZFt6O4D3m45jPu2VTxMj2KykgA@mail.gmail.com>
References: <BLU175-W313E35FB584EA01A9D258CDF3B0@phx.gbl>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51103 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbbBETwG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 14:52:06 -0500
Received: by mail-lb0-f181.google.com with SMTP id u14so4550678lbd.12
        for <ceph-devel@vger.kernel.org>; Thu, 05 Feb 2015 11:52:04 -0800 (PST)
In-Reply-To: <BLU175-W313E35FB584EA01A9D258CDF3B0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sweil@redhat.com>

Recent changes already merged for hammer should prevent blocking the
thread on the ondisk_read_lock by expanding the ObjectContext::rwstate
lists mostly as you suggested.
-Sam

On Thu, Feb 5, 2015 at 1:36 AM, GuangYang <yguang11@outlook.com> wrote:
> Hi ceph-devel,
> In our ceph cluster (with rgw), we came across a problem that all rgw process are stuck (all worker threads wait for the response from OSD, and start giving 500 to clients). objecter_requests dump showed the slow in flight requests were caused by one OSD, which has 2 PGs doing backfilling and it has 2 bucket index objects.
>
> At OSD side, we configure 8 threads, it turned out when this problem occurred, several op threads took seconds (even tens of seconds) handling bucket index op, with most of time waiting for the ondisk_read_lock. As a result, the throughput of the op threads drop (qlen increasing).
>
> I am wondering what options we can pursue to improve the situation, some general ideas on my mind:
>  1> Similar to OpContext::rwstate, instead of make the op thread stuck, put this op to a waiting list and notify upon lock available. I am not sure if this worth it or break anything.
>  2> Differentiate the service class at filestore level for such OP - somebody is waiting for its release of the lock. Does this break any assumption at filestore layer?
>
> As we are using EC (8+3), the fan out is more than replication pool, such kind of slow from one OSD could be cascading to more OSDs easier.
>
> BTW, I created a tracker for this - http://tracker.ceph.com/issues/10739
>
> Look forward to your suggestions.
>
> Thanks,
> Guang                                     --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
