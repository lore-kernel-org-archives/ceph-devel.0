From: Ning Yao <zay11022@gmail.com>
Subject: Disable fiemap lead to Data In-balance between OSD
Date: Thu, 29 Sep 2016 00:26:29 +0800
Message-ID: <CALZt5jzUheF7C4OuYJ2hDwjserLX3wXgtDTZQM6Nk+C1k1QhTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36322 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbcI1Q0b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 12:26:31 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so52145224qkc.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2016 09:26:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

As lots of fiemap issues in XFS, fiemap is default disabled now,
especially in Hammer, before seek_data, seek_hole is added.

But disabling fiemap feature will cause a small sparse object become a
large full object during PushOps, which may lead to notably data
in-balance between OSD, especially on the new added OSD  during data
rebalance. With those full objects, some OSDs may simultaneously
becomes full.

Furthermore, currently, it is impossible to make the full objects
sparse again if we enable the fiemap feature in the future.

So I think if any solutions to make a full object back to a sparse
object again?=E3=80=80One of the idea is to check whether the content in th=
e
object contains consecutive zero and punch zeros for those object
during deep-scrub,  is that possible and reasonable?



Regards
Ning Yao
