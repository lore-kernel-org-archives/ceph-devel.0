From: Florian Haas <florian@hastexo.com>
Subject: cephfs show_location produces kernel "divide error: 0000 [#1]" when
 run against a directory that is not the filesystem root
Date: Thu, 5 Jul 2012 19:40:53 +0200
Message-ID: <CAPUexz9+L+nrJCNh0gK0RGd8H5kk8ZGHZ+7WU4mP3mq5UHXLDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42278 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab2GERky (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 13:40:54 -0400
Received: by qcro28 with SMTP id o28so5013651qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 10:40:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

And one more issue report for today... :)

Really easy to reproduce on my 3.2.0 Debian squeeze-backports kernel:
mount a Ceph FS, create a directory in it. Then run "cephfs <dir>
show_location".

dmesg stacktrace:

[ 7153.714260] libceph: mon2 192.168.42.116:6789 session established
[ 7308.584193] divide error: 0000 [#1] SMP
[ 7308.584936] Modules linked in: cryptd aes_i586 aes_generic cbc ceph
libceph nfsd lockd nfs_acl auth_rpcgss sunrpc fuse joydev usbhid hid
snd_pcm snd_timer snd processor soundcore snd_page_alloc thermal_sys
button tpm_tis tpm tpm_bios psmouse i2c_piix4 evdev serio_raw i2c_core
virtio_balloon pcspkr ext3 jbd mbcache btrfs zlib_deflate crc32c
libcrc32c sg sr_mod cdrom ata_generic virtio_net virtio_blk ata_piix
uhci_hcd ehci_hcd libata usbcore floppy scsi_mod virtio_pci usb_common
[last unloaded: scsi_wait_scan]
[ 7308.588013]
[ 7308.588013] Pid: 1444, comm: cephfs Not tainted
3.2.0-0.bpo.2-686-pae #1 Bochs Bochs
[ 7308.588013] EIP: 0060:[<f848c6c2>] EFLAGS: 00010246 CPU: 0
[ 7308.588013] EIP is at ceph_calc_file_object_mapping+0x44/0xe8 [libceph]
[ 7308.588013] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[ 7308.588013] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: f7495ce4
[ 7308.588013]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[ 7308.588013] Process cephfs (pid: 1444, ti=f7494000 task=f7266a60
task.ti=f7494000)
[ 7308.588013] Stack:
[ 7308.588013]  00000000 00000000 00000000 0001b053 f5f20624 f5f203f0
f749a800 f5f20420
[ 7308.588013]  f84ca6a7 f7495d40 f7495d58 f7495d50 f7495d38 00000001
00000246 f5f20420
[ 7308.588013]  f749a90c bff6ff70 c14203a4 fffba978 000a0050 00000000
f79f0298 00000001
[ 7308.588013] Call Trace:
[ 7308.588013]  [<f84ca6a7>] ? ceph_ioctl_get_dataloc+0x9e/0x213 [ceph]
[ 7308.588013]  [<c10b6781>] ? __do_fault+0x3ee/0x42b
[ 7308.588013]  [<c10b75f3>] ? handle_pte_fault+0x3aa/0xa67
[ 7308.588013]  [<c10e0844>] ? path_openat+0x27f/0x294
[ 7308.588013]  [<f84cac16>] ? ceph_ioctl+0x3fa/0x460 [ceph]
[ 7308.588013]  [<c10d9fdb>] ? cp_new_stat64+0xee/0x100
[ 7308.588013]  [<c10b7ebe>] ? handle_mm_fault+0x20e/0x224
[ 7308.588013]  [<f84ca81c>] ? ceph_ioctl_get_dataloc+0x213/0x213 [ceph]

I unfortunately don't have a more recent kernel to test with, so if
this has been fixed upstream feel free to ignore me. Otherwise,
perhaps something that could go into the 3.5-rc cycle.

Doing show_location on a file, and on the root directory of the fs,
both work fine.

Cheers,
Florian
