From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: difference between qemu cache settings and ceph.conf rbd cache settings?
Date: Tue, 19 Jun 2012 08:37:41 +0200
Message-ID: <4FE01E35.1080002@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45289 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab2FSGhp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 02:37:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've now patched my qemu to include the qemu cache settings for rbd.

Now i can change my drive caching mode. But there are also these 
settings for global section in ceph.conf.

         rbd_cache = true
         rbd_cache_size = 33554432
         rbd_cache_max_age = 2.0

How do they influence or replace each other?

thanks
Stefan
