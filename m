From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: rocked crash in 12.1.0 release when ran fio+libfio_objectstore.so
Date: Wed, 12 Jul 2017 21:08:16 +0800
Message-ID: <CAMwhyqW3vhQRrwRkoxGsbDp8NQZcqA3tVm9eO_E-pb1T3sFANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33079 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdGLNIR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 09:08:17 -0400
Received: by mail-ua0-f169.google.com with SMTP id w19so13984297uac.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 06:08:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, 20702390@qq.com

Hi Cephers,

When I ran fio_libfio_objectstore.so, I met a crash below after ran 10 mins=
:

https://drive.google.com/open?id=3D0B1m1ON51YNOSTFRHRng3YksxRkk

I made three disk partitions=EF=BC=9A
1) db part, 50GB
2) wal part, 50GB
3) data part, others.

I used all default options of RocksDB.

Could anybody have some opinion?

Thanks
Pan
