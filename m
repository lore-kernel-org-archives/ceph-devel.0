From: Mike A <mike.almateia@gmail.com>
Subject: Bluestore and jemalloc
Date: Fri, 15 Dec 2017 12:48:41 +0300
Message-ID: <42631468-7CF3-4BBC-8984-24756D6F930F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:39185 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756000AbdLOJsp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 04:48:45 -0500
Received: by mail-lf0-f44.google.com with SMTP id 6so1271187lfa.6
        for <ceph-devel@vger.kernel.org>; Fri, 15 Dec 2017 01:48:45 -0800 (PST)
Received: from [172.20.10.3] ([213.87.155.170])
        by smtp.gmail.com with ESMTPSA id d1sm1146092ljf.66.2017.12.15.01.48.43
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 01:48:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello!

After fix this issue http://tracker.ceph.com/issues/20557 Ceph is still =
working with jemalloc? Or it=E2=80=99s not possible right now only after =
will be fix a issue in rocksdb?

I have a work to create a cluster based on nvme disks with jemalloc =
enabled configuration. Now I'm worried jemalloc support in ceph about.

=E2=80=94=20
Mike, runs!=
