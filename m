From: Christian Brunner <chb@muc.de>
Subject: rbd snapshot copy
Date: Fri, 19 Aug 2011 10:46:26 +0200
Message-ID: <CAO47_-8Lx=uBk5AiXJ=ute_x62USqF-ZjURbJ1ww38afaTCMWg@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38204 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1HSIq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2011 04:46:27 -0400
Received: by vws1 with SMTP id 1so2221898vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2011 01:46:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I tried using rbd snapshots for the first time today. Creating a
snapshot works, but I'm not able to copy the snapshot to a new volume
(I'm still using 0.32).

Here is what I get:

# rbd snap create --snap=mysnapshot myimage
# rbd cp --snap=mysnapshot myimage mysnapcopy
*** Caught signal (Segmentation fault) **
 in thread 0x7fd91280a720
 ceph version 0.32 (commit:c08d08baa6a945d989427563e46c992f757ad5eb)
 1: rbd() [0x449034]
 2: (()+0xf520) [0x7fd911e00520]
 3: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10) [0x7fd9123eb6a0]
 4: (main()+0x49f) [0x443bcf]
 5: (__libc_start_main()+0xfd) [0x7fd9109f4c9d]
 6: rbd() [0x440f29]
Segmentation fault


Is this a bug or am I using the wrong syntax?

Thanks,
Christian
