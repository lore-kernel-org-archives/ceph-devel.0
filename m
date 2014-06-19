From: Milosz Tanski <milosz@adfin.com>
Subject: Re: CEPH IOPS Baseline Measurements with MemStore
Date: Thu, 19 Jun 2014 18:18:28 -0400
Message-ID: <CANP1eJFs76SAkoG99OH+hSo6dPg=02XbTRr7FBegGJ6a=fEhkA@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7433ED@CERNXCHG44.cern.ch>
	<a6e515c2-9c71-42b7-9140-1d66f95f2977@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58098 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaFSWS3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 18:18:29 -0400
Received: by mail-wi0-f174.google.com with SMTP id bs8so10110609wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jun 2014 15:18:28 -0700 (PDT)
In-Reply-To: <a6e515c2-9c71-42b7-9140-1d66f95f2977@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

Alexandre,

There was a gentleman on this list before who identified a few
possible locking issues in the ceph osd deamon. Here is a thread
original thread.
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/19284. He
performed some really back hacks (like just dropping mutexes) which
one shouldn't do... but it turned out that he was able to get 3 to 4
performance improvement.

If you're willing to do a lock contention trace (using mutrace, or
something similar) I'd be really interested in the results of it. The
results should be especially useful if you're running it against
MemStore since it'll take away any thing that would prevent these
bottleneck from showing up (like disk access).

Best,
- Milosz

On Thu, Jun 19, 2014 at 7:08 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>I am not sure if it is actually possible to disable completely all l=
og messages. I did this for benchmarking at compile time changing the l=
ogging macro in common/dout.h =3D=3D> #define dout_impl(cct, sub, v) ..=
=2E.
>
> I think it can be done in ceph.conf
> https://ceph.com/docs/master/rados/troubleshooting/log-and-debug/#sub=
system-log-and-debug-settings
>
> I remember an old mail from stefan priebe from 2012, reporting also a=
 performance decrease with logging
>
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09976.html
>
> with a cpu trace here:
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09974/out.=
pdf
>
>
> ceph.conf to disable them was:
>
> debug lockdep =3D 0/0
> debug context =3D 0/0
> debug crush =3D 0/0
> debug buffer =3D 0/0
> debug timer =3D 0/0
> debug journaler =3D 0/0
> debug osd =3D 0/0
> debug optracker =3D 0/0
> debug objclass =3D 0/0
> debug filestore =3D 0/0
> debug journal =3D 0/0
> debug ms =3D 0/0
> debug monc =3D 0/0
> debug tp =3D 0/0
> debug auth =3D 0/0
> debug finisher =3D 0/0
> debug heartbeatmap =3D 0/0
> debug perfcounter =3D 0/0
> debug asok =3D 0/0
> debug throttle =3D 0/0
>
>
>
> ----- Mail original -----
>
> De: "Andreas Joachim Peters" <Andreas.Joachim.Peters@cern.ch>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Jeudi 19 Juin 2014 11:29:27
> Objet: RE: CEPH IOPS Baseline Measurements with MemStore
>
> I am not sure if it is actually possible to disable completely all lo=
g messages. I did this for benchmarking at compile time changing the lo=
gging macro in common/dout.h =3D=3D> #define dout_impl(cct, sub, v) ...=
=2E
>
> I changed 'osd op threads' but that had no visible impact.
>
> Cheers Andreas.
>
> ________________________________________
> From: Alexandre DERUMIER [aderumier@odiso.com]
> Sent: 19 June 2014 11:21
> To: Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: CEPH IOPS Baseline Measurements with MemStore
>
> Hi,
>
> Thanks for your benchmark !
>
>>>If you have some ideas for parameters to tune or see some mistakes i=
n this measurement - let me know!
>
>>>1) Default Logging has an important impact on the IOPS & latency [0.=
1-0.2ms]
> how do you enable|disable stats ? (ceph.conf)
>
>
>>>2) OSD implementation without journaling does not scale linear with =
concurrent IOs - need several OSDs to scale IOPS - lock contention/thre=
ading model?
> It's quite possible, I have see a lot of benchmark with ssd, and osd =
daemon was always the bottleneck, more osd more scale.
>
>>>3) a writing OSD never fills more than 4 cores
>>>4) a reading OSD never fills more than 5 cores
>
> maybe "osd op threads" could improve this ?
> default is 2 (don't known if with hyperthreading it's going on 4cores=
 instead 2 ?)
>
>
> ----- Mail original -----
>
> De: "Andreas Joachim Peters" <Andreas.Joachim.Peters@cern.ch>
> =C3=80: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Jeudi 19 Juin 2014 11:05:18
> Objet: CEPH IOPS Baseline Measurements with MemStore
>
> Hi,
>
> I made some benchmarks/testing using the firefly branch and GCC 4.9. =
Hardware is 2 CPUs with 6-core Intel(R) Xeon(R) CPU E5-2630L 0 @ 2.00GH=
z with Hyperthreading and 256 GB of memory (kernel 2.6.32-431.17.1.el6.=
x86_64).
>
> In my tests I run two OSD configurations on a single box:
>
> [A] 4 OSDs running with MemStore
> [B] 1 OSD running with MemStore
>
> I use a pool with 'size=3D1' and read and read/write 1-byte objects a=
ll via localhost.
>
> The local RTT reported by ping is 15 micro seconds, the RTT measured =
with ZMQ is 100 micro seconds (10 kHZ synchronous 1-byte messages).
> RTT measured with another file IO daemon (XRootD) we are using at CER=
N (31-byte messages) is 9.9 kHZ.
>
> ---------------------------------------------------------------------=
----------------------------------------------------
> 4 OSDs
> ---------------------------------------------------------------------=
----------------------------------------------------
>
> {1} [A]
> *******
> I measure IOPS with 1 byte objects for separate write and read operat=
ions disabling logging of any subsystem:
>
> Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Write : 01.7 : 0.50 : 1
> Write: 11.2 : 0.88 : 10
> Write: 11.8 : 1.69 : 10 x 2 [ 2 rados bench processes ]
> Write: 11.2 : 3.57 : 10 x 4 [ 4 rados bench processes ]
> Read : 02.6 : 0.33 : 1
> Read : 22.4 : 0.43 : 10
> Read : 40.0 : 0.97 : 20 x 2 [ 2 rados bench processes ]
> Read : 46.0 : 0.88 : 10 x 4 [ 4 rados bench processes ]
> Read : 40.0 : 1.60 : 20 x 4 [ 4 rados bench processes ]
>
> {2} [A]
> *******
> I measure IOPS with the CEPH firefly branch as is (default logging) :
>
> Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Write : 01.2 : 0.78 : 1
> Write : 09.1 : 1.00 : 10
> Read : 01.8 : 0.50 : 1
> Read : 14.0 : 1.00 : 10
> Read : 18:0 : 2.00 : 20 x 2 [ 2 rados bench processes ]
> Read : 18.0 : 2.20 : 10 x 4 [ 4 rados bench processes ]
>
> ---------------------------------------------------------------------=
----------------------------------------------------
> 1 OSD
> ---------------------------------------------------------------------=
----------------------------------------------------
>
> {1} [B] (subsys logging disabled, 1 OSD)
> *******
> Write : 02.0 : 0.46 : 1
> Write : 10.0 : 0.95 : 10
> Write : 11.1 : 1.74 : 20
> Write : 12.0 : 1.80 : 10 x 2 [ 2 rados bench processes ]
> Write : 10.8 : 3.60 : 10 x 4 [ 4 rados bench processes ]
> Read : 03.6 : 0.27 : 1
> Read : 16.9 : 0.50 : 10
> Read : 28.0 : 0.70 : 10 x 2 [ 2 rados bench processes ]
> Read : 29.6 : 1.37 : 20 x 2 [ 2 rados bench processes ]
> Read : 27.2 : 1.50 : 10 x 4 [ 4 rados bench processes ]
>
> {2} [B] (defaultlogging, 1 OSD)
> *******
> Write : 01.4 : 0.68 : 1
> Write : 04.0 : 2.35 : 10
> Write : 04.0 : 4.69 : 10 x 2 [ 2 rados bench processes ]
>
> I also played with OSD thread number (no change) and used an in memor=
y filesystem + journaling (filestore backend). Here the{1} [A] result i=
s 1.4 kHz write for 1 IOPS in flight and the peak write performance put=
ting many IOPS in flight and several rados bench processes is 2.3 kHz!
>
>
> Some summarizing remarks:
>
> 1) Default Logging has an important impact on the IOPS & latency [0.1=
-0.2ms]
> 2) OSD implementation without journaling does not scale linear with c=
oncurrent IOs - need several OSDs to scale IOPS - lock contention/threa=
ding model?
> 3) a writing OSD never fills more than 4 cores
> 4) a reading OSD never fills more than 5 cores
> 5) running 'rados bench' on a remote machine gives similar or slghltl=
y worse results (upto -20%)
> 6) CEPH delivering 20k read IOPS uses 4 cores on server side, while i=
dentical operations with higher payload (XRootD) uses one core for 3x h=
igher performance (60k IOPS)
> 7) I can scale the other IO daemon (XRootD) to use 10 cores and to de=
liver 300.000 IOPS on the same box.
>
> Looking forward to SSDs and volatile memory backend stores I see some=
 improvements to be done in the OSD/communication layer.
>
> If you have some ideas for parameters to tune or see some mistakes in=
 this measurement - let me know!
>
> Cheers Andreas.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
