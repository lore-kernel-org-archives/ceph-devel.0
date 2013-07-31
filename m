From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: Blueprint: Add LevelDB support to ceph cluster backend store
Date: Wed, 31 Jul 2013 14:04:05 +0800
Message-ID: <CAMm-wcJb-K_eqcKcVVTn8M7ZW_eqDjkeb-b_KhE0b7xLHQEvKg@mail.gmail.com>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
	<kta8j6$51o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:51081 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab3GaGEH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 02:04:07 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so287643vbf.21
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 23:04:06 -0700 (PDT)
In-Reply-To: <kta8j6$51o$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

We have the same idea and already tested the LevelDB Performance VS
Btrfs.  The result is negative, especially for big block IO.

                                                  1KB Block     4KB
Block    8KB Block     128KB Block    1MB Block
LevelDB with Compress:        1.77MB/s       5.15MB/s     6.44MB/s
    7.64MB/s        13.61MB/s
LevelDB without Compress:   1.12MB/s       3.21MB/s     4.57MB/s
  7.28MB/s        13.28MB/s
Btrfs                                           13.84MB/s
12.96MB/s  18.29MB/s       95.26MB/s      109.23MB/s

On 31 July 2013 06:54, Alex Elsayed <eternaleye@gmail.com> wrote:
> I posted this as a comment on the blueprint, but I figured I'd say it here:
>
> The thing I'd worry about here is that LevelDB's performance (along with
> that of various other K/V stores) falls off a cliff for large values.
>
> Symas (who make LMDB, used by OpenLDAP) did some benchmarking that shows
> drastic performance loss with 100KB values on both read and write:
> http://symas.com/mdb/microbench/#sec4
>
> It's not just disk latency, either - an SSD showed the same behavior:
> http://symas.com/mdb/microbench/#sec7
>
> I'd recommend REALLY careful benchmarking with a variety of loads (and value
> sizes).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
