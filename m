From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: ceph_dentry_info: Objects remaining on kmem_cache_close()
 (ceph-client-standalone/master-backport on kernel 2.6.32)
Date: Sat, 05 Jun 2010 11:16:36 +0200
Message-ID: <1275729396.5836.35.camel@wido-laptop.pcextreme.nl>
References: <hud40h$j7u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:55131 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626Ab0FEJQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jun 2010 05:16:39 -0400
In-Reply-To: <hud40h$j7u$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi,

That's a known issue, already reported on:
http://tracker.newdream.net/issues/139

=46YI, still present with the 2.6.35 kernel.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Sat, 2010-06-05 at 09:05 +0000, Thomas Mueller wrote:
> hi
>=20
> i get the kernel messages below if I do a "modprobe -r ceph".
>=20
> system: Debian Squeeze
> kernel: 2.6.32
> kclient: ceph-client-standalone branch master-backport
>=20
> - Thomas
>=20
>=20
>=20
> kernel: [  398.964535] ceph: loaded (mon/mds/osd proto 15/32/24, osdm=
ap=20
> 5/5 5/5)
> kernel: [  400.701544] ceph: client4101 fsid=20
> f233d1fe-24b6-6458-0764-364f3b1e250d
> kernel: [  400.701794] ceph: mon1 127.0.0.1:6789 session established
> kernel: [ 1427.320842]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> kernel: [ 1427.320852] BUG ceph_dentry_info: Objects remaining on=20
> kmem_cache_close()
> kernel: [ 1427.320857]=20
> ---------------------------------------------------------------------=
--------
> kernel: [ 1427.320861]=20
> kernel: [ 1427.320868] INFO: Slab 0xffffea0003b766a8 objects=3D51 use=
d=3D4=20
> fp=3D0xffff88010fd43fa0 flags=3D0x200000000000080
> kernel: [ 1427.320878] Pid: 25898, comm: modprobe Not tainted 2.6.32-=
3-
> amd64 #1
> kernel: [ 1427.320883] Call Trace:
> kernel: [ 1427.320899]  [<ffffffff810e3397>] ? slab_err+0xba/0xdf
> kernel: [ 1427.320910]  [<ffffffff81064977>] ? bit_waitqueue+0x10/0xa=
0
> kernel: [ 1427.320922]  [<ffffffff81074a3b>] ? generic_exec_single
> +0x64/0x7f
> kernel: [ 1427.320931]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x3=
9
> kernel: [ 1427.320939]  [<ffffffff810e43dd>] ? list_slab_objects
> +0xa3/0x16a
> kernel: [ 1427.320947]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x3=
9
> kernel: [ 1427.320955]  [<ffffffff810e3087>] ? add_partial+0x11/0x58
> kernel: [ 1427.320963]  [<ffffffff810e3d97>] ? deactivate_slab+0xb4/0=
xcd
> kernel: [ 1427.320973]  [<ffffffff810e78f3>] ? kmem_cache_destroy
> +0x105/0x1f6
> kernel: [ 1427.320993]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x=
36=20
> [ceph]
> kernel: [ 1427.321006]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [c=
eph]
> kernel: [ 1427.321015]  [<ffffffff81078657>] ? sys_delete_module
> +0x1d2/0x258
> kernel: [ 1427.321025]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x=
282
> kernel: [ 1427.321036]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
> kernel: [ 1427.321047]  [<ffffffff81010b42>] ? system_call_fastpath
> +0x16/0x1b
> kernel: [ 1427.321060] INFO: Object 0xffff88010fd437d0 @offset=3D2000
> kernel: [ 1427.321066] INFO: Object 0xffff88010fd43820 @offset=3D2080
> kernel: [ 1427.321071] INFO: Object 0xffff88010fd43870 @offset=3D2160
> kernel: [ 1427.321076] INFO: Object 0xffff88010fd438c0 @offset=3D2240
> kernel: [ 1427.321083]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> kernel: [ 1427.321089] BUG ceph_dentry_info: Objects remaining on=20
> kmem_cache_close()
> kernel: [ 1427.321094]=20
> ---------------------------------------------------------------------=
--------
> kernel: [ 1427.321097]=20
> kernel: [ 1427.321104] INFO: Slab 0xffffea00019228b8 objects=3D51 use=
d=3D1=20
> fp=3D0xffff880072e717d0 flags=3D0x100000000000080
> kernel: [ 1427.321112] Pid: 25898, comm: modprobe Not tainted 2.6.32-=
3-
> amd64 #1
> kernel: [ 1427.321116] Call Trace:
> kernel: [ 1427.321123]  [<ffffffff810e3397>] ? slab_err+0xba/0xdf
> kernel: [ 1427.321134]  [<ffffffff812ed452>] ? printk+0x4e/0x5c
> kernel: [ 1427.321143]  [<ffffffff81074a3b>] ? generic_exec_single
> +0x64/0x7f
> kernel: [ 1427.321151]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x3=
9
> kernel: [ 1427.321160]  [<ffffffff810e43dd>] ? list_slab_objects
> +0xa3/0x16a
> kernel: [ 1427.321168]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x3=
9
> kernel: [ 1427.321176]  [<ffffffff810e3087>] ? add_partial+0x11/0x58
> kernel: [ 1427.321184]  [<ffffffff810e3d97>] ? deactivate_slab+0xb4/0=
xcd
> kernel: [ 1427.321193]  [<ffffffff810e78f3>] ? kmem_cache_destroy
> +0x105/0x1f6
> kernel: [ 1427.321207]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x=
36=20
> [ceph]
> kernel: [ 1427.321220]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [c=
eph]
> kernel: [ 1427.321228]  [<ffffffff81078657>] ? sys_delete_module
> +0x1d2/0x258
> kernel: [ 1427.321237]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x=
282
> kernel: [ 1427.321246]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
> kernel: [ 1427.321255]  [<ffffffff81010b42>] ? system_call_fastpath
> +0x16/0x1b
> kernel: [ 1427.321269] INFO: Object 0xffff880072e71460 @offset=3D1120
> kernel: [ 1427.321276] SLUB ceph_dentry_info: kmem_cache_destroy call=
ed=20
> for cache that still has objects.
> kernel: [ 1427.321284] Pid: 25898, comm: modprobe Not tainted 2.6.32-=
3-
> amd64 #1
> kernel: [ 1427.321288] Call Trace:
> kernel: [ 1427.321297]  [<ffffffff810e798a>] ? kmem_cache_destroy
> +0x19c/0x1f6
> kernel: [ 1427.321311]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x=
36=20
> [ceph]
> kernel: [ 1427.321324]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [c=
eph]
> kernel: [ 1427.321332]  [<ffffffff81078657>] ? sys_delete_module
> +0x1d2/0x258
> kernel: [ 1427.321340]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x=
282
> kernel: [ 1427.321349]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
> kernel: [ 1427.321358]  [<ffffffff81010b42>] ? system_call_fastpath
> +0x16/0x1b
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
