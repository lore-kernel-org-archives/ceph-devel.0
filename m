From: Ming Lin <minggr@gmail.com>
Subject: Re: rocksdb related build error
Date: Tue, 3 May 2016 14:15:49 -0700
Message-ID: <CAF1ivSZ_wxv9SkGkpw3ry7Bt9+HYBse=BZ+WysPLPFD3we=fNw@mail.gmail.com>
References: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com>
	<alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36480 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbcECVPu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 17:15:50 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so46477225ywc.3
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 14:15:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, John Spray <john.spray@redhat.com>

On Tue, May 3, 2016 at 5:26 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 3 May 2016, Ming Lin wrote:
>> Hi John,
>>
>> I got rocksdb related build error (commit bb7d9c15).
>> Any hint to fix it?
>>
>> It's OK if I build in the ceph source tree.
>
> Out of tree builds don't work currently with autotools.

I just learned a bit about autotools.
https://en.wikipedia.org/wiki/GNU_Build_System

Could you share what the problem is here to support out-of-tree build?
I'll try to write a patch to fix it.

>
> sage
