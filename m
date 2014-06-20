From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: CEPH IOPS Baseline Measurements with MemStore
Date: Fri, 20 Jun 2014 06:35:12 +0200 (CEST)
Message-ID: <36031eee-ed15-448d-8f84-ae940f627dbc@mailpro>
References: <CANP1eJFs76SAkoG99OH+hSo6dPg=02XbTRr7FBegGJ6a=fEhkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44524 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaFTEfW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 00:35:22 -0400
In-Reply-To: <CANP1eJFs76SAkoG99OH+hSo6dPg=02XbTRr7FBegGJ6a=fEhkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

>>There was a gentleman on this list before who identified a few=20
>>possible locking issues in the ceph osd deamon. Here is a thread=20
>>original thread.=20
>>http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/19284. H=
e=20
>>performed some really back hacks (like just dropping mutexes) which=20
>>one shouldn't do... but it turned out that he was able to get 3 to 4=20
>>performance improvement.=20
Yes, I remember of this post, the 4 bottleneck was:

1. fdcache_lock
2. lfn_find in omap_* methods
3. DBObjectMap header
4. fdcache size, slow lookup=20



>>If you're willing to do a lock contention trace (using mutrace, or
>>something similar) I'd be really interested in the results of it. The
>>results should be especially useful if you're running it against
>>MemStore since it'll take away any thing that would prevent these
>>bottleneck from showing up (like disk access).

I'll build a new ceph test storage soon, so I think I can try to help.

But I'm not an expert in process tracing, so help/howto is welcome.

----- Mail original -----=20

De: "Milosz Tanski" <milosz@adfin.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Andreas Joachim Peters" <Andreas.Joachim.Peters@cern.ch>, "ceph-de=
vel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 20 Juin 2014 00:18:28=20
Objet: Re: CEPH IOPS Baseline Measurements with MemStore=20

Alexandre,=20

There was a gentleman on this list before who identified a few=20
possible locking issues in the ceph osd deamon. Here is a thread=20
original thread.=20
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/19284. He=20
performed some really back hacks (like just dropping mutexes) which=20
one shouldn't do... but it turned out that he was able to get 3 to 4=20
performance improvement.=20

If you're willing to do a lock contention trace (using mutrace, or=20
something similar) I'd be really interested in the results of it. The=20
results should be especially useful if you're running it against=20
MemStore since it'll take away any thing that would prevent these=20
bottleneck from showing up (like disk access).=20

Best,=20
- Milosz=20

On Thu, Jun 19, 2014 at 7:08 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:=20
>>>I am not sure if it is actually possible to disable completely all l=
og messages. I did this for benchmarking at compile time changing the l=
ogging macro in common/dout.h =3D=3D> #define dout_impl(cct, sub, v) ..=
=2E.=20
>=20
> I think it can be done in ceph.conf=20
> https://ceph.com/docs/master/rados/troubleshooting/log-and-debug/#sub=
system-log-and-debug-settings=20
>=20
> I remember an old mail from stefan priebe from 2012, reporting also a=
 performance decrease with logging=20
>=20
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09976.html=
=20
>=20
> with a cpu trace here:=20
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09974/out.=
pdf=20
>=20
>=20
> ceph.conf to disable them was:=20
>=20
> debug lockdep =3D 0/0=20
> debug context =3D 0/0=20
> debug crush =3D 0/0=20
> debug buffer =3D 0/0=20
> debug timer =3D 0/0=20
> debug journaler =3D 0/0=20
> debug osd =3D 0/0=20
> debug optracker =3D 0/0=20
> debug objclass =3D 0/0=20
> debug filestore =3D 0/0=20
> debug journal =3D 0/0=20
> debug ms =3D 0/0=20
> debug monc =3D 0/0=20
> debug tp =3D 0/0=20
> debug auth =3D 0/0=20
> debug finisher =3D 0/0=20
> debug heartbeatmap =3D 0/0=20
> debug perfcounter =3D 0/0=20
> debug asok =3D 0/0=20
> debug throttle =3D 0/0=20
>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Andreas Joachim Peters" <Andreas.Joachim.Peters@cern.ch>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Jeudi 19 Juin 2014 11:29:27=20
> Objet: RE: CEPH IOPS Baseline Measurements with MemStore=20
>=20
> I am not sure if it is actually possible to disable completely all lo=
g messages. I did this for benchmarking at compile time changing the lo=
gging macro in common/dout.h =3D=3D> #define dout_impl(cct, sub, v) ...=
=2E=20
>=20
> I changed 'osd op threads' but that had no visible impact.=20
>=20
> Cheers Andreas.=20
>=20
> ________________________________________=20
> From: Alexandre DERUMIER [aderumier@odiso.com]=20
> Sent: 19 June 2014 11:21=20
> To: Andreas Joachim Peters=20
> Cc: ceph-devel@vger.kernel.org=20
> Subject: Re: CEPH IOPS Baseline Measurements with MemStore=20
>=20
> Hi,=20
>=20
> Thanks for your benchmark !=20
>=20
>>>If you have some ideas for parameters to tune or see some mistakes i=
n this measurement - let me know!=20
>=20
>>>1) Default Logging has an important impact on the IOPS & latency [0.=
1-0.2ms]=20
> how do you enable|disable stats ? (ceph.conf)=20
>=20
>=20
>>>2) OSD implementation without journaling does not scale linear with =
concurrent IOs - need several OSDs to scale IOPS - lock contention/thre=
ading model?=20
> It's quite possible, I have see a lot of benchmark with ssd, and osd =
daemon was always the bottleneck, more osd more scale.=20
>=20
>>>3) a writing OSD never fills more than 4 cores=20
>>>4) a reading OSD never fills more than 5 cores=20
>=20
> maybe "osd op threads" could improve this ?=20
> default is 2 (don't known if with hyperthreading it's going on 4cores=
 instead 2 ?)=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Andreas Joachim Peters" <Andreas.Joachim.Peters@cern.ch>=20
> =C3=80: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Jeudi 19 Juin 2014 11:05:18=20
> Objet: CEPH IOPS Baseline Measurements with MemStore=20
>=20
> Hi,=20
>=20
> I made some benchmarks/testing using the firefly branch and GCC 4.9. =
Hardware is 2 CPUs with 6-core Intel(R) Xeon(R) CPU E5-2630L 0 @ 2.00GH=
z with Hyperthreading and 256 GB of memory (kernel 2.6.32-431.17.1.el6.=
x86_64).=20
>=20
> In my tests I run two OSD configurations on a single box:=20
>=20
> [A] 4 OSDs running with MemStore=20
> [B] 1 OSD running with MemStore=20
>=20
> I use a pool with 'size=3D1' and read and read/write 1-byte objects a=
ll via localhost.=20
>=20
> The local RTT reported by ping is 15 micro seconds, the RTT measured =
with ZMQ is 100 micro seconds (10 kHZ synchronous 1-byte messages).=20
> RTT measured with another file IO daemon (XRootD) we are using at CER=
N (31-byte messages) is 9.9 kHZ.=20
>=20
> ---------------------------------------------------------------------=
----------------------------------------------------=20
> 4 OSDs=20
> ---------------------------------------------------------------------=
----------------------------------------------------=20
>=20
> {1} [A]=20
> *******=20
> I measure IOPS with 1 byte objects for separate write and read operat=
ions disabling logging of any subsystem:=20
>=20
> Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> Write : 01.7 : 0.50 : 1=20
> Write: 11.2 : 0.88 : 10=20
> Write: 11.8 : 1.69 : 10 x 2 [ 2 rados bench processes ]=20
> Write: 11.2 : 3.57 : 10 x 4 [ 4 rados bench processes ]=20
> Read : 02.6 : 0.33 : 1=20
> Read : 22.4 : 0.43 : 10=20
> Read : 40.0 : 0.97 : 20 x 2 [ 2 rados bench processes ]=20
> Read : 46.0 : 0.88 : 10 x 4 [ 4 rados bench processes ]=20
> Read : 40.0 : 1.60 : 20 x 4 [ 4 rados bench processes ]=20
>=20
> {2} [A]=20
> *******=20
> I measure IOPS with the CEPH firefly branch as is (default logging) :=
=20
>=20
> Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> Write : 01.2 : 0.78 : 1=20
> Write : 09.1 : 1.00 : 10=20
> Read : 01.8 : 0.50 : 1=20
> Read : 14.0 : 1.00 : 10=20
> Read : 18:0 : 2.00 : 20 x 2 [ 2 rados bench processes ]=20
> Read : 18.0 : 2.20 : 10 x 4 [ 4 rados bench processes ]=20
>=20
> ---------------------------------------------------------------------=
----------------------------------------------------=20
> 1 OSD=20
> ---------------------------------------------------------------------=
----------------------------------------------------=20
>=20
> {1} [B] (subsys logging disabled, 1 OSD)=20
> *******=20
> Write : 02.0 : 0.46 : 1=20
> Write : 10.0 : 0.95 : 10=20
> Write : 11.1 : 1.74 : 20=20
> Write : 12.0 : 1.80 : 10 x 2 [ 2 rados bench processes ]=20
> Write : 10.8 : 3.60 : 10 x 4 [ 4 rados bench processes ]=20
> Read : 03.6 : 0.27 : 1=20
> Read : 16.9 : 0.50 : 10=20
> Read : 28.0 : 0.70 : 10 x 2 [ 2 rados bench processes ]=20
> Read : 29.6 : 1.37 : 20 x 2 [ 2 rados bench processes ]=20
> Read : 27.2 : 1.50 : 10 x 4 [ 4 rados bench processes ]=20
>=20
> {2} [B] (defaultlogging, 1 OSD)=20
> *******=20
> Write : 01.4 : 0.68 : 1=20
> Write : 04.0 : 2.35 : 10=20
> Write : 04.0 : 4.69 : 10 x 2 [ 2 rados bench processes ]=20
>=20
> I also played with OSD thread number (no change) and used an in memor=
y filesystem + journaling (filestore backend). Here the{1} [A] result i=
s 1.4 kHz write for 1 IOPS in flight and the peak write performance put=
ting many IOPS in flight and several rados bench processes is 2.3 kHz!=20
>=20
>=20
> Some summarizing remarks:=20
>=20
> 1) Default Logging has an important impact on the IOPS & latency [0.1=
-0.2ms]=20
> 2) OSD implementation without journaling does not scale linear with c=
oncurrent IOs - need several OSDs to scale IOPS - lock contention/threa=
ding model?=20
> 3) a writing OSD never fills more than 4 cores=20
> 4) a reading OSD never fills more than 5 cores=20
> 5) running 'rados bench' on a remote machine gives similar or slghltl=
y worse results (upto -20%)=20
> 6) CEPH delivering 20k read IOPS uses 4 cores on server side, while i=
dentical operations with higher payload (XRootD) uses one core for 3x h=
igher performance (60k IOPS)=20
> 7) I can scale the other IO daemon (XRootD) to use 10 cores and to de=
liver 300.000 IOPS on the same box.=20
>=20
> Looking forward to SSDs and volatile memory backend stores I see some=
 improvements to be done in the OSD/communication layer.=20
>=20
> If you have some ideas for parameters to tune or see some mistakes in=
 this measurement - let me know!=20
>=20
> Cheers Andreas.=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Milosz Tanski=20
CTO=20
16 East 34th Street, 15th floor=20
New York, NY 10016=20

p: 646-253-9055=20
e: milosz@adfin.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
