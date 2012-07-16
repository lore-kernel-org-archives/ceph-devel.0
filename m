From: Tommi Virtanen <tv@inktank.com>
Subject: Re: can "rbd unmap" detect if device is mounted?
Date: Mon, 16 Jul 2012 16:37:02 -0700
Message-ID: <CADvuQREm_PCatUUdgUjsUNMNBNEtB9_z9LTvo9D0Gyq7dR8XeQ@mail.gmail.com>
References: <CACkq2mqt5ae4U_-yhNM94GYQnE_negqXqHTf3JaSZ0zsxya9Yw@mail.gmail.com>
 <500498FC.9070806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64383 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2GPXhW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 19:37:22 -0400
Received: by pbbrp8 with SMTP id rp8so10787486pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 16:37:22 -0700 (PDT)
In-Reply-To: <500498FC.9070806@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Jul 16, 2012 at 3:43 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> I've made this mistake a couple of times now (completely my fault,
>> when will I learn?), and am wondering if a bit of protection can be
>> put in place against user errors.
> Yeah, we've been working on advisory locking. The first step is
> just adding an option to lock via the rbd command line tool, so you
> could script lock/map and unmap/unlock.

Is his problem really about the locking?

It sounded to me like, he has something (the mount) referencing a
block device, and we're letting the block device disappear.

The locking you guys have been talking about sounds like that lock
would be held whenever the image is mapped, regardless of whether it's
mounted or not (think mkfs).


Should unmap even be possible while the block device is open?
Shouldn't there be a refcount and an -EBUSY? That's what other block
device providers do:

[0 tv@dreamer ~]$ dd if=/dev/zero of=foo bs=1M count=40
40+0 records in
40+0 records out
41943040 bytes (42 MB) copied, 0.167171 s, 251 MB/s
[1 tv@dreamer ~]$ sudo losetup --show -f foo
/dev/loop0
[0 tv@dreamer ~]$ sudo mkfs /dev/loop0
mke2fs 1.42 (29-Nov-2011)
Discarding device blocks: done
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
Stride=0 blocks, Stripe width=0 blocks
10240 inodes, 40960 blocks
2048 blocks (5.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=41943040
5 block groups
8192 blocks per group, 8192 fragments per group
2048 inodes per group
Superblock backups stored on blocks:
	8193, 24577

Allocating group tables: done
Writing inode tables: done
Writing superblocks and filesystem accounting information: done

[0 tv@dreamer ~]$ sudo mount /dev/loop0 /mnt
[0 tv@dreamer ~]$ sudo losetup -d /dev/loop0
loop: can't delete device /dev/loop0: Device or resource busy
[1 tv@dreamer ~]$ sudo umount /mnt
[0 tv@dreamer ~]$ sudo losetup -d /dev/loop0
[0 tv@dreamer ~]$
