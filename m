From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: inconsistent file issue
Date: Wed, 20 Sep 2017 11:42:22 +0800
Message-ID: <571AAE95-D681-4887-BBFA-86163B6DA800@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36436 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdITDm0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 23:42:26 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so940852pgt.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 20:42:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>, pdonnell@redhat.com, ceph-devel@vger.kernel.org

Hi Zheng,=20

we have been suffering from an inconsistent issue in cephfs :

kernel version : 3.1.0=20
ceph version: 10.2.5

we are using the kernel client to mount cephfs
we mount the ceph filesystem on two machines all with kernel 3.1.0,=20
but the strange thing is that the content of one same file is different =
from the two machines.=20
and we are certain one machine has the correct content.

 we didn=A1=AFt know the way to reproduce it , and we don=A1=AFt have =
the log here.
 i=A1=AFm wondering maybe it=A1=AFs because  there is some bug within =
kernel client, so that the client think
 it has enough capability to read it just from it=A1=AFs buffer, no need =
to get the cap from mds, so it didn=A1=AFt get the latest content.

 since the kernel is too old, may be you have fixed this kind =
inconsistent issues ?
=20
Regards,
Dongdong
=20=
