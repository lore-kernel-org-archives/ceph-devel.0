From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: RBD performance poor
Date: Tue, 19 Jul 2011 09:11:39 -0700
Message-ID: <CAF3hT9DcGSA8=vbGj3ibpwDRP2hZvEOgq9ru7PPcrYuUWRMHbA@mail.gmail.com>
References: <loom.20110719T132334-607@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52486 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1GSQLl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 12:11:41 -0400
Received: by gwaa18 with SMTP id a18so55923gwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 09:11:41 -0700 (PDT)
In-Reply-To: <loom.20110719T132334-607@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Gramsch <christian.gramsch@gmail.com>
Cc: ceph-devel@vger.kernel.org

RBD presently does absolutely no client-side caching of writes. If a
write is issued, it goes out to the network and doesn't return from
the write until it's been committed on-disk to the OSDs.
This is the simplest and safest implementation, but it's not quite
what many things expect from their disk devices: they think a write
should be fast (and land in the disk's cache) and expect that a sync
might be slow. If you run an actual OS on RBD you should find it
performing reasonably well since the VFS and page cache will hide all
this latency from you, but if you're accessing it directly your
application is likely to issue a bunch of serialized 4KB writes with a
per-write latency of ~10 milliseconds, which obviously severely limits
total write bandwidth.
Implementing client-side caching is in the future for RBD but not
something we're working on right now.

So most (all, I think) reports of slow RBD behavior have been because
of this (certainly the one you reference). But with the commands
you're running, you're doing dd in file mode rather than raw disk, so
the VFS ought to be coalescing those writes and giving you much higher
bandwidth. Are you using any special mount options? What result do you
get doing a dd directly to the device?
-Greg

On Tue, Jul 19, 2011 at 7:48 AM, Christian Gramsch
<christian.gramsch@gmail.com> wrote:
> Hello,
>
> I'm currently testing Ceph/RBD for usage as a storage-backend for
> virtual-machine-volumes.
>
> So I've setup a basic cluster of 9 machines (1 mon, 2 mds, 6 osds) ba=
sed on the
> example configuration found in wiki. Ceph is accessed from dedicated =
hosts for
> virtualization. There is a physical Gigabit-LAN dedicated for Ceph. A=
ll osds
> have a dedicated hard-disk with one btrfs-volume mounted noatime. The
> osd-journal is stored inside this btrfs-volume as suggested in exampl=
e
> configuration.
>
> When I mount the ceph-volume from the virtualization hosts, I was abl=
e to read
> and write files very fast. But on rbd-volumes, the same performance i=
s not
> reached by far.
>
> I tried it with an image mapped as device /dev/rbd0 and formatted as =
ext4 and
> did performance-testing locally, I also installed an operating-system=
 on the
> image directly using qemu-rbd - both experiments give me a rather poo=
r
> performance with never more than 3 MB/s.
>
> I get these different results on exactly the same machine:
>
> root@kvm2:~# mount -t ceph 172.23.42.1:/ /ceph
> root@kvm2:~# cd /ceph
> root@kvm2:/ceph# dd if=3D/dev/zero of=3Dtestfile bs=3D4096 count=3D10=
000 conv=3Dfdatasync
> [...]
> 40960000 Bytes (41 MB) kopiert, 1,77141 s, 23,1 MB/s
> root@kvm2:/ceph# dd if=3D/dev/zero of=3Dtestfile bs=3D4096 count=3D10=
000 conv=3Dfdatasync
> [...]
> 40960000 Bytes (41 MB) kopiert, 1,55054 s, 26,4 MB/s
> root@kvm2:/ceph# dd if=3D/dev/zero of=3Dtestfile bs=3D4096 count=3D10=
000 conv=3Dfdatasync
> [...]
> 40960000 Bytes (41 MB) kopiert, 1,51826 s, 27,0 MB/s
> root@kvm2:/ceph# cd
> root@kvm2:~# umount /ceph
> root@kvm2:~# rbd map disk0
> root@kvm2:~# mount /dev/rbd0 /ceph
> root@kvm2:~# cd /ceph
> root@kvm2:/ceph# dd if=3D/dev/zero of=3Dtestfile bs=3D4096 count=3D10=
000 conv=3Dfdatasync
> [...]
> 40960000 Bytes (41 MB) kopiert, 6,85968 s, 6,0 MB/s
> [...]
> 40960000 Bytes (41 MB) kopiert, 7,38783 s, 5,5 MB/s
>
> You see, the performance writing onto the rbd-device is worse, perfor=
mance
> inside virtual machines using qemu-rbd even worser (3-4 MB/s).
>
> Is there anything I could do to improve performance regarding rbd?
> Anything what could be terribly wrong in my setup?
>
> I found a similar problem mentioned on this mailing-list about a year=
 ago[1],
> but it seems that it fizzled out and a concrete problem has not been
> acknowledged, but I think there is one.
>
> Regards
> Christian Gramsch
>
>
> [1] http://www.spinics.net/lists/ceph-devel/msg00660.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
