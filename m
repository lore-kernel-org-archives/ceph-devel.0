From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: difference between qemu cache settings and ceph.conf rbd cache
 settings?
Date: Mon, 18 Jun 2012 23:42:54 -0700
Message-ID: <4FE01F6E.50200@inktank.com>
References: <4FE01E35.1080002@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37540 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab2FSGm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 02:42:56 -0400
Received: by obbtb18 with SMTP id tb18so9611931obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 23:42:56 -0700 (PDT)
In-Reply-To: <4FE01E35.1080002@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/18/2012 11:37 PM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i've now patched my qemu to include the qemu cache settings for rbd.
>
> Now i can change my drive caching mode. But there are also these
> settings for global section in ceph.conf.
>
> rbd_cache = true
> rbd_cache_size = 33554432
> rbd_cache_max_age = 2.0
>
> How do they influence or replace each other?
>
> thanks
> Stefan

In qemu, the cache settings map to:

writeback:
   rbd_cache = true

writethrough:
   rbd_cache = true
   rbd_cache_max_dirty = 0

none:
   rbd_cache = false

qemu's settings are overridden by any custom settings you have in a
config file or on the qemu command line.

Josh
