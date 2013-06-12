From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: AW: radosrgw performance problems
Date: Wed, 12 Jun 2013 08:22:12 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBAC50@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
 <51B7365E.1090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:42943 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab3FLIWZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 04:22:25 -0400
In-Reply-To: <51B7365E.1090101@inktank.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i've added my answers below.

Thanks

Regards

Philipp

-----Urspr=FCngliche Nachricht-----
Von: Mark Nelson [mailto:mark.nelson@inktank.com]=20
Gesendet: Dienstag, 11. Juni 2013 16:38
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: radosrgw performance problems

On 06/11/2013 08:27 AM, J=E4ger, Philipp wrote:
> Hello,
>
> we have a performance problem with radosrgw.
> Only 8mb/s-9 per upload, also tested with s3cmd on the rgw itself.
> (2 uploads at the same time: combined 15mb/s, 3 uploads at the same=20
> time: comb. 21mb/s) But when putting a file via rados rbd , we get 40=
mb/s upload, so no network or other problem in general.

One thing to check is to make sure that the rgw pool you are writing to=
 has enough placement groups for your cluster.  The default may be extr=
emely low.

[Philipp] We don't use standard pool, new pool with 1500pg, same proble=
m. (30 osds)=20

>
> Same speed with the inktank apache/fastcgi and the original one. Hard=
ware also fast enough. We use Ubuntu 12.04 lts, ceph 0.61.2
>
> So have you any idea why the rgw is so slow? How can we identify wher=
e the problem is?

RBD is pretty streamlined so you can get good performance with it.  On=20
my test setup I'm seeing 80-90% of the performance of raw rados object=20
writes/reads (and in some cases much faster with RBD cache enabled!).=20
RGW, Apache, fastcgi, and simply the requirements of supporting the S3=20
protocol itself add a lot of overhead.  MD5 calculations by themselves=20
start chewing up a ton of CPU once you try to support high throughput=20
scenarios and there is a non-trivial amount of extra latency added as=20
well.  You may be able to improve things with some tweaks, but I=20
wouldn't be surprised if RBD is always going to be faster to an extent.

[Philipp]We are talking about 9mb/s per rgw, which is less then 1/4 of =
rbd (rados put: 40mb/s), with the rados bench we get actually: Bandwidt=
h (MB/sec):     171.744.
So I think we are not talking about tweaking, rather a general problem?


=46or folks who want really fast object storage I think directly utiliz=
ing=20
rados is probably the way to go, but that requires modifying the app an=
d=20
it's not for everyone.

>
> (I've heard something about the rgw admin socket to check perfcounter=
s, but it seems that this is deprecated? Because when i type ceph --adm=
in-daemon ... it says unknown command and I cannot find it in the ceph =
docu. Then i wanted to bench via rest-bench, but it says "ERROR: failed=
 to create bucket: XmlParseFailure -failed initializing benchmark", so =
I could not bench the speed.)

connecting with the admin daemon should still be supported.=20
Documentation is here:

http://ceph.com/docs/next/radosgw/troubleshooting/

If this doesn't work please let me know!

[Philipp] How can you activate a rgw admin socket? I think we have to a=
dd an entry in the ceph.conf?  The admin socket is not the "rgw socket =
path" I think?


Also, I've created a bug for the rest-bench issue:

http://tracker.ceph.com/issues/5302

Personally I've been using swift-bench for most of my recent rgw testin=
g.

Mark

>
> Ceph.conf- rgw part:
>
> [client.radosgw.connect2]
> host =3D hcrgwko2
> rgw socket path =3D /tmp/connect2.sock
> log file =3D /var/log/ceph/connect2.log
> rgw dns name =3D  FQDN
>
> Thank you very much.
>
>
> Regards
>
> Philipp
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
