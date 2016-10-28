From: Jaze Lee <jazeltq@gmail.com>
Subject: [rbd] should we add iov support to read/write/aio_read/aio_write
Date: Fri, 28 Oct 2016 16:36:18 +0800
Message-ID: <CAKZcxgdxpjv1SATfb5vx7SypnCbmywLPu3MYU+TJOwxO-bUV5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36507 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936640AbcJ1Iga (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2016 04:36:30 -0400
Received: by mail-oi0-f48.google.com with SMTP id n202so101154613oig.3
        for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2016 01:36:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
    Should we add iov support at rbd level ?  I think add iov support
will be valuable for cloud vm which use ceph as the backend.





--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
