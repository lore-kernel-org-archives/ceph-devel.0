From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: Kernel crashes with RBD
Date: Sat, 14 Apr 2012 15:32:12 +0200
Message-ID: <4F897C5C.4030309@bisect.de>
References: <4F860619.5040802@bisect.de> <4F88670A.7080709@dreamhost.com> <4F886E09.7040801@bisect.de> <4F8892E4.6030504@dreamhost.com> <4F88B0D6.6030401@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD1B03FE3D5D78F79AB6D9A5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:53047 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860Ab2DNNcV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 14 Apr 2012 09:32:21 -0400
In-Reply-To: <4F88B0D6.6030401@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>, Alex Elder <elder@dreamhost.com>, Danny Kukawka <dkukawka@suse.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD1B03FE3D5D78F79AB6D9A5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.04.2012 01:03, schrieb Danny Kukawka:
> Am 13.04.2012 22:56, schrieb Josh Durgin:
>> On 04/13/2012 11:18 AM, Danny Kukawka wrote:
>>> Hi
>>>
>>> Am 13.04.2012 19:48, schrieb Josh Durgin:
>>>> On 04/11/2012 03:30 PM, Danny Kukawka wrote:
>>> [...]
>>>>
>>>> This looks similar to http://tracker.newdream.net/issues/2261. What =
do
>>>> you think Alex?
>>>
>>> Not sure about that, since this crashes only the clients and not the
>>> OSDs. We see no crashes in the cluster.
>>
>> These are both rbd kernel client crashes, but looking again they seem
>> like different underlying issues, so I opened
>> http://tracker.newdream.net/issues/2287 to track this problem.
>>
>>>
>>> I analyzed it a bit more and found that the last working version was
>>> 0.43. Any later released version leads to this crash sooner or later,=

>>> but as I already said only on a 10Gbit (FC) network. I didn't see any=

>>> crash on the 1Gbit net on the same machines.
>>>
>>> What kind of network do you use at dreamhost for testing?
>>
>> Mostly 1Gbit, some 10Gbit, but I don't think we've tested the kernel
>> client on 10Gbit yet.
>=20
> That's what I assumed ;-)
>=20
>>> If you need more info, let me known.
>>
>> Do the crashes always have the same stack trace? When you say 10Gbit
>> for the cluster, does that include the client using rbd, or just the
>> osds?
>=20
> It's always the same stack trace (sometimes a address is different, but=

> everything else looks identical).
>=20
> We tested basically the following setups and the crash happend with all=

> of them:
> 1) OSD, MON and Clients in the same 10Gbit network
> 2) OSD, MON and Clients in different public/cluster 10Gbit networks
> 3) OSD and Clients in the same 10Gbit network, MON in 1Gbit network
> 3) OSD and Clients in the same 10Gbit network, MON in 1Gbit network
>    different public/cluster networks
>=20
> The number of OSDs (tested 4 nodes with 10 OSDs per node, each one
> physical harddisk) didn't matter in this case. If I use 2 clients
> running fio tests against one 50GByte RBD per client, I hit the problem=

> faster than with one client. If you need information about the used fio=

> tests, let me know.
>=20
> As already I said: we didn't hit this problem with 1Gbit networks yet.

Now I see this kind of crash also on 1Gbit and running tests against RBD
with the following setup:
- 30 OSD nodes, 3 OSDs per node
- 11 clients
- 3 MON
- 2 MDS (1 active, 1 standby)
- different public/cluster 1Gbit networks
- ceph 0.45

ceph -s:
------------
2012-04-14 15:29:53.744829    pg v5609: 18018 pgs: 18018 active+clean;
549 GB data, 1107 GB used, 22382 GB / 23490 GB avail
2012-04-14 15:29:53.781966   mds e6: 1/1/1 up {0=3Dalpha=3Dup:active}, 1
up:standby-replay
2012-04-14 15:29:53.782002   osd e26: 90 osds: 90 up, 90 in
2012-04-14 15:29:53.782233   log 2012-04-14 15:11:51.857127 osd.68
192.168.111.43:6801/23591 1372 : [WRN] old request
osd_sub_op(client.4180.1:931208 2.dfc eca8dfc/rb.0.3.000000000e76/head
[] v 26'1534 snapset=3D0=3D[]:[] snapc=3D0=3D[]) v6 received at 2012-04-1=
4
15:11:20.882595 currently startedold request
osd_sub_op(client.4250.1:885302 2.898 6bf1d898/rb.0.6.000000000b61/head
[] v 26'1662 snapset=3D0=3D[]:[] snapc=3D0=3D[]) v6 received at 2012-04-1=
4
15:11:21.663493 currently startedold request osd_op(client.4262.1:888106
rb.0.9.000000000672 [write 1286144~4096] 2.45aa94a) received at
2012-04-14 15:11:19.879144 currently waiting for sub opsold request
osd_op(client.4250.1:885252 rb.0.6.0000000018a2 [write 1073152~4096]
2.fb3ab288) received at 2012-04-14 15:11:19.927412 currently waiting for
sub opsold request osd_op(client.4241.1:930301 rb.0.1.000000002fdc
[write 8192~4096] 2.9110ba90) received at 2012-04-14 15:11:20.645040
currently waiting for sub opsold request osd_op(client.4250.1:885278
rb.0.6.0000000013cf [write 1892352~4096] 2.cfe911f0) received at
2012-04-14 15:11:20.616330 currently waiting for sub ops
2012-04-14 15:29:53.782370   mon e1: 3 mons at
{alpha=3D192.168.111.33:6789/0,beta=3D192.168.111.34:6789/0,gamma=3D192.1=
68.111.35:6789/0}
------------

crash backtrace:
------------
PID: 86     TASK: ffff880432326040  CPU: 13  COMMAND: "kworker/13:1"
 #0 [ffff880432329970] machine_kexec at ffffffff810265ee
 #1 [ffff8804323299c0] crash_kexec at ffffffff810a3bda
 #2 [ffff880432329a90] oops_end at ffffffff81444688
 #3 [ffff880432329ab0] __bad_area_nosemaphore at ffffffff81032a35
 #4 [ffff880432329b70] do_page_fault at ffffffff81446d3e
 #5 [ffff880432329c70] page_fault at ffffffff81443865
    [exception RIP: write_partial_msg_pages+1181]
    RIP: ffffffffa0352e8d  RSP: ffff880432329d20  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff88043268a030  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000001000
    RBP: 0000000000000000   R8: 0000000000000000   R9: 00000000479aae8f
    R10: 00000000000005a8  R11: 0000000000000000  R12: 0000000000001000
    R13: ffffea000e917608  R14: 0000160000000000  R15: ffff88043217fbc0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff880432329d78] try_write at ffffffffa0355345 [libceph]
 #7 [ffff880432329df8] con_work at ffffffffa0355bdd [libceph]
 #8 [ffff880432329e28] process_one_work at ffffffff8107487c
 #9 [ffff880432329e78] worker_thread at ffffffff8107740a
#10 [ffff880432329ee8] kthread at ffffffff8107b736
#11 [ffff880432329f48] kernel_thread_helper at ffffffff8144c144
------------

Danny


--------------enigCD1B03FE3D5D78F79AB6D9A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQECAAYFAk+JfF0ACgkQ9DHLX79LmTKQQgP/RCGzrXZ0UAlVCccaRnVu9Yj1
RzcnqpyA9t7MPLM9OFcQ6etNtLbYjoejz48Jtx1Wp9xEFgmyt0DOTUo4QPdNoqpG
zRwC7L2hS6dpg8xlOURM8oz+qNyiDOsTHhS9Cv2RDjdkmDw2LvM4P3GVBUliubIy
kRXJLSfAwU31RbScQrM=
=BHQF
-----END PGP SIGNATURE-----

--------------enigCD1B03FE3D5D78F79AB6D9A5--
