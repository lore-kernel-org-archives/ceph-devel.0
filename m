From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: The Async messenger benchmark with latest master
Date: Sun, 19 Oct 2014 20:49:08 +0200 (CEST)
Message-ID: <6525d3a1-dd42-4655-a418-4e24c5e41f8e@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822CFC6@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46096 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaJSStR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Oct 2014 14:49:17 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822CFC6@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org, Haomai Wang <haomaiwang@gmail.com>

>>Alexandre,=20
>>Here is my config..=20

Thanks Sommath !



----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Haomai Wang" <haomaiwang@gmail.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Dimanche 19 Octobre 2014 08:15:57=20
Objet: RE: The Async messenger benchmark with latest master=20

Haomai,=20
Sure , I will change ' ms_event_op_threads' and update my findings.=20

Alexandre,=20
Here is my config..=20


-----Original Message-----=20
=46rom: Haomai Wang [mailto:haomaiwang@gmail.com]=20
Sent: Saturday, October 18, 2014 10:15 PM=20
To: Somnath Roy=20
Cc: ceph-devel@vger.kernel.org=20
Subject: Re: The Async messenger benchmark with latest master=20

Thanks Somnath!=20

I have another simple performance test for async messenger:=20

=46or 4k object read, master branch used 4.46s to complete tests, async=
 Messenger used 3.14s For 4k object write, master branch used 10.6s to =
complete, async Messenger used 6.6s!!=20

Detailf results see below, 4k object read is a simple ceph client progr=
am which will read 5000 objects and 4k object write will write=20
5000 objects.=20
I increased "ms_event_op_threads" to 10 compared to the default value i=
s 2.=20
Maybe Somnath can do it and tests again, I think we can get more improv=
ements for your tests.=20

Master Branch(6fa686c8c42937dd069591f16de92e954d8ed34d):=20

[root@ceph-test src]# for i in `seq 1 3`; do date && ~/08.rados_read_4k=
_for_each_object /etc/ceph/ceph.conf rbd 5000 && sleep 3; done=20

=46ri Oct 17 17:10:39 UTC 2014=20

Used Time:4.461581=20

=46ri Oct 17 17:10:44 UTC 2014=20

Used Time:4.388572=20

=46ri Oct 17 17:10:48 UTC 2014=20

Used Time:4.448157=20

[root@ceph-test src]#=20

[root@ceph-test src]# for i in `seq 1 3`; do date && ~/01.rados_write_4=
k_for_each_object /etc/ceph/ceph.conf rbd 5000 && sleep 3; doneFri Oct =
17 17:11:23 UTC 2014=20

Used Time:10.638783=20

=46ri Oct 17 17:11:33 UTC 2014=20

Used Time:10.793231=20

=46ri Oct 17 17:11:44 UTC 2014=20

Used Time:10.908003=20


Master Branch with AsyncMessenger:=20

[root@ceph-test src]# for i in `seq 1 3`; do date && ~/08.rados_read_4k=
_for_each_object /etc/ceph/ceph.conf rbd 5000 && sleep 3; done=20

Sun Oct 19 06:01:50 UTC 2014=20

Used Time:3.155506=20

Sun Oct 19 06:01:53 UTC 2014=20

Used Time:3.134961=20

Sun Oct 19 06:01:56 UTC 2014=20

Used Time:3.135814=20

[root@ceph-test src]# for i in `seq 1 3`; do date && ~/01.rados_write_4=
k_for_each_object /etc/ceph/ceph.conf rbd 5000 && sleep 3; done=20

Sun Oct 19 06:02:03 UTC 2014=20

Used Time:6.536319=20

Sun Oct 19 06:02:10 UTC 2014=20

Used Time:6.648738=20

Sun Oct 19 06:02:16 UTC 2014=20

Used Time:6.585156=20

On Sat, Oct 18, 2014 at 4:37 AM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:=20
> Hi Sage/Haomai,=20
>=20
> I did some 4K Random Read benchmarking with latest master having Asyn=
c messenger changes and result looks promising.=20
>=20
> My configuration:=20
> ---------------------=20
>=20
> 1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg cluster=20
> wide Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, dual socket, HT=
 enabled, 40 cores.=20
> Used krbd as client.=20
>=20
>=20
> 1 clinet node with 3 rbd images on 3 different pools:=20
> -------------------------------------------------------------------=20
> Master :=20
> ---------=20
>=20
> ~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB=20
>=20
> lat (usec) : 4=3D0.01%, 10=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D0.=
03%=20
> lat (usec) : 500=3D0.86%, 750=3D3.72%, 1000=3D7.19%=20
> lat (msec) : 2=3D39.17%, 4=3D41.45%, 10=3D7.26%, 20=3D0.24%, 50=3D0.0=
6%=20
> lat (msec) : 100=3D0.03%, 250=3D0.01%, 500=3D0.01%=20
>=20
> cpu: ~1-2 % idle=20
>=20
> Giant:=20
> ------=20
>=20
> ~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB=20
>=20
> lat (usec) : 250=3D0.01%, 500=3D0.51%, 750=3D2.71%, 1000=3D6.03%=20
> lat (msec) : 2=3D34.32%, 4=3D45.74%, 10=3D10.46%, 20=3D0.21%, 50=3D0.=
02%=20
> lat (msec) : 100=3D0.01%, 250=3D0.01%=20
>=20
> cpu: ~2% idle=20
>=20
> 2 clients with 3 rbd images each on 3 different pools:=20
> -------------------------------------------------------------------=20
>=20
> Master :=20
> ---------=20
>=20
> ~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB=20
>=20
> lat (usec) : 250=3D0.03%, 500=3D0.63%, 750=3D2.67%, 1000=3D5.21%=20
> lat (msec) : 2=3D25.12%, 4=3D36.19%, 10=3D24.80%, 20=3D3.16%, 50=3D1.=
34%=20
> lat (msec) : 100=3D0.66%, 250=3D0.18%, 500=3D0.01%=20
>=20
> cpu: ~0-1 % idle=20
>=20
> Giant:=20
> --------=20
> ~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB=20
>=20
> lat (usec) : 250=3D0.01%, 500=3D0.25%, 750=3D1.47%, 1000=3D3.45%=20
> lat (msec) : 2=3D21.22%, 4=3D36.69%, 10=3D30.63%, 20=3D4.28%, 50=3D1.=
70%=20
> lat (msec) : 100=3D0.28%, 250=3D0.02%, 500=3D0.01%=20
>=20
> cpu: ~1% idle=20
>=20
>=20
> So, in summary the master with Async messenger has improved both in i=
ops and latency.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> ________________________________=20
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html=20



--=20
Best Regards,=20

Wheat=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
