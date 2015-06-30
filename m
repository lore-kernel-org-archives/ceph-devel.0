From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Inline dedup/compression
Date: Tue, 30 Jun 2015 16:20:47 +1000
Message-ID: <CA+z5Dsw5_5zNKwDiGA22jGaRYh=KhD8u0not0u36iw=nqT7h5g@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
 <CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
 <99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
 <CACJqLyY2P0_O-MRs9MoH1oVg8jESc0EoAjSq4dYmVjH=K0a0mQ@mail.gmail.com>
 <99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com> <CACJqLyY_FYYx9AvK5ShfN+NUKiz25S=w4qPa36sEYN8hFOy-jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33596 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbF3GVH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 02:21:07 -0400
Received: by ieqy10 with SMTP id y10so5711586ieq.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 23:21:06 -0700 (PDT)
In-Reply-To: <CACJqLyY_FYYx9AvK5ShfN+NUKiz25S=w4qPa36sEYN8hFOy-jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 30 June 2015 at 16:03, Haomai Wang <haomaiwang@gmail.com> wrote:
> On Tue, Jun 30, 2015 at 4:55 AM, James (Fei) Liu-SSI
> <james.liu@ssi.samsung.com> wrote:
>> Hi Haomai,
>>   Thanks for moving the idea forward. Regarding to the compression.  However,  if we do compression on the client level, it is not global. And the compression was only applied to the local client, am I right?  I think there is pros and cons in two solutions and we can get into details more for each solution.
>
> Yes, I think a lot myself about compression with Ceph. At firstly, we
> could easily use objectstore backend to implement compress like
> filestore with zfs/btrfs and keyvaluestore with leveldb/rocksdb etc.
> The advantages are we can enjoy it now. The cons are we may lose too
> much for benefit of compression especially for performance.

If you were going to compress at the OSD I imagine the main
performance concern would be about adding to write latency? That might
be mitigated by only compressing the actual datastore and not the
journal?

I like the idea of having a compress option implemented in e.g. librbd
and rgw, both of these cases involve scale-out clients and so concerns
of performance overhead can be largely brushed aside (e.g., most
OpenStack hypervisors seem to have plenty of free CPU).

-- 
Cheers,
~Blairo
