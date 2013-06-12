From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: AW: radosrgw performance problems
Date: Wed, 12 Jun 2013 09:53:21 -0500
Message-ID: <51B88B61.9060305@inktank.com>
References: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag> <51B7365E.1090101@inktank.com> <5EFBD28BA42C604BB012164C72CA560450CBAC50@SMBXKO3.cgm.ag> <5EFBD28BA42C604BB012164C72CA560450CBACE5@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53533 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab3FLOxV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 10:53:21 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so17941502iea.25
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 07:53:21 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA560450CBACE5@SMBXKO3.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?=22J=E4ger=2C_Philipp=22?= <Philipp.Jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Interesting.  Was Apache using excessive CPU?  Do your processors and=20
libraries support AES-NI?  Seems strange that at this level that would=20
be the limiting factor, but I've seen stranger things...  Glad you=20
figured it out!

Mark

On 06/12/2013 05:52 AM, J=E4ger, Philipp wrote:
> Hello,
>
> identified the problem.
>
> When I deactivate SSL in Apache Config, and connect via http, I get t=
he 40MB/s. (with ssl 8mb/s)
> Have you experience with SSL? Is this normal?
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
> [Philipp] We don't use standard pool, new pool with 1500pg, same prob=
lem. (30 osds)
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
>> (I've heard something about the rgw admin socket to check perfcounte=
rs, but it seems that this is deprecated? Because when i type ceph --ad=
min-daemon ... it says unknown command and I cannot find it in the ceph=
 docu. Then i wanted to bench via rest-bench, but it says "ERROR: faile=
d to create bucket: XmlParseFailure -failed initializing benchmark", so=
 I could not bench the speed.)
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
>> log file =3D /var/log/ceph/connect2.log
>> rgw dns name =3D  FQDN
>>
>> Thank you very much.
>>
>>
>> Regards
>>
>> Philipp
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
