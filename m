From: Gregory Farnum <greg@inktank.com>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 22:15:35 -0700
Message-ID: <0AD816275C544C9EAB3A6804BBC34817@inktank.com>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
 <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
 <loom.20120522T135204-38@post.gmane.org>
 <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com>
 <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11>
 <9AF25259E69149DE97352565797966E1@inktank.com>
 <loom.20120522T232520-187@post.gmane.org>
 <6DEB34DCFE6447C1BEE4A3E374801FAC@inktank.com>
 <loom.20120522T234403-146@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55961 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab2EWFPY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 01:15:24 -0400
Received: by dady13 with SMTP id y13so9217378dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 22:15:23 -0700 (PDT)
In-Reply-To: <loom.20120522T234403-146@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Grant Ashman <grant.ashman@mach.com.au>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 2:51 PM, Grant Ashman wrote:
> Awesome, that seemed to work!
> However, I feel a bit silly - what I'm after is:
> 
> /mnt/ceph-data - mounted to pool 0 (data)
> /mnt/ceph-backup - mounted to pool 3 (backup)
> 
> but this seemed to change both to mount to pool 3?
> 
> Am I simply doing something wrong at my mount stage?
> 
> The process to mount my specific pool as I understand it is;
> 
> 1. mount -t ceph 1.2.3.4:/ /mnt/ceph-backup
> 2. ceph mds add_data_pool 3
> 3. cephfs /mnt/ceph-backup/ -p 3 
> 
> Which should give me /ceph-backup mounted to the backup pool.
> 
> Should I simply then do a 
> mount -t ceph 1.2.3.4:/ /mnt/ceph-data/
> to get the /ceph-data/ pool mounted to the pool 0 data pool?

Right now, you can't actually get fully-distinct filesystem trees in a single Ceph cluster. That will probably come at some point in the future, and will require different MDS daemons and separate data & metadata pools for each filesystem.

What you *can* do right now is:
1) Set the pool a subtree writes all its new data to, and
2) mount subtrees of the filesystem, and
3) give specific clients read/write access to only a subset of the pools used by the filesystem hierarchy.

This means that you could have your root directory contain a "live" and a "backup" directory:
mount -t ceph 1.2.3.4:/ /mnt/ceph
mkdir /mnt/ceph/live; mkdir /mnt/ceph/backup

Leave the "live" directory using pool 0 while setting the "backup" directory to use pool 3:
cephfs /mnt/ceph/backup -p 3; umount /mnt/ceph

And then run one of
mount -t ceph 1.2.3.4:/live /mnt/ceph
or
mount -t ceph 1.2.3.4:/backup /mnt/ceph-backup

On your live and backup servers, respectively. (Or mount both and copy files to backup, or whatever.) Your live servers won't see the backup space, and the backup space won't see the live space, and they will live in different pools that you can place on different OSDs. (Although the metadata can't be segregated right now; you'll want a different strategy for that.)

Make sense?
-Greg

