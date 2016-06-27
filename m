From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Questions for NVRAM+SATA SSDs with Bluestore
Date: Mon, 27 Jun 2016 11:31:48 +0900
Message-ID: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36640 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcF0Cbt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jun 2016 22:31:49 -0400
Received: by mail-io0-f173.google.com with SMTP id s63so137608684ioi.3
        for <ceph-devel@vger.kernel.org>; Sun, 26 Jun 2016 19:31:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, I have questions for bluestore (4K random write case).

So far, we have used NVRAM(PCIe) as journal and SSD (SATA) as data
disk (filestore).
Therefore, we got performance gain from NVRAM journal.
However, current Bluestore design seems that data (4K aligned) is
written to data disk first, then metadata is written to WAL rocksdb.
This design can remove =E2=80=9Cdouble write=E2=80=9D in objectstore, b=
ut in our case,
NVRAM can not be utilized fully.

 So, my questions are that

1. Can bluestore write WAL first as filestore?

2. If not, using bcache or flashcache for NVRAM on top of SSDs is right=
 answer?


Thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
