From: zengran zhang <z13121369189@gmail.com>
Subject: Re: question about ec partial read in a single stripe
Date: Thu, 9 Nov 2017 20:50:47 +0800
Message-ID: <CALi+v1891EADZewy-7tV1iY_+5sqtpTddCE=8EzycbXHOtprww@mail.gmail.com>
References: <CALi+v180b0934jMAHb100O6jQ2oqMZM9a=SMWBvzhrQ0H0qm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:48759 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754436AbdKIMus (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 07:50:48 -0500
Received: by mail-io0-f170.google.com with SMTP id d66so9711671ioe.5
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 04:50:48 -0800 (PST)
In-Reply-To: <CALi+v180b0934jMAHb100O6jQ2oqMZM9a=SMWBvzhrQ0H0qm4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

i found a discuss on two years ago
(http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/23872)
and a pr commited by

XinzeChi(https://github.com/ceph/ceph/pull/4467)...

2017-11-09 19:10 GMT+08:00 zengran zhang <z13121369189@gmail.com>:
> Hi all:
>     we found that partial read will cause full stripe read  in now ec
> impl, for example:
>     we have 4 chunks per stripe, 4K size per chunks and 16K per
> stripe, when we read rand 2K in a stripe,the reads
> will amplify to full stripe(16K +8K(Parity))..
>
>     i did not see any checksum or buffer  related factor except the ec
> extentcache.does the extentcache is the purpuse of the mechanism?
> now we want increase the stripe width to improve the small random raed
> performance, but the mechanism limit the result...
>
>     best regards!
