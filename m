From: Sage Weil <sage@newdream.net>
Subject: Re: How to improve erasure pool's delete performance
Date: Sun, 3 Apr 2016 09:07:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604030906170.19675@cpach.fuggernut.com>
References: <CABAwU-a1kxbc=i564da=GAj11_5M-tKE6R2kP5vaX7Ga2F3g=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1489728488-1459688853=:19675"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbcDCNHj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 09:07:39 -0400
In-Reply-To: <CABAwU-a1kxbc=i564da=GAj11_5M-tKE6R2kP5vaX7Ga2F3g=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1489728488-1459688853=:19675
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 3 Apr 2016, huang jun wrote:
> Hi, all
> Recently, we test deletion performance of erasure pool, and we found
> the delete op
> is pretty slow.
> We trace the code and found Delete op was converted to Rename in Filestore,
> It was implemented in function FileStore::_collection_move_rename(),
> it calls FileStore::_set_replay_guard function and
> FileStore::_close_replay_guard function,
> in these 2 function, do 3 fsyncs and 1 objectmap sync, which we think
> spend the most time.
> ===================================
> Envirnoment:
> ceph version: 0.94.5
> linux kernel: 3.18
> Test cluster: 1MON, 1MDS, 4OSD
> ===================================
> We do some comparison tests:
> 1. sync omap + fd（default)
> avg rename op used 0.883818s
> 2. only sync omap: 0.428431s
> 3. only sync fd: 0.400266s
> 4. dont sync: 0.00319648
> 5. do posix_fadvise(FADVISE_DONTNEED) after write, and sync omap + fd: 0.855178s
> 6. use fdatasync to replace fsync, and sync omap + fd : 0.432659s
> 
> As we can see, sync fd and sync objectmap use 50% of the total time each.
> Compare 1 with 6, fdatasync uses 50% less time compared to fdatasync,
> which means sync metadata spent more time than sync data.
> In FileStore::_set_replay_guard function and
> FileStore::_close_replay_guard function,
> it only set object's user.cephos.seq xattr, then do sync to let it durable.
> 
> I have some questions:
> 1. Do we record the xattr(user.cephos.seq) to avoid replaying an older
> transaction?

Yes, exactly.

> 2. If dont do sync, we will get the best performance, is there any
> side effects? like: get data corrupted.

Yes--we may replay incorrectly after a failure.  Unfortunately, not an 
option.

This problem goes away with BlueStore, so we only have to live with it 
for a bit longer.  I don't think it's worth investing any effort into 
addressing this with FileStore--we'll be unlikely to want to merge any 
non-trivial change anyway.

sage
--8323329-1489728488-1459688853=:19675--
