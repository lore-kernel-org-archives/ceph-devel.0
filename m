From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: [PATCH ceph-client-standalone :master-backport ] miss Makefile
Date: Tue, 14 Dec 2010 11:40:28 +0800
Message-ID: <1292298028.2484.1.camel@cephhost>
References: <1291799367.1958.33.camel@cephhost>
	 <1292295716.1807.18.camel@cephhost>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:21446 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754399Ab0LNDiq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Dec 2010 22:38:46 -0500
In-Reply-To: <1292295716.1807.18.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, yehuda <yehuda@hq.newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>


ceph-client-standalone.git
1.master-backport ,  reproduce this issue
2.unstable-backport, can't reproduce it.



=E5=9C=A8 2010-12-14=E4=BA=8C=E7=9A=84 11:01 +0800=EF=BC=8CJeff Wu=E5=86=
=99=E9=81=93=EF=BC=9A
> Oh ,Sorry,
>=20
> To build ceph.ko
> need  "cp libceph/Module.symvers ceph/ "
>=20
> but ,i detected a OOPS ,ceph-client-standalone.git + ceph 0.23
>=20
> reproduce steps:
>=20
>=20
> /ceph-client-standalone$ make -C libceph/
> /ceph-client-standalone$ cp libceph/Module.symvers ./ceph/
> /ceph-client-standalone$ make -C ceph/
> /ceph-client-standalone$ sudo insmod libceph/libceph.ko
> /ceph-client-standalone$ sudo insmod ceph/ceph.ko
> /ceph-client-standalone$ sudo mount.ceph 172.16.10.171:6789:/ /mnt/ce=
ph
> killed
>=20
> [   30.410007] eth0: no IPv6 routers present
> [ 1686.701010] ceph: loaded (mds proto 32)
> [ 1699.955896] BUG: unable to handle kernel NULL pointer dereference =
at
> 0000000000000020
> [ 1699.955901] IP: [<ffffffff8107aee0>] queue_work_on+0x20/0x60
> [ 1699.955909] PGD 7870a067 PUD 6a179067 PMD 0
> [ 1699.955913] Oops: 0000 [#1] SMP
> [ 1699.955915] last sysfs file: /sys/devices/pci0000:00/0000:00:19.0/=
irq
> [ 1699.955918] CPU 3
> [ 1699.955919] Modules linked in: ceph libceph crc32c libcrc32c
> binfmt_misc kvm_intel kvm snd_hda_codec_analog snd_hda_intel
> snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_rawmidi
> snd_seq_midi_event i915 snd_seq snd_timer snd_seq_device drm_kms_help=
er
> drm ppdev snd parport_pc psmouse soundcore snd_page_alloc serio_raw
> dcdbas dell_wmi intel_agp i2c_algo_bit video output lp parport usbhid
> hid ahci e1000e libahci [last unloaded: libceph]
> [ 1699.955946]
> [ 1699.955948] Pid: 6571, comm: mount.ceph Not tainted 2.6.35-22-gene=
ric
> #35-Ubuntu 0V4W66/OptiPlex 780
> [ 1699.955951] RIP: 0010:[<ffffffff8107aee0>]  [<ffffffff8107aee0>]
> queue_work_on+0x20/0x60
> [ 1699.955954] RSP: 0018:ffff880067321c68  EFLAGS: 00010246
> [ 1699.955956] RAX: ffff880064bc4c00 RBX: ffff880064bc4800 RCX:
> 0000000000000000
> [ 1699.955958] RDX: ffff880064bc4bf8 RSI: 0000000000000000 RDI:
> 0000000000000003
> [ 1699.955960] RBP: ffff880067321c68 R08: 0000000000000002 R09:
> 0000000028aec089
> [ 1699.955962] R10: 0000000000000000 R11: ffff880067321b88 R12:
> ffff88006372d090
> [ 1699.955964] R13: 0000000000000800 R14: 0000000000000064 R15:
> ffff88006431f600
> [ 1699.955966] FS:  00007f5d9ca5d700(0000) GS:ffff880001ec0000(0000)
> knlGS:0000000000000000
> [ 1699.955968] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 1699.955970] CR2: 0000000000000020 CR3: 0000000063d92000 CR4:
> 00000000000406e0
> [ 1699.955972] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1699.955974] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [ 1699.955976] Process mount.ceph (pid: 6571, threadinfo
> ffff880067320000, task ffff8800625a96e0)
> [ 1699.955977] Stack:
> [ 1699.955979]  ffff880067321c78 ffffffff8107af5f ffff880067321c98
> ffffffffa02b0179
> [ 1699.955982] <0> 0000000000000064 ffff88006372d080 ffff880067321ca8
> ffffffffa02b0668
> [ 1699.955985] <0> ffff880067321cd8 ffffffffa02b4450 ffff880067321cd8
> 78ffffff81587cae
> [ 1699.955989] Call Trace:
> [ 1699.955993]  [<ffffffff8107af5f>] queue_work+0x1f/0x30
> [ 1699.956001]  [<ffffffffa02b0179>] queue_con+0x49/0x60 [libceph]
> [ 1699.956005]  [<ffffffffa02b0668>] ceph_con_open+0x38/0x40 [libceph=
]
> [ 1699.956010]  [<ffffffffa02b4450>] __open_session+0xc0/0x100 [libce=
ph]
> [ 1699.956015]  [<ffffffffa02b4641>] ceph_monc_open_session+0x41/0x11=
0
> [libceph]
> [ 1699.956019]  [<ffffffffa02af2eb>] __ceph_open_session+0x4b/0x290
> [libceph]
> [ 1699.956023]  [<ffffffff81119e35>] ? bdi_register+0x105/0x1a0
> [ 1699.956027]  [<ffffffff81155988>] ? sget+0x1c8/0x230
> [ 1699.956032]  [<ffffffffa02ce3c0>] ? ceph_set_super+0x0/0x80 [ceph]
> [ 1699.956035]  [<ffffffffa02ceeee>] ceph_get_sb+0x1fe/0x460 [ceph]
> [ 1699.956038]  [<ffffffff8115550a>] vfs_kern_mount+0x8a/0x1f0
> [ 1699.956041]  [<ffffffff811556e2>] do_kern_mount+0x52/0x130
> [ 1699.956044]  [<ffffffff81589693>] ? _lock_kernel+0x53/0xa3
> [ 1699.956048]  [<ffffffff81170c8a>] do_mount+0x20a/0x260
> [ 1699.956051]  [<ffffffff8116e2e2>] ? copy_mount_options+0xf2/0x1a0
> [ 1699.956053]  [<ffffffff81170d70>] sys_mount+0x90/0xe0
> [ 1699.956057]  [<ffffffff8100a0f2>] system_call_fastpath+0x16/0x1b
> [ 1699.956059] Code: 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 0f =
1f
> 44 00 00 f0 0f ba 2a 00 19 c9 31 c0 85 c9 75 31 48 8d 42 08 48 3b 42 =
08
> 75 29 <44> 8b 46 20 45 85 c0 75 24 48 63 ff 48 8b 06 48 89 d6 48 03 0=
4
> [ 1699.956085] RIP  [<ffffffff8107aee0>] queue_work_on+0x20/0x60
> [ 1699.956088]  RSP <ffff880067321c68>
> [ 1699.956089] CR2: 0000000000000020
> [ 1699.956092] ---[ end trace ae08f7c02a59475a ]---
> /ceph-client-standalone$
>=20
>=20
>=20
> This issue had been updated to bug tracker.
>=20
> Jeff .C.P.Wu
>=20
>=20
>=20
> =E5=9C=A8 2010-12-08=E4=B8=89=E7=9A=84 17:09 +0800=EF=BC=8CJeff Wu=E5=
=86=99=E9=81=93=EF=BC=9A
> > Hi ,
> >
> > I download ceph-client-standalone master-backport:
> >
> > $git clone git://ceph.newdream.net/git/ceph-client-standalone.git
> > $git branch master-backport origin/master-backport
> > $git checkout master-backport
> >
> > But ,fail to compile ceph.ko (logs ,see below).
> > It might be miss a Makefile ,so i add it.
> >
> > Regards
> > Jeff C.P.Wu
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > diff --git a/ceph-client-standalone/Makefile
> > b/ceph-client-standalone/Makefile
> > new file mode 100644
> > index 0000000..1b26d4b
> > --- /dev/null
> > +++ b/ceph-client-standalone/Makefile
> > @@ -0,0 +1,47 @@
> > +#
> > +# Makefile for CEPH filesystem.
> > +#
> > +
> > +ifneq ($(KERNELRELEASE),)
> > +
> > +obj-$(CONFIG_CEPH_FS) +=3D ceph.o
> > +
> > +ceph-objs :=3D ceph/super.o ceph/inode.o ceph/dir.o ceph/file.o
> > ceph/locks.o ceph/addr.o ceph/ioctl.o \
> > +     ceph/export.o ceph/caps.o ceph/snap.o ceph/xattr.o \
> > +     ceph/mds_client.o ceph/mdsmap.o ceph/strings.o ceph/ceph_frag=
=2Eo \
> > +     ceph/debugfs.o  \
> > +     libceph/ceph_common.o libceph/messenger.o libceph/msgpool.o
> > libceph/buffer.o libceph/pagelist.o \
> > +     libceph/mon_client.o \
> > +     libceph/osd_client.o libceph/osdmap.o libceph/crush/crush.o
> > libceph/crush/mapper.o libceph/crush/hash.o \
> > +     libceph/debugfs.o \
> > +     libceph/auth.o libceph/auth_none.o \
> > +     libceph/crypto.o libceph/armor.o \
> > +     libceph/auth_x.o \
> > +     libceph/ceph_fs.o libceph/ceph_strings.o libceph/ceph_hash.o =
\
> > +     libceph/pagevec.o
> > +
> > +clean-files +=3D Modules_symvers
> > +clean-files +=3D Module_symvers
> > +
> > +#EXTRA_CFLAGS +=3D
> > +
> > +else
> > +# Otherwise we were called directly from the command
> > +# line; invoke the kernel build system.
> > +
> > +KERNELRELEASE ?=3D $(shell uname -r)
> > +KERNELDIR ?=3D /lib/modules/$(KERNELRELEASE)/build
> > +PWD :=3D $(shell pwd)
> > +
> > +
> > +default: all
> > +
> > +all:
> > +     $(MAKE) -C $(KERNELDIR) M=3D$(PWD) CONFIG_CEPH_FS=3Dm modules
> > +
> > +modules_install:
> > +     $(MAKE) -C $(KERNELDIR) M=3D$(PWD) CONFIG_CEPH_FS=3Dm modules=
_install
> > +clean:
> > +     $(MAKE) -C $(KERNELDIR) M=3D$(PWD) clean
> > +
> > +endif
> > diff --git a/ceph-std/libceph/ceph_common.c
> > b/ceph-client-standalone/libceph/ceph_common.c
> > index fc759f8..58feda5 100644
> > --- a/ceph-std/libceph/ceph_common.c
> > +++ b/ceph-client-standalone/libceph/ceph_common.c
> > @@ -487,6 +487,8 @@ int ceph_open_session(struct ceph_client *clien=
t)
> >  EXPORT_SYMBOL(ceph_open_session);
> >
> >
> > +#ifdef CONFIG_CEPH_LIB
> > +
> >  static int __init init_ceph_lib(void)
> >  {
> >       int ret =3D 0;
> > @@ -522,6 +524,8 @@ static void __exit exit_ceph_lib(void)
> >  module_init(init_ceph_lib);
> >  module_exit(exit_ceph_lib);
> >
> > +#endif
> > +
> >  MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
> >  MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
> >  MODULE_AUTHOR("Patience Warnick <patience@newdream.net>");
> >
> >
> > -------- =E8=BD=AC=E5=8F=91=E7=9A=84=E4=BF=A1=E4=BB=B6 --------
> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Jeff Wu <cpwu@tnsoft.com.cn>
> > > Reply-to: Jeff Wu <cpwu@tnsoft.com.cn>
> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: ceph-devel <ceph-devel@vger.kernel.o=
rg>
> > > =E6=8A=84=E9=80=81: Andrew Lv <mllv@tnsoft.com.cn>
> > > =E4=B8=BB=E9=A2=98: Fail to compile ceph-client-standalone: maste=
r-backport
> > > =E6=97=A5=E6=9C=9F: Mon, 6 Dec 2010 13:53:43 +0800
> > >
> > > Hi ,
> > >
> > >  I git ceph-client-standalone : master-backport
> > > from git://ceph.newdream.net/git/ceph-client-standalone.git
> > >
> > > but fail to compile it ,what is it wrong ?  the detail steps and =
logs
> > > attached below.
> > >
> > >  Thanks.
> > >
> > > Jeff
> > >
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > jeff@cephhost:~/work/ceph$ git clone
> > > git://ceph.newdream.net/git/ceph-client-standalone.git
> > > Initialized empty Git repository
> > > in /home/jeff/work/ceph/ceph-client-standalone/.git/
> > > remote: Counting objects: 2435, done.
> > > remote: Compressing objects: 100% (1391/1391), done.
> > > remote: Total 2435 (delta 1724), reused 1593 (delta 1033)
> > > Receiving objects: 100% (2435/2435), 760.24 KiB | 191 KiB/s, done=
=2E
> > > Resolving deltas: 100% (1724/1724), done.
> > >
> > > jeff@cephhost:~/work/ceph$ cd ceph-client-standalone/
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone$ git branch
> > > master-backport origin/master-backport
> > > Branch master-backport set up to track remote branch master-backp=
ort
> > > from origin.
> > >
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone$ git checkout
> > > master-backport
> > > Switched to branch 'master-backport'
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone$ ls
> > > ceph  debian  dkms  dkms.conf  include-ceph  include-crush
> > > last_upstream_commit  libceph  rbd  start  upstream_version.h
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone$ cd libceph/
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone/libceph$ make
> > > make -C /lib/modules/2.6.35-22-generic/build
> > > M=3D/home/jeff/work/ceph/ceph-client-standalone/libceph CONFIG_CE=
PH_LIB=3Dm
> > > modules
> > >
> > > .................................................................=
=2E..................................
> > >
> > >   LD [M]  /home/jeff/work/ceph/ceph-client-standalone/libceph/lib=
ceph.o
> > >   Building modules, stage 2.
> > >   MODPOST 1 modules
> > >
> > > CC      /home/jeff/work/ceph/ceph-client-standalone/libceph/libce=
ph.mod.o
> > >   LD [M]  /home/jeff/work/ceph/ceph-client-standalone/libceph/lib=
ceph.ko
> > > make[1]:Leaving `/usr/src/linux-headers-2.6.35-22-generic'
> > >
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone/libceph$ cd ..
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone$ cd ceph/
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone/ceph$ make
> > > make -C /lib/modules/2.6.35-22-generic/build
> > > M=3D/home/jeff/work/ceph/ceph-client-standalone/ceph CONFIG_CEPH_=
=46S=3Dm
> > > modules
> > >
> > > .................................................................=
=2E.................
> > >
> > >   CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/string=
s.o
> > >   CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph_f=
rag.o
> > >   CC [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/debugf=
s.o
> > >   LD [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.o
> > >   Building modules, stage 2.
> > >   MODPOST 1 modules
> > > WARNING:
> > > "ceph_msgr_flush" [/home/jeff/work/ceph/ceph-client-standalone/ce=
ph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_con_close" [/home/jeff/work/ceph/ceph-client-standalone/cep=
h/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_con_init" [/home/jeff/work/ceph/ceph-client-standalone/ceph=
/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_buffer_release" [/home/jeff/work/ceph/ceph-client-standalon=
e/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pr_addr" [/home/jeff/work/ceph/ceph-client-standalone/ceph/=
ceph.ko] undefined!
> > > WARNING:
> > > "ceph_parse_options" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_writepages" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_monc_validate_auth" [/home/jeff/work/ceph/ceph-client-stand=
alone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_monc_do_statfs" [/home/jeff/work/ceph/ceph-client-standalon=
e/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_alloc_page_vector" [/home/jeff/work/ceph/ceph-client-standa=
lone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "__ceph_open_session" [/home/jeff/work/ceph/ceph-client-standalon=
e/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_copy_user_to_page_vector" [/home/jeff/work/ceph/ceph-client=
-standalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_destroy_client" [/home/jeff/work/ceph/ceph-client-standalon=
e/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_sync" [/home/jeff/work/ceph/ceph-client-standalone/cep=
h/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pagelist_release" [/home/jeff/work/ceph/ceph-client-standal=
one/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_put_page_vector" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_buffer_new" [/home/jeff/work/ceph/ceph-client-standalone/ce=
ph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_msg_dump" [/home/jeff/work/ceph/ceph-client-standalone/ceph=
/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_compare_options" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_start_request" [/home/jeff/work/ceph/ceph-client-stand=
alone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_zero_page_vector_range" [/home/jeff/work/ceph/ceph-client-s=
tandalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_con_send" [/home/jeff/work/ceph/ceph-client-standalone/ceph=
/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_readpages" [/home/jeff/work/ceph/ceph-client-standalon=
e/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_monc_got_mdsmap" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_calc_file_object_mapping" [/home/jeff/work/ceph/ceph-client=
-standalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pagelist_set_cursor" [/home/jeff/work/ceph/ceph-client-stan=
dalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_new_request" [/home/jeff/work/ceph/ceph-client-standal=
one/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_wait_request" [/home/jeff/work/ceph/ceph-client-standa=
lone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_get_direct_page_vector" [/home/jeff/work/ceph/ceph-client-s=
tandalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_calc_object_layout" [/home/jeff/work/ceph/ceph-client-stand=
alone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pagelist_append" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pagelist_reserve" [/home/jeff/work/ceph/ceph-client-standal=
one/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_check_fsid" [/home/jeff/work/ceph/ceph-client-standalone/ce=
ph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_release_page_vector" [/home/jeff/work/ceph/ceph-client-stan=
dalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_pagelist_truncate" [/home/jeff/work/ceph/ceph-client-standa=
lone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_msg_type_name" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_msg_new" [/home/jeff/work/ceph/ceph-client-standalone/ceph/=
ceph.ko] undefined!
> > > WARNING:
> > > "ceph_copy_page_vector_to_user" [/home/jeff/work/ceph/ceph-client=
-standalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_caps_for_mode" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_msg_last_put" [/home/jeff/work/ceph/ceph-client-standalone/=
ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_flags_to_mode" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_con_open" [/home/jeff/work/ceph/ceph-client-standalone/ceph=
/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_osdc_release_request" [/home/jeff/work/ceph/ceph-client-sta=
ndalone/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_calc_pg_primary" [/home/jeff/work/ceph/ceph-client-standalo=
ne/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_create_client" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > > WARNING:
> > > "ceph_con_keepalive" [/home/jeff/work/ceph/ceph-client-standalone=
/ceph/ceph.ko] undefined!
> > >   CC      /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.m=
od.o
> > >   LD [M]  /home/jeff/work/ceph/ceph-client-standalone/ceph/ceph.k=
o
> > > make[1]:leaving `/usr/src/linux-headers-2.6.35-22-generic'
> > > jeff@cephhost:~/work/ceph/ceph-client-standalone/ceph$
> > >
> > >
> > >
> > >
> >
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
