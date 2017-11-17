From: "Cosmin V. Miron (Cosmic Sound)" <siravecavec@gmail.com>
Subject: Errors in Ceph
Date: Fri, 17 Nov 2017 05:44:23 +0100
Message-ID: <EEE45246-CCAE-4A36-97D6-9FB69D626949@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.11\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34362 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbdKQEo0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Nov 2017 23:44:26 -0500
Received: by mail-wm0-f51.google.com with SMTP id y82so2007760wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 20:44:26 -0800 (PST)
Received: from [127.0.0.1] (ip-89-103-38-77.net.upcbroadband.cz. [89.103.38.77])
        by smtp.gmail.com with ESMTPSA id o22sm6216771wrb.40.2017.11.16.20.44.24
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 20:44:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

root@node02-sxb-pve01:/vz/images# /usr/bin/ceph-osd -f --cluster ceph =
--id 1 --setuser ceph --setgroup ceph --debug_osd=3D30/30
starting osd.1 at :/0 osd_data /var/lib/ceph/osd/ceph-1 =
/var/lib/ceph/osd/ceph-1/journal
osd/OSD.h: In function 'OSDMapRef OSDService::get_map(epoch_t)' thread =
7f8db685f800 time 2017-11-17 05:08:47.892444
osd/OSD.h: 894: FAILED assert(ret)

https://pastebin.com/9QjvKAce=
