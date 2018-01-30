From: Chengguang Xu <cgxu519@icloud.com>
Subject: Adding more checks for fscache options
Date: Tue, 30 Jan 2018 21:17:25 +0800
Message-ID: <8299B0B2-B1B2-4C85-A1FC-4C15740F32FA@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:17891 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeA3NRx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jan 2018 08:17:53 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3D00700E7T4Q00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Tue, 30 Jan 2018 13:17:39 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Zheng, Ilya

Recently I=A1=AFve just tested some mount option of cephfs and found =
though
fscache kernel module was disabled but when I specified -o fsc to =
mount.ceph
there is no any indication of warning or failure.

I think it may cause enduser's misunderstanding of fscache function,=20
so I plan to add extra checks to parsing fscache related options in =
kernel side.=20

There are two approaches as below, could you tell me which will be =
better?

If we get conflict condition about fscache.

A. Print error message && Exit mount immediately

B. Only print error message but continue mount process.




Thanks,
Chengguang.



