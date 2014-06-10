From: Gregory Farnum <greg@inktank.com>
Subject: Re: Changes of scrubbing?
Date: Tue, 10 Jun 2014 15:33:58 -0700
Message-ID: <CAPYLRziTJKy4DQTASRwDZa2P5cy9qc4Zj7VM2P2QbrntFpKudg@mail.gmail.com>
References: <BLU436-SMTP155ED6E6FBB4FD0E72FC5CDF3C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:45970 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaFJWd7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 18:33:59 -0400
Received: by mail-qa0-f43.google.com with SMTP id k15so1279525qaq.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jun 2014 15:33:59 -0700 (PDT)
In-Reply-To: <BLU436-SMTP155ED6E6FBB4FD0E72FC5CDF3C0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 20, 2014 at 6:44 PM, Guang Yang <yguang11@outlook.com> wrote:
> Hi ceph-devel,
> Like some users of Ceph, we are using Ceph for a latency sensitive project, and scrubbing (especially deep-scrubbing) impacts the SLA in a non-trivial way, as commodity hardware could fail in one way or the other, I think it is essential to have scrubbing enabled to preserve data durability.
>
> Inspired by how erasure coding backend implement scrubbing[1], I am wondering if the following changes is valid to somehow reduce the performance impact from scrubbing:
>  1. Store the CRC checksum along with each physical copy of the object on filesystem (via xattr or omap?)
>  2. For read request, it checks the CRC locally and if it mismatch, redirect the request to a replica and mark the PG as inconsistent.

The problem with this is that you need to maintain the CRC across
partial overwrites of the object. And the real cost of scrubbing isn't
in the network traffic, it's in the disk reads, which you would have
to do anyway with this method. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

>
> This is just a general idea and details (like append) will need to further discussed.
>
> By having such, we can schedule the scrubbing less aggresively but still preserve the durability for read.
>
> Does this make some sense?
>
> [1] http://ceph.com/docs/master/dev/osd_internals/erasure_coding/pgbackend/
>
> Thanks,
> Guang Yang--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
