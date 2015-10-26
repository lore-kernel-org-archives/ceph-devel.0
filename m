From: Jaze Lee <jazeltq@gmail.com>
Subject: why package ceph-fuse needs packages ceph?
Date: Mon, 26 Oct 2015 10:22:40 +0800
Message-ID: <CAKZcxgdm9fQEDqV3=t36_YfxoejzxAyEUL6MNCXn0MwEzCGjkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35259 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbJZCWl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Oct 2015 22:22:41 -0400
Received: by lfbn126 with SMTP id n126so97627826lfb.2
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2015 19:22:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
    I think the ceph-fuse is just a client, why it needs packages ceph?
    I found when i install ceph-fuse, it will install package ceph.
    But when i install ceph-common, it will not install package ceph.

    May be ceph-fuse is not just a ceph client?


--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
