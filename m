From: kefu chai <tchaikov@gmail.com>
Subject: drop i386 support
Date: Mon, 11 Jul 2016 14:57:12 +0800
Message-ID: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33240 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933673AbcGKG5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 02:57:21 -0400
Received: by mail-yw0-f182.google.com with SMTP id j17so85124912ywg.0
        for <ceph-devel@vger.kernel.org>; Sun, 10 Jul 2016 23:57:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Cephers,

I am proposing drop the support of i386. as we don't compile Ceph with
any i386 gitbuilder now[1] and hence don't test the i386 builds on
sepia on a regular basis. Also, based on the assumption that people
don't use i386 in production, I think we can drop it from the minimum
hardware document[2]?

And we won't explicitly disable the i386 build in code if we decide to
drop the i386 support, as we always try to be portable if possible.
But just don't claim the i386 as the officially supported arch
anymore.

What do you think?

---
[1] http://ceph.com/gitbuilder.cgi
[2] http://docs.ceph.com/docs/master/start/hardware-recommendations/#minimum-hardware-recommendations


-- 
Regards
Kefu Chai
