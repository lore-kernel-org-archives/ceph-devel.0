From: Jai <jai_97@rediffmail.com>
Subject: make error while building ceph
Date: Sun, 28 Feb 2016 15:59:28 +0530
Message-ID: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35784 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbcB1K3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Feb 2016 05:29:49 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so66137235lbc.2
        for <ceph-devel@vger.kernel.org>; Sun, 28 Feb 2016 02:29:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I followed instructions in the README, but "make" gives me this error --

In file included from ./include/types.h:21:0,
                 from kv/LevelDBStore.h:6,
                 from kv/KeyValueDB.cc:5:
./include/uuid.h:14:42: fatal error: boost/random/random_device.hpp:
No such file or directory
compilation terminated.

I m compiling on ubuntu, and it looks like I have boost headers
(/usr/include/boost), but this file is absent. llibboost appears to be
1.46.1
appreciate any pointers to resolve this error.

Also, I couldn't access the web page for bugs
(http://tracker.newdream.net/projects/ceph) - where can I find a list
of bugs/ features ?
--
Jai
