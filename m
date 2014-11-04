From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: The Async messenger benchmark with latest master
Date: Tue, 04 Nov 2014 05:29:20 +0100 (CET)
Message-ID: <611a8971-3ad7-4f5c-9a11-d2be5aade2df@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F3C7@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:37784 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaKDE33 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 23:29:29 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F3C7@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Haomai Wang <haomaiwang@gmail.com>

Hi,

I'm try to test the async messenger (ms_type =3D async) with last maste=
r,
and I have an assert on line 1046 of AsyncConnection.cc.
(I don't have tried yet with previous builds)

no tuning in ceph.conf, only the ms_type =3D async.




#ceph -w
msg/async/AsyncConnection.cc: In function 'int AsyncConnection::_proces=
s_connection()' thread 7fd396201700 time 2014-11-04 05:22:10.878492
msg/async/AsyncConnection.cc: 1046: FAILED assert(m)
 ceph version 0.87-600-g25ca92d (25ca92d7ff5cc326d77c1c3f687ece0718f02d=
b9)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x72) [0x7fd39a1efb52]
 2: (AsyncConnection::_process_connection()+0x40e9) [0x7fd39a307ac9]
 3: (AsyncConnection::process()+0xcb) [0x7fd39a3082ab]
 4: (EventCenter::process_events(int)+0x567) [0x7fd39a321a27]
 5: (Worker::entry()+0x7f) [0x7fd39a30f1cf]
 6: (()+0x6b50) [0x7fd39ea11b50]
 7: (clone()+0x6d) [0x7fd39debb7bd]


Any idea ?

----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Sage Weil" <sage@newdream.net>, "Haomai Wang" <haomaiwang@gmai=
l.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 22 Octobre 2014 22:34:34=20
Objet: RE: The Async messenger benchmark with latest master=20

Sage,=20
So, with krbd as client, should I use 'ms_type =3D random' in the clust=
er side to test Async messenger in the cluster side?=20
BTW, what this option does ? It will pick Async first and fall back to =
old messenger in case any problem ?=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Sage Weil [mailto:sage@newdream.net]=20
Sent: Wednesday, October 22, 2014 10:53 AM=20
To: Haomai Wang=20
Cc: Somnath Roy; ceph-devel@vger.kernel.org=20
Subject: Re: The Async messenger benchmark with latest master=20

On Thu, 23 Oct 2014, Haomai Wang wrote:=20
> It should be but I'm not convinced of the current impl of=20
> AsyncMessenger. It's possible that exists some corner situations whic=
h=20
> may break=20

The 'ms_type =3D random' option we added should give us some confidnece=
 that this is true (by doing QA on mixes old both messenger implementat=
ions).=20

sage=20


>=20
> On Thu, Oct 23, 2014 at 1:18 AM, Somnath Roy <Somnath.Roy@sandisk.com=
> wrote:=20
> > Thanks Haomai, I will try this branch out.=20
> > BTW, will it be compatible with the client which is not using this =
async messenger for example krbd ?=20
> >=20
> > Regards=20
> > Somnath=20
> >=20
> > -----Original Message-----=20
> > From: Haomai Wang [mailto:haomaiwang@gmail.com]=20
> > Sent: Wednesday, October 22, 2014 10:02 AM=20
> > To: Somnath Roy=20
> > Cc: ceph-devel@vger.kernel.org=20
> > Subject: Re: The Async messenger benchmark with latest master=20
> >=20
> > ms_type =3D async is needed to add [global] section in ceph.conf=20
> >=20
> > No other options are needed=20
> >=20
> > On Thu, Oct 23, 2014 at 12:02 AM, Somnath Roy <Somnath.Roy@sandisk.=
com> wrote:=20
> >> Hi Haomai/Sage,=20
> >>=20
> >> I just figured it out that Async messenger is not yet in master.=20
> >> So, I didn't really test the async messenger :-(=20
> >>=20
> >> I saw here is the pull request.=20
> >>=20
> >> https://github.com/ceph/ceph/pull/2768=20
> >>=20
> >> I want to test this out and I have some questions regarding this.=20
> >>=20
> >> 1. The branch I should test out is the following, right ?=20
> >>=20
> >> https://github.com/ceph/ceph/tree/wip-msgr=20
> >>=20
> >> 2. Will Async messenger by default enabled ? OR I need to add some=
 config option for that ?=20
> >>=20
> >> 3. Other than ms_event_op_threads , is there any tunable parameter=
 I should be playing with ?=20
> >>=20
> >> Thanks & Regards=20
> >> Somnath=20
> >>=20
> >> -----Original Message-----=20
> >> From: Haomai Wang [mailto:haomaiwang@gmail.com]=20
> >> Sent: Saturday, October 18, 2014 10:15 PM=20
> >> To: Somnath Roy=20
> >> Cc: ceph-devel@vger.kernel.org=20
> >> Subject: Re: The Async messenger benchmark with latest master=20
> >>=20
> >> Thanks Somnath!=20
> >>=20
> >> I have another simple performance test for async messenger:=20
> >>=20
> >> For 4k object read, master branch used 4.46s to complete tests, as=
ync Messenger used 3.14s For 4k object write, master branch used 10.6s =
to complete, async Messenger used 6.6s!!=20
> >>=20
> >> Detailf results see below, 4k object read is a simple ceph client=20
> >> program which will read 5000 objects and 4k object write will writ=
e=20
> >> 5000 objects.=20
> >> I increased "ms_event_op_threads" to 10 compared to the default va=
lue is 2.=20
> >> Maybe Somnath can do it and tests again, I think we can get more i=
mprovements for your tests.=20
> >>=20
> >> Master Branch(6fa686c8c42937dd069591f16de92e954d8ed34d):=20
> >>=20
> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&=20
> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &&=
=20
> >> sleep 3; done=20
> >>=20
> >> Fri Oct 17 17:10:39 UTC 2014=20
> >>=20
> >> Used Time:4.461581=20
> >>=20
> >> Fri Oct 17 17:10:44 UTC 2014=20
> >>=20
> >> Used Time:4.388572=20
> >>=20
> >> Fri Oct 17 17:10:48 UTC 2014=20
> >>=20
> >> Used Time:4.448157=20
> >>=20
> >> [root@ceph-test src]#=20
> >>=20
> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&=20
> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &=
&=20
> >> sleep 3; doneFri Oct 17 17:11:23 UTC 2014=20
> >>=20
> >> Used Time:10.638783=20
> >>=20
> >> Fri Oct 17 17:11:33 UTC 2014=20
> >>=20
> >> Used Time:10.793231=20
> >>=20
> >> Fri Oct 17 17:11:44 UTC 2014=20
> >>=20
> >> Used Time:10.908003=20
> >>=20
> >>=20
> >> Master Branch with AsyncMessenger:=20
> >>=20
> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&=20
> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &&=
=20
> >> sleep 3; done=20
> >>=20
> >> Sun Oct 19 06:01:50 UTC 2014=20
> >>=20
> >> Used Time:3.155506=20
> >>=20
> >> Sun Oct 19 06:01:53 UTC 2014=20
> >>=20
> >> Used Time:3.134961=20
> >>=20
> >> Sun Oct 19 06:01:56 UTC 2014=20
> >>=20
> >> Used Time:3.135814=20
> >>=20
> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&=20
> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &=
&=20
> >> sleep 3; done=20
> >>=20
> >> Sun Oct 19 06:02:03 UTC 2014=20
> >>=20
> >> Used Time:6.536319=20
> >>=20
> >> Sun Oct 19 06:02:10 UTC 2014=20
> >>=20
> >> Used Time:6.648738=20
> >>=20
> >> Sun Oct 19 06:02:16 UTC 2014=20
> >>=20
> >> Used Time:6.585156=20
> >>=20
> >> On Sat, Oct 18, 2014 at 4:37 AM, Somnath Roy <Somnath.Roy@sandisk.=
com> wrote:=20
> >>> Hi Sage/Haomai,=20
> >>>=20
> >>> I did some 4K Random Read benchmarking with latest master having =
Async messenger changes and result looks promising.=20
> >>>=20
> >>> My configuration:=20
> >>> ---------------------=20
> >>>=20
> >>> 1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg=20
> >>> cluster wide Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, dua=
l socket, HT enabled, 40 cores.=20
> >>> Used krbd as client.=20
> >>>=20
> >>>=20
> >>> 1 clinet node with 3 rbd images on 3 different pools:=20
> >>> -----------------------------------------------------------------=
-=20
> >>> -=20
> >>> Master :=20
> >>> ---------=20
> >>>=20
> >>> ~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB=20
> >>>=20
> >>> lat (usec) : 4=3D0.01%, 10=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D=
0.03%=20
> >>> lat (usec) : 500=3D0.86%, 750=3D3.72%, 1000=3D7.19%=20
> >>> lat (msec) : 2=3D39.17%, 4=3D41.45%, 10=3D7.26%, 20=3D0.24%, 50=3D=
0.06%=20
> >>> lat (msec) : 100=3D0.03%, 250=3D0.01%, 500=3D0.01%=20
> >>>=20
> >>> cpu: ~1-2 % idle=20
> >>>=20
> >>> Giant:=20
> >>> ------=20
> >>>=20
> >>> ~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB=20
> >>>=20
> >>> lat (usec) : 250=3D0.01%, 500=3D0.51%, 750=3D2.71%, 1000=3D6.03%=20
> >>> lat (msec) : 2=3D34.32%, 4=3D45.74%, 10=3D10.46%, 20=3D0.21%, 50=3D=
0.02%=20
> >>> lat (msec) : 100=3D0.01%, 250=3D0.01%=20
> >>>=20
> >>> cpu: ~2% idle=20
> >>>=20
> >>> 2 clients with 3 rbd images each on 3 different pools:=20
> >>> -----------------------------------------------------------------=
-=20
> >>> -=20
> >>>=20
> >>> Master :=20
> >>> ---------=20
> >>>=20
> >>> ~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB=20
> >>>=20
> >>> lat (usec) : 250=3D0.03%, 500=3D0.63%, 750=3D2.67%, 1000=3D5.21%=20
> >>> lat (msec) : 2=3D25.12%, 4=3D36.19%, 10=3D24.80%, 20=3D3.16%, 50=3D=
1.34%=20
> >>> lat (msec) : 100=3D0.66%, 250=3D0.18%, 500=3D0.01%=20
> >>>=20
> >>> cpu: ~0-1 % idle=20
> >>>=20
> >>> Giant:=20
> >>> --------=20
> >>> ~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB=20
> >>>=20
> >>> lat (usec) : 250=3D0.01%, 500=3D0.25%, 750=3D1.47%, 1000=3D3.45%=20
> >>> lat (msec) : 2=3D21.22%, 4=3D36.69%, 10=3D30.63%, 20=3D4.28%, 50=3D=
1.70%=20
> >>> lat (msec) : 100=3D0.28%, 250=3D0.02%, 500=3D0.01%=20
> >>>=20
> >>> cpu: ~1% idle=20
> >>>=20
> >>>=20
> >>> So, in summary the master with Async messenger has improved both =
in iops and latency.=20
> >>>=20
> >>> Thanks & Regards=20
> >>> Somnath=20
> >>>=20
> >>> ________________________________=20
> >>>=20
> >>> PLEASE NOTE: The information contained in this electronic mail me=
ssage is intended only for the use of the designated recipient(s) named=
 above. If the reader of this message is not the intended recipient, yo=
u are hereby notified that you have received this message in error and =
that any review, dissemination, distribution, or copying of this messag=
e is strictly prohibited. If you have received this communication in er=
ror, please notify the sender by telephone or e-mail (as shown above) i=
mmediately and destroy any and all copies of this message in your posse=
ssion (whether hard copies or electronically stored copies).=20
> >>>=20
> >>> --=20
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"=20
> >>> in the body of a message to majordomo@vger.kernel.org More=20
> >>> majordomo info at http://vger.kernel.org/majordomo-info.html=20
> >>=20
> >>=20
> >>=20
> >> --=20
> >> Best Regards,=20
> >>=20
> >> Wheat=20
> >=20
> >=20
> >=20
> > --=20
> > Best Regards,=20
> >=20
> > Wheat=20
>=20
>=20
>=20
> --=20
> Best Regards,=20
>=20
> Wheat=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
