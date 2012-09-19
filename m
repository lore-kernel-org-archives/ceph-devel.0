From: Dustin Kirkland <dustin.kirkland@gazzang.com>
Subject: Re: on disk encryption
Date: Tue, 18 Sep 2012 20:53:31 -0500
Message-ID: <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51355 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2ISBxd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 21:53:33 -0400
Received: by lbbgj3 with SMTP id gj3so460801lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 18:53:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Sep 15, 2012 at 6:54 AM, Sage Weil <sage@inktank.com> wrote:
> Hey,
>
> A common requirement that's come up in conversation a few times now is
> on-disk, at-rest encryption.  Usually, this is really just about making
> sure the bits on an individual disk are useless in isolation, so that
> drives can be safely discarded or RMAed without compromising customer
> data.

Hi Sage,

Thanks for bringing this up on your devel list.  This is certainly
something that I experience on a daily basis around Linux storage
systems in general in the enterprise.

> I suspect the simplest way to accomplish this would be through something
> like dm-crypt.  The trick would be keeping the keys for the osd's block
> device and journal elsewhere.

Right, so using established technologies within the Linux kernel, I'd
think you should consider at least dm-crypt and eCryptfs, each of
which have their own costs and benefits.  (Full disclosure: I'm one of
the maintainers of eCryptfs).

dm-crypt is a block level encryption solution, whereas eCryptfs
handles its encryption on a per-file basis.

With dm-crypt, you must pre-allocate a disk, partition, or loopback
device, configure it using cryptsetup, LUKS, and optionally LVM,
format the partition with your filesystem of choice, and then perform
the mount of the device mapped encrypted block device to your mount
point.  The entire block device is encrypted using the same set of
keys, which cannot be easily changed or rotated.  I/O performance is
maximized if using AES-NI cryptographic acceleration on CPUs
supporting the instruction set.  Keys are loaded into LUKS and only
necessary at mount time.

eCryptfs is a layered filesystem, where one directory is mounted on
"top" of another.  The upper directory is just a virtual
representation of the files/directories, with reads and writes being
passed through the kernel and handling any decryption or encryption
before actually dealing with the real files which are written to disk
in the lower directory.  There's no need to "pre-allocate" space in a
partition, disk, or loop device, as you just use a directory in your
current filesystem, which can be any of the Linux filesystems.
Because the encryption happens on a per-file basis, you could actually
use unique or distinct keys for different files.  Some users or
processes on the local system may or may not have access to the
cryptographic keys necessary to mount, read, and write these files.
Also, incremental backups of the encrypted data is possible by using a
simple rsync or similar utility.  There is a little more overhead than
dmcrypt here, since each fread and fwrite has to perform its own
encryption, but honestly, the performance is usually quite tolerable
when encryption is essential to a given workload.  While eCryptfs does
not yet correctly leverage AES-NI, there is an patchset from Colin
King, pending approval by Tyler Hicks on the docket for the next merge
window.  (This does improve performance in some cases on modern
hardware, though there were some initial concerns about costing
performance on some older platforms that don't support AES-NI.)

> One option would be to use the monitor as a lock box to securely store the
> disk encryption key, secured by the osd's existing cephx key is provided.
> The startup scripts (triggered via upstart, sysvinit, whatever) would need
> to get the keyring off the disk (separate, unencrypted partition?), get
> the disk key from the monitor, set up the dm-crypt devices, mount the
> osd's fs, and then start ceph-osd.  An attacker in possession of a
> recovered disk would be need network connectivity to the cluster (prior to
> the keys getting revoked/destroyed) in order to decrypt it.

Yeah, so that's always the trick with a crypto solution...key
management.  You have to store the key somewhere other than on the
encrypted device to ensure the protection and integrity of the data.

Without turning this into an advertisement, my company has a
Linux-based (though proprietary) key server product in this space.
Fundamentally, you would need, as you say, a startup script with
network access to authenticate to a trusted, remote server, request
the necessary keys, have the server apply a flexible set of policies
to ensure that the key request is legitimate, and if so, return the
key material to the requesting server.  When a server is known to be
compromised, subsequent access to that key is revoked at the server,
thereby protecting access to the encrypted data.

There is an OASIS standard for such a protocol called KMIP, but it's
some 200+ pages long and there are no open implementations of KMIP
that I know of.

> Looking forward, another option might be to implement encryption inside
> btrfs (placeholder fields are there in the disk format, introduced along
> with the compression code way back when).  This would let ceph-osd handle
> more of the key handling internally and do something like, say, only
> encrypt the current/ and snap_*/ subdirectories.
>
> Other ideas?  Thoughts?
>
> sage

I love the idea of btrfs supporting encryption natively much like it
does compression.  It may be some time before that happens, so in the
meantime, I'd love to see Ceph support dm-crypt and/or eCryptfs
beneath.


Cheers,
-- 
Dustin Kirkland  |  Chief Technical Officer
Gazzang, Inc.
