From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: difference between qemu cache settings and ceph.conf rbd cache
 settings?
Date: Tue, 19 Jun 2012 08:44:52 +0200
Message-ID: <4FE01FE4.6070200@profihost.ag>
References: <4FE01E35.1080002@profihost.ag> <4FE01F6E.50200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37967 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab2FSGo4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 02:44:56 -0400
In-Reply-To: <4FE01F6E.50200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 19.06.2012 08:42, schrieb Josh Durgin:
> In qemu, the cache settings map to:
>
> writeback:
> rbd_cache = true
>
> writethrough:
> rbd_cache = true
> rbd_cache_max_dirty = 0
>
> none:
> rbd_cache = false
>
> qemu's settings are overridden by any custom settings you have in a
> config file or on the qemu command line.

Thanks!

Stefan
