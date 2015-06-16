From: Mike <mike.almateia@gmail.com>
Subject: Move RBD Cache on clients from RAM to SSD.
Date: Tue, 16 Jun 2015 10:59:40 +0300
Message-ID: <557FD76C.9070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36105 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbFPH7o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 03:59:44 -0400
Received: by lbbqq2 with SMTP id qq2so5458824lbb.3
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 00:59:43 -0700 (PDT)
Received: from mike.0xFFF ([212.34.43.122])
        by mx.google.com with ESMTPSA id oq2sm57005lbb.34.2015.06.16.00.59.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2015 00:59:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello.

By now rbd_cache uses RAM, can we store cache on disk (SSD, SSD NVE)?
In this way I look some benefits:
* Don't waste a RAM for cache
* Can make a big cache on SSD: 2-8Gb per cache
* If you use Cache Tier - don't waste space on them
* No need addition Ceph servers - use Compute with SSD.

Yes it's for write-through and read-only cache strategies mostly.

Any ideas? My be I am blind and this idea totally stupid?

