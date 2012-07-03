From: Sage Weil <sage@inktank.com>
Subject: Re: Upgrade from 0.47.2 to 0.48 - osd crashes
Date: Tue, 3 Jul 2012 08:32:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207030831250.27608@cobra.newdream.net>
References: <CAMmJxtKb7zxf_eqyWhYWH7hq+qxnvAX5x7E8i7WeppppuYVTXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56319 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2GCPcp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:32:45 -0400
In-Reply-To: <CAMmJxtKb7zxf_eqyWhYWH7hq+qxnvAX5x7E8i7WeppppuYVTXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Tue, 3 Jul 2012, John Axel Eriksson wrote:
> So I first upgraded the mon, then went ahead and upgraded one of the
> osds which crashed and keeps crashing - probably when trying to
> upgrade the filestore.
> How should I proceed? FS is btrfs, one mon two osds. This is the conf
> for the osds:
>
> [...]
> 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> 2012-07-03 07:55:11.037077 7f2d0bbea700  1 heartbeat_map is_healthy
> 'FileStore::op_tp thread 0x7f2d083e3700' had suicide timed out after
> 180
> 2012-07-03 07:55:11.038755 7f2d0bbea700 -1 common/HeartbeatMap.cc: In
> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
> const char*, time_t)' thread 7f2d0bbea700 time 2012-07-03
> 07:55:11.037140
> common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")

This just means the fs wasn't getting work done quickly.  Either a kernel 
bug, or extreme fragmentation, or something along those lines.  Glad to 
hear that a reboot sorted it out!

sage
