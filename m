From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: radosrgw performance problems
Date: Tue, 11 Jun 2013 09:38:22 -0500
Message-ID: <51B7365E.1090101@inktank.com>
References: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55936 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3FKOiX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 10:38:23 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so542026iea.4
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jun 2013 07:38:23 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?=22J=E4ger=2C_Philipp=22?= <Philipp.Jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/11/2013 08:27 AM, J=E4ger, Philipp wrote:
> Hello,
>
> we have a performance problem with radosrgw.
> Only 8mb/s-9 per upload, also tested with s3cmd on the rgw itself.
> (2 uploads at the same time: combined 15mb/s, 3 uploads at the same t=
ime: comb. 21mb/s)
> But when putting a file via rados rbd , we get 40mb/s upload, so no n=
etwork or other problem in general.

One thing to check is to make sure that the rgw pool you are writing to=
=20
has enough placement groups for your cluster.  The default may be=20
extremely low.

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
