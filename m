From: Sage Weil <sage@newdream.net>
Subject: Re: How to release Hammer osd RAM when compiled with jemalloc
Date: Tue, 13 Dec 2016 12:40:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612131238260.32565@piezo.novalocal>
References: <CAAL-TMcjJi7dQrOHiBUwQCgJ5R2cWDeLBB3XzKAogvaAR7yUxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56707 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbcLMMkT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 07:40:19 -0500
In-Reply-To: <CAAL-TMcjJi7dQrOHiBUwQCgJ5R2cWDeLBB3XzKAogvaAR7yUxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Wu <archer.wudong@gmail.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Tue, 13 Dec 2016, Dong Wu wrote:
> Hi, all
>    I have a cluster with nearly 1000 osds, and each osd already
> occupied 2.5G physical memory on average, which cause each host 90%
> memory useage. when use tcmalloc, we can use "ceph tell osd.* release"
> to release unused memory, but in my cluster, ceph is build with
> jemalloc, so can't use "ceph tell osd.* release", is there any methods
> to release some memory?

We explicitly call into tcmalloc to release memory with that command, but 
unless you've patched something in yourself there is no integration with 
jemalloc's release API.

> another question:
> can I decrease the following config value which used for cached osdmap
>  to lower osd's memory?
> 
> "mon_min_osdmap_epochs": "500"
> "osd_map_max_advance": "200",
> "osd_map_cache_size": "500",
> "osd_map_message_max": "100",
> "osd_map_share_max_epochs": "100"

Yeah.  You should be fine with 500, 50, 100, 50, 50.

sage
