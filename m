From: Xiaoguang Liu <syslxg@gmail.com>
Subject: RBD performance is not good
Date: Tue, 10 Aug 2010 11:23:35 +0800
Message-ID: <AANLkTi=+bAquZFutD=_uwQAgdC3CzcdNz=Mi+5__AVYW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48885 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab0HJDXg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 23:23:36 -0400
Received: by vws3 with SMTP id 3so7303381vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Aug 2010 20:23:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

on my 2-ods-node cluster, dd can only reach 13MB/s on rbd device. this
is much lower than what I expected.
I can get 30-60 MB/s on a ceph filesystem over the same cluster.

any idea?




[root@ceph-1 ~]# dd if=/dev/zero of=/dev/rbd0  bs=1M count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB) copied, 391.508 s, 13.4 MB/s
