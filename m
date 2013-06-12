From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: AW: AW: radosrgw performance problems
Date: Wed, 12 Jun 2013 15:14:34 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBADE8@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
 <51B7365E.1090101@inktank.com>
 <5EFBD28BA42C604BB012164C72CA560450CBAC50@SMBXKO3.cgm.ag>
 <5EFBD28BA42C604BB012164C72CA560450CBACE5@SMBXKO3.cgm.ag>
 <51B88B61.9060305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:51417 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3FLPOq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 11:14:46 -0400
In-Reply-To: <51B88B61.9060305@inktank.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

No, not really:

30239 www-data  20   0  751m 7556 2036 S   10  0.4   0:03.67 apache2
 1955 root      20   0 2048m  10m 4352 S    6  0.5   2:14.54 radosgw

10% cpu usage apache, load was 0.4. Also less than 15% usage via vcente=
r performance graph.
We are setting up a physical server right now at this moment, because w=
e thought also about missing instruction sets of the cpu.

Another perf question:

As I said we can write about 170mb/s with the rados bench:
rados bench -p test 100 write:
Bandwidth (MB/sec):     171.744.

With rbd or rgw (w/o https) we get less than 40mb/s:
(time rados -p connect put 600mb.iso 600mb.iso
real    0m15.846s
 user    0m0.640s
sys     0m0.836s)

I think you can also close the bug! Because of https I have to type the=
 protocol, and then I get the message "bad protocol"( like here: http:/=
/tracker.ceph.com/issues/3968 ) , so not possible to bench at the momen=
t with rest-bench.

Ive configured the admin socket, but I don't know who to "read" the out=
put of perfcounters in a sensefull way...


Thank you very much so far.

Philipp

-----Urspr=FCngliche Nachricht-----
Von: Mark Nelson [mailto:mark.nelson@inktank.com]=20
Gesendet: Mittwoch, 12. Juni 2013 16:53
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: AW: radosrgw performance problems

Interesting.  Was Apache using excessive CPU?  Do your processors and l=
ibraries support AES-NI?  Seems strange that at this level that would b=
e the limiting factor, but I've seen stranger things...  Glad you figur=
ed it out!

Mark

On 06/12/2013 05:52 AM, J=E4ger, Philipp wrote:
> Hello,
>
> identified the problem.
>
> When I deactivate SSL in Apache Config, and connect via http, I get=20
> the 40MB/s. (with ssl 8mb/s) Have you experience with SSL? Is this no=
rmal?
>
> Thanks
>
> Regards
>
>
>
> -----Urspr=FCngliche Nachricht-----
> Von: J=E4ger, Philipp
> Gesendet: Mittwoch, 12. Juni 2013 10:22
> An: 'Mark Nelson'
> Cc: ceph-devel@vger.kernel.org
> Betreff: AW: radosrgw performance problems
>
> Hello,
>
> i've added my answers below.
>
> Thanks
>
> Regards
>
> Philipp
>
> -----Urspr=FCngliche Nachricht-----
> Von: Mark Nelson [mailto:mark.nelson@inktank.com]
> Gesendet: Dienstag, 11. Juni 2013 16:38
> An: J=E4ger, Philipp
> Cc: ceph-devel@vger.kernel.org
> Betreff: Re: radosrgw performance problems
>
> On 06/11/2013 08:27 AM, J=E4ger, Philipp wrote:
>> Hello,
>>
>> we have a performance problem with radosrgw.
>> Only 8mb/s-9 per upload, also tested with s3cmd on the rgw itself.
>> (2 uploads at the same time: combined 15mb/s, 3 uploads at the same
>> time: comb. 21mb/s) But when putting a file via rados rbd , we get 4=
0mb/s upload, so no network or other problem in general.
>
> One thing to check is to make sure that the rgw pool you are writing =
to has enough placement groups for your cluster.  The default may be ex=
tremely low.
>
> [Philipp] We don't use standard pool, new pool with 1500pg, same=20
> problem. (30 osds)
>
>>
>> Same speed with the inktank apache/fastcgi and the original one.
>> Hardware also fast enough. We use Ubuntu 12.04 lts, ceph 0.61.2
>>
>> So have you any idea why the rgw is so slow? How can we identify whe=
re the problem is?
>
> RBD is pretty streamlined so you can get good performance with it.  O=
n my test setup I'm seeing 80-90% of the performance of raw rados objec=
t writes/reads (and in some cases much faster with RBD cache enabled!).
> RGW, Apache, fastcgi, and simply the requirements of supporting the S=
3 protocol itself add a lot of overhead.  MD5 calculations by themselve=
s start chewing up a ton of CPU once you try to support high throughput=
 scenarios and there is a non-trivial amount of extra latency added as =
well.  You may be able to improve things with some tweaks, but I wouldn=
't be surprised if RBD is always going to be faster to an extent.
>
> [Philipp]We are talking about 9mb/s per rgw, which is less then 1/4 o=
f rbd (rados put: 40mb/s), with the rados bench we get actually: Bandwi=
dth (MB/sec):     171.744.
> So I think we are not talking about tweaking, rather a general proble=
m?
>
>
> For folks who want really fast object storage I think directly utiliz=
ing rados is probably the way to go, but that requires modifying the ap=
p and it's not for everyone.
>
>>
>> (I've heard something about the rgw admin socket to check=20
>> perfcounters, but it seems that this is deprecated? Because when i=20
>> type ceph --admin-daemon ... it says unknown command and I cannot=20
>> find it in the ceph docu. Then i wanted to bench via rest-bench, but=
=20
>> it says "ERROR: failed to create bucket: XmlParseFailure -failed=20
>> initializing benchmark", so I could not bench the speed.)
>
> connecting with the admin daemon should still be supported.
> Documentation is here:
>
> http://ceph.com/docs/next/radosgw/troubleshooting/
>
> If this doesn't work please let me know!
>
> [Philipp] How can you activate a rgw admin socket? I think we have to=
 add an entry in the ceph.conf?  The admin socket is not the "rgw socke=
t path" I think?
>
>
> Also, I've created a bug for the rest-bench issue:
>
> http://tracker.ceph.com/issues/5302
>
> Personally I've been using swift-bench for most of my recent rgw test=
ing.
>
> Mark
>
>>
>> Ceph.conf- rgw part:
>>
>> [client.radosgw.connect2]
>> host =3D hcrgwko2
>> rgw socket path =3D /tmp/connect2.sock
>> log file =3D /var/log/ceph/connect2.log rgw dns name =3D  FQDN
>>
>> Thank you very much.
>>
>>
>> Regards
>>
>> Philipp
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
