From: zengran zhang <z13121369189@gmail.com>
Subject: question about ec partial read in a single stripe
Date: Thu, 9 Nov 2017 19:10:15 +0800
Message-ID: <CALi+v180b0934jMAHb100O6jQ2oqMZM9a=SMWBvzhrQ0H0qm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:49015 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdKILKQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 06:10:16 -0500
Received: by mail-it0-f65.google.com with SMTP id c3so10785661itc.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 03:10:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all:
    we found that partial read will cause full stripe read  in now ec
impl, for example:
    we have 4 chunks per stripe, 4K size per chunks and 16K per
stripe, when we read rand 2K in a stripe,the reads
will amplify to full stripe(16K +8K(Parity))..

    i did not see any checksum or buffer  related factor except the ec
extentcache.does the extentcache is the purpuse of the mechanism?
now we want increase the stripe width to improve the small random raed
performance, but the mechanism limit the result...

    best regards!
