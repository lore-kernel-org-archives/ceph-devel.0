From: Gregory Farnum <greg@inktank.com>
Subject: Re: cephfs show_location produces kernel "divide error: 0000 [#1]"
 when run against a directory that is not the filesystem root
Date: Thu, 5 Jul 2012 13:04:02 -0700
Message-ID: <CAPYLRzgWiLDEv8=26hHrixe_dMmAbmHHt3XKBftA7wjjmXp_xQ@mail.gmail.com>
References: <CAPUexz9+L+nrJCNh0gK0RGd8H5kk8ZGHZ+7WU4mP3mq5UHXLDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46828 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2GEUEE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:04:04 -0400
Received: by bkwj10 with SMTP id j10so3835157bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:04:03 -0700 (PDT)
In-Reply-To: <CAPUexz9+L+nrJCNh0gK0RGd8H5kk8ZGHZ+7WU4mP3mq5UHXLDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 10:40 AM, Florian Haas <florian@hastexo.com> wro=
te:
> And one more issue report for today... :)
>
> Really easy to reproduce on my 3.2.0 Debian squeeze-backports kernel:
> mount a Ceph FS, create a directory in it. Then run "cephfs <dir>
> show_location".
>
> dmesg stacktrace:
>
> [ 7153.714260] libceph: mon2 192.168.42.116:6789 session established
> [ 7308.584193] divide error: 0000 [#1] SMP
> [ 7308.584936] Modules linked in: cryptd aes_i586 aes_generic cbc cep=
h
> libceph nfsd lockd nfs_acl auth_rpcgss sunrpc fuse joydev usbhid hid
> snd_pcm snd_timer snd processor soundcore snd_page_alloc thermal_sys
> button tpm_tis tpm tpm_bios psmouse i2c_piix4 evdev serio_raw i2c_cor=
e
> virtio_balloon pcspkr ext3 jbd mbcache btrfs zlib_deflate crc32c
> libcrc32c sg sr_mod cdrom ata_generic virtio_net virtio_blk ata_piix
> uhci_hcd ehci_hcd libata usbcore floppy scsi_mod virtio_pci usb_commo=
n
> [last unloaded: scsi_wait_scan]
> [ 7308.588013]
> [ 7308.588013] Pid: 1444, comm: cephfs Not tainted
> 3.2.0-0.bpo.2-686-pae #1 Bochs Bochs
> [ 7308.588013] EIP: 0060:[<f848c6c2>] EFLAGS: 00010246 CPU: 0
> [ 7308.588013] EIP is at ceph_calc_file_object_mapping+0x44/0xe8 [lib=
ceph]
> [ 7308.588013] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 0000000=
0
> [ 7308.588013] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: f7495ce=
4
> [ 7308.588013] =A0DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [ 7308.588013] Process cephfs (pid: 1444, ti=3Df7494000 task=3Df7266a=
60
> task.ti=3Df7494000)
> [ 7308.588013] Stack:
> [ 7308.588013] =A000000000 00000000 00000000 0001b053 f5f20624 f5f203=
f0
> f749a800 f5f20420
> [ 7308.588013] =A0f84ca6a7 f7495d40 f7495d58 f7495d50 f7495d38 000000=
01
> 00000246 f5f20420
> [ 7308.588013] =A0f749a90c bff6ff70 c14203a4 fffba978 000a0050 000000=
00
> f79f0298 00000001
> [ 7308.588013] Call Trace:
> [ 7308.588013] =A0[<f84ca6a7>] ? ceph_ioctl_get_dataloc+0x9e/0x213 [c=
eph]
> [ 7308.588013] =A0[<c10b6781>] ? __do_fault+0x3ee/0x42b
> [ 7308.588013] =A0[<c10b75f3>] ? handle_pte_fault+0x3aa/0xa67
> [ 7308.588013] =A0[<c10e0844>] ? path_openat+0x27f/0x294
> [ 7308.588013] =A0[<f84cac16>] ? ceph_ioctl+0x3fa/0x460 [ceph]
> [ 7308.588013] =A0[<c10d9fdb>] ? cp_new_stat64+0xee/0x100
> [ 7308.588013] =A0[<c10b7ebe>] ? handle_mm_fault+0x20e/0x224
> [ 7308.588013] =A0[<f84ca81c>] ? ceph_ioctl_get_dataloc+0x213/0x213 [=
ceph]
>
> I unfortunately don't have a more recent kernel to test with, so if
> this has been fixed upstream feel free to ignore me. Otherwise,
> perhaps something that could go into the 3.5-rc cycle.
>
> Doing show_location on a file, and on the root directory of the fs,
> both work fine.

And again, create a bug for when we get back to the filesystem. ;)

But I have a few more queries while this is fresh. If you create a
directory, unmount and remount, and get the location, does that work?
(actually, just flushing caches would probably do it.) If you create a
directory on one node, and then go look at it on another node and try
to get the location from there, does that work?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
