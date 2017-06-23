From: yiming xie <platoxym@gmail.com>
Subject: RGW:Implement cross region replication feature
Date: Fri, 23 Jun 2017 13:15:43 +0800
Message-ID: <E89603A8-F3B6-4F99-9F0D-894A54B1C407@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33578 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdFWFPs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jun 2017 01:15:48 -0400
Received: by mail-it0-f65.google.com with SMTP id x12so5362245itb.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 22:15:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ysadehwe@redhat.com, Matt Benjamin <mbenjamin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda and Benjamin:

I want to impl rgw CRR(cross region replication) feature like s3.
I find some limited conditions of s3 CRR=A1=A3
 1. multi-zonegroup can not replication to the same zonegroup on the =
same bucket=A1=A3
  user can not set the logic of replication like this:
   zg1  bucket1 ->  zg3 bucket3
   zg2  bucket2 ->  zg3 bucket3

 2. s3 CRR does not support chain replication. user can set the  logic =
of replication like this=A3=BA
 zg1 bucket1 -> zg2 bucket2 -> zg3 bucket3
 when user wrtie the test file to zg1 bucket1=A3=ACthe test file will =
only be copied from zg1 to zg2, and will not continue from zg2 to zg3

I do not understand why s3 take these strategies. So I can not judge =
whether these strategies apply to rgw=A1=A3

When we achieve this feature, whether we need to adopt these strategies? =
 Tks=A3=A1


plato=
