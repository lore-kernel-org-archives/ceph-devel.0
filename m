From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: unable to handle kernel NULL pointer dereference (snaptest-2)
Date: Fri, 25 Jun 2010 10:55:56 -0700
Message-ID: <AANLkTinc9N2p0n-oc4MkGxAw6CJ332FhSdexLDlxoZj5@mail.gmail.com>
References: <i01jbi$tr9$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33533 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0FYRz6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jun 2010 13:55:58 -0400
Received: by gxk28 with SMTP id 28so1421654gxk.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jun 2010 10:55:57 -0700 (PDT)
In-Reply-To: <i01jbi$tr9$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Whoops, I was fixing some issues with how we handle ESTALE yesterday
and managed to introduce those; looks like the standalone repository
got updated in the few hours they went unfixed. The upstream unstable
is already working and Sage is going to pull them into the standalone
repository now so they should be fixed later today if you update. :)
-Greg

On Thu, Jun 24, 2010 at 11:46 PM, Thomas Mueller <thomas@chaschperli.ch=
> wrote:
> hi
>
> since today the snaptest-2
> (http://github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-=
2)
> is crashing (reproducible) my machine. yesterday it was ok.
>
>
> ceph/unstable
> Bad ref: bef062942ad1745808287c7483478adaa0b91fc2
> Last known good: 5634ce8d056f02b6c7c2fb23ff310e529df15511
>
> ceph-client-standalone/unstable-backport
> bad ref: 0048d167d5de04d5a88dbcb064cf2d80270ab281
> updated today, but don't know what last ref was.
>
>
> kernel: 2.6.34
>
>
> kernel: [ 2391.674928] BUG: unable to handle kernel NULL pointer dere=
ference at 000000000000005c
> kernel: [ 2391.674940] IP: [<ffffffffa07b3073>] __prepare_send_reques=
t+0x37/0x429 [ceph]
> kernel: [ 2391.674966] PGD 52b91067 PUD 63f3b067 PMD 0
> kernel: [ 2391.674975] Oops: 0000 [#1] SMP
> kernel: [ 2391.674981] last sysfs file: /sys/devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0C0A:00/power_supply/BAT0/voltage_now
> kernel: [ 2391.674988] CPU 1
> kernel: [ 2391.674991] Modules linked in: ceph aes_x86_64 aes_generic=
 nls_utf8 udf ppdev lp sco bridge stp bnep acpi_cpufreq cpufreq_userspa=
ce rfcomm cpufreq_conservative cpufreq_powersave l2cap crc16 cpufreq_st=
ats binfmt_misc kvm_intel kvm uinput fuse ext3 jbd mbcache loop snd_hda=
_codec_atihdmi snd_hda_codec_analog snd_hda_intel arc4 snd_hda_codec sn=
d_hwdep ecb snd_pcm_oss snd_mixer_oss ide_cs snd_pcm ide_core snd_seq_m=
idi uvcvideo snd_rawmidi snd_seq_midi_event iwlagn joydev snd_seq tpm_i=
nfineon iwlcore psmouse hp_accel videodev lis3lv02d v4l1_compat v4l2_co=
mpat_ioctl32 snd_timer tpm_tis snd_seq_device tpm snd tpm_bios soundcor=
e serio_raw btusb pcmcia hp_wmi video output parport_pc parport i2c_cor=
e yenta_socket rsrc_nonstatic pcmcia_core snd_page_alloc wmi mac80211 c=
fg80211 qcserial input_polldev pcspkr evdev container processor usbseri=
al bluetooth ac battery button rfkill fglrx(P) xfs exportfs ses enclosu=
re dm_mod btrfs zlib_deflate crc32c libcrc32c sg sr_mod cdrom sd_mod cr=
c_t10dif usb
> kernel: _storage uhci_hcd ata_generic fan sdhci_pci sdhci ahci mmc_co=
re firewire_ohci firewire_core led_class crc_itu_t libata ehci_hcd e100=
0e scsi_mod thermal thermal_sys usbcore nls_base [last unloaded: scsi_w=
ait_scan]
> kernel: [ 2391.675191]
> kernel: [ 2391.675199] Pid: 22164, comm: ls Tainted: P =A0 =A0 =A0 =A0=
 =A0 2.6.34-1-amd64 #1 30E7/HP EliteBook 8530p
> kernel: [ 2391.675205] RIP: 0010:[<ffffffffa07b3073>] =A0[<ffffffffa0=
7b3073>] __prepare_send_request+0x37/0x429 [ceph]
> kernel: [ 2391.675227] RSP: 0018:ffff8800b7f2dcf8 =A0EFLAGS: 00010206
> kernel: [ 2391.675233] RAX: 0000000000000000 RBX: ffff880063f26800 RC=
X: ffff88013016fd60
> kernel: [ 2391.675239] RDX: 0000000000000001 RSI: 0000000000000000 RD=
I: ffff880005e608dc
> kernel: [ 2391.675245] RBP: ffff880139b171a0 R08: 0000000a63f26800 R0=
9: 0000000900000009
> kernel: [ 2391.675251] R10: 00000000f8fa2e37 R11: 000000009d2ef4e0 R1=
2: ffff88013016f800
> kernel: [ 2391.675256] R13: ffff880005e60540 R14: ffff880139b171a0 R1=
5: 0000000000000000
> kernel: [ 2391.675264] FS: =A000007f32628617a0(0000) GS:ffff880001a80=
000(0000) knlGS:0000000000000000
> kernel: [ 2391.675270] CS: =A00010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> kernel: [ 2391.675276] CR2: 000000000000005c CR3: 0000000063ffe000 CR=
4: 00000000000406e0
> kernel: [ 2391.675282] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000
> kernel: [ 2391.675288] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR=
7: 0000000000000400
> kernel: [ 2391.675294] Process ls (pid: 22164, threadinfo ffff8800b7f=
2c000, task ffff88011b01b800)
> kernel: [ 2391.675299] Stack:
> kernel: [ 2391.675303] =A0ffff880000000000 ffffffff810f1487 000000000=
0000000 ffff880005e70000
> kernel: [ 2391.675311] <0> 0000000413688655 00000000a26aed63 ffff8801=
1ef29000 ffff8800bc807840
> kernel: [ 2391.675321] <0> 0000000000000001 ffff880005e60830 ffff8800=
05e60540 0000000000000000
> kernel: [ 2391.675331] Call Trace:
> kernel: [ 2391.675343] =A0[<ffffffff810f1487>] ? link_path_walk+0x47d=
/0x482
> kernel: [ 2391.675363] =A0[<ffffffffa07b3795>] ? __do_request+0x330/0=
x391 [ceph]
> kernel: [ 2391.675381] =A0[<ffffffffa07aae5a>] ? ceph_reserve_caps+0x=
e0/0x176 [ceph]
> kernel: [ 2391.675400] =A0[<ffffffffa07b3967>] ? ceph_mdsc_do_request=
+0x8f/0x15c [ceph]
> kernel: [ 2391.675414] =A0[<ffffffffa07a0728>] ? ceph_do_getattr+0xa6=
/0xcd [ceph]
> kernel: [ 2391.675428] =A0[<ffffffffa07a0769>] ? ceph_getattr+0x1a/0x=
80 [ceph]
> kernel: [ 2391.675437] =A0[<ffffffff810eacdb>] ? vfs_fstatat+0x44/0x5=
b
> kernel: [ 2391.675445] =A0[<ffffffff810ead8f>] ? sys_newstat+0x11/0x2=
d
> kernel: [ 2391.675456] =A0[<ffffffff8102cd45>] ? do_page_fault+0x21a/=
0x25d
> kernel: [ 2391.675466] =A0[<ffffffff812f9af5>] ? page_fault+0x25/0x30
> kernel: [ 2391.675475] =A0[<ffffffff810089c2>] ? system_call_fastpath=
+0x16/0x1b
> kernel: [ 2391.675479] Code: 41 54 55 53 48 89 f3 48 83 ec 68 89 53 2=
c 48 8b 7e 30 ff 86 30 02 00 00 48 85 ff 74 17 48 81 ef f0 02 00 00 89 =
d6 e8 7e 50 ff ff <8b> 40 5c 89 83 3c 02 00 00 48 8b bb 20 01 00 00 48 =
85 ff 74 1e
> kernel: [ 2391.675549] RIP =A0[<ffffffffa07b3073>] __prepare_send_req=
uest+0x37/0x429 [ceph]
> kernel: [ 2391.675569] =A0RSP <ffff8800b7f2dcf8>
> kernel: [ 2391.675573] CR2: 000000000000005c
> kernel: [ 2391.675579] ---[ end trace 0eb3d3770bbbcd73 ]---
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
