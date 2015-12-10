From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Client io blocked when removing snapshot
Date: Thu, 10 Dec 2015 06:14:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512100613120.19170@cobra.newdream.net>
References: <47D132BF400BE64BAE6D71033F7D3D7503DE0DF4@H3CMLB12-EX.srv.huawei-3com.com> <34168A89-37E0-4FCE-96EC-EBA0EC6CA904@schermer.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45037 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbbLJOOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Dec 2015 09:14:25 -0500
In-Reply-To: <34168A89-37E0-4FCE-96EC-EBA0EC6CA904@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: Wukongming <wu.kongming@h3c.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "&RD-STOR-FIRE@h3c.com" <&RD-STOR-FIRE@h3c.com>

On Thu, 10 Dec 2015, Jan Schermer wrote:
> Removing snapshot means looking for every *potential* object the snapshot can have, and this takes a very long time (6TB snapshot will consist of 1.5M objects (in one replica) assuming the default 4MB object size). The same applies to large thin volumes (don't try creating and then dropping a 1 EiB volume, even if you only have 1GB of physical space :)).
> Doing this is simply expensive and might saturate your OSDs. If you don't have enough RAM to cache the structure then all the "is there a file /var/lib/ceph/...." will go to disk and that can hurt a lot.
> I don't think there's any priority to this (is there?), so it competes with everything else.
> 
> I'm not sure how snapshots are exactly coded in Ceph, but in a COW filesystem you simply don't dereference blocks of the parent of the  snapshot when doing writes to it and that's cheap, but Ceph stores "blocks" in files with computable names and has no pointers to them that could be modified,  so by creating a snapshot you hurt the performance a lot (you need to create a copy of the 4MB object into the snapshot(s) when you dirty a byte in there). Though I remember reading that the logic is actually reversed and it is the snapshot that gets the original blocks(??)...
> Anyway if you are removing snapshot at the same time as writing to the parent there could be potentionaly a problem in what gets done first. Is Ceph smart enough to not care about snapshots that are getting deleted? I have no idea but I think it must be because we use snapshots a lot and haven't had that any issues with it.

It's not quite so bad... the OSD maintains a map (in leveldb) of the 
objects that are referenced by a snapshot, so the amount of work is 
proportional to the number of objects that were cloned for that snapshot.

There is certainly room for improvement in terms of the impact on client 
IO, though.  :)

sage
