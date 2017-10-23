From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: multiple client read/write in cephfs
Date: Mon, 23 Oct 2017 12:50:07 +0800
Message-ID: <F6B9A347-CD3E-42BF-B65A-3BAF61C1C284@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45007 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdJWEuL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 00:50:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id x7so16212794pfa.1
        for <ceph-devel@vger.kernel.org>; Sun, 22 Oct 2017 21:50:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, pdonnell@redhat.com, "Yan, Zheng" <ukernel@gmail.com>

Dear Cephers,

I have one issue about cephfs, suppose we got below scenario:
client A write one file with interval1 (offset1, length1)
then client B read the same file with interval2 (offset2, length2).
but due to capability system controlled by mds,  client B have to wait =
until client A finish its write operation (including flushing its buffer =
to osd)
Even if interval1 and interval2 belongs to two different object of that =
file,  client B still  have to wait client A.

I=A1=AFm wondering why mds doesn=A1=AFt try to control the caps based on =
object rather than whole file?=20

Thanks,
Dongdong=
