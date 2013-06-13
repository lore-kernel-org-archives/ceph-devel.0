From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: AW: AW: AW: radosrgw performance problems
Date: Thu, 13 Jun 2013 11:04:02 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBB194@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA560450CBAAA4@SMBXKO3.cgm.ag>
 <51B7365E.1090101@inktank.com>
 <5EFBD28BA42C604BB012164C72CA560450CBAC50@SMBXKO3.cgm.ag>
 <5EFBD28BA42C604BB012164C72CA560450CBACE5@SMBXKO3.cgm.ag>
 <51B88B61.9060305@inktank.com>
 <5EFBD28BA42C604BB012164C72CA560450CBADE8@SMBXKO3.cgm.ag>
 <51B8A4F6.2020208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:53403 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3FMLEM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jun 2013 07:04:12 -0400
In-Reply-To: <51B8A4F6.2020208@inktank.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I upload 1 big iso, about 8-9mb/s. So not thousand small files. Cluster=
 is still in a test environment.


Apache config:

=46astCgiExternalServer /var/www/connect2.fcgi -socket /tmp/connect2.so=
ck

<VirtualHost *:443 >
        ServerName foo.cgm.ag
        ServerAlias *.foo.cgm.ag
# hcrgwko2
        ServerAdmin foo
        DocumentRoot /var/www
KeepAlive off
        SSLEngine on
        SSLCertificateFile /etc/apache2/ssl/foo.cert
        SSLCertificateKeyFile /etc/apache2/ssl/foo.key

RewriteEngine On
RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*) /connect2.fcgi?page=3D$1&params=
=3D$2&%{QUERY_STRING} [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]
<IfModule mod_fastcgi.c>
                <Directory /var/www>
                        Options +ExecCGI
                        AllowOverride All
                        SetHandler fastcgi-script
                        Order allow,deny
                        Allow from all
                        AuthBasicAuthoritative Off
                </Directory>
        </IfModule>

        AllowEncodedSlashes On
        ErrorLog /var/log/apache2/error.log
        CustomLog /var/log/apache2/access.log combined
        ServerSignature Off
</VirtualHost>


Thanks

Philipp


-----Urspr=FCngliche Nachricht-----
Von: Mark Nelson [mailto:mark.nelson@inktank.com]=20
Gesendet: Mittwoch, 12. Juni 2013 18:43
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: AW: AW: radosrgw performance problems

I spoke to Yehuda (who develops RGW), and he mentioned that it may be l=
atency due to SSL handshake.  How big are the objects you are writing?

with RBD, I can do much better than 40% of the rados throughput, but it=
 takes a lot of concurrency.  I use fio with libaio, direct=3D1, 4MB wr=
ites, and a high iodepth on multiple volumes to get there.  Btw, rados =
bench by default is going to keep 16 objects in flight too.

Mark

On 06/12/2013 10:14 AM, J=E4ger, Philipp wrote:
> No, not really:
>
> 30239 www-data  20   0  751m 7556 2036 S   10  0.4   0:03.67 apache2
>   1955 root      20   0 2048m  10m 4352 S    6  0.5   2:14.54 radosgw
>
> 10% cpu usage apache, load was 0.4. Also less than 15% usage via vcen=
ter performance graph.
> We are setting up a physical server right now at this moment, because=
 we thought also about missing instruction sets of the cpu.
>
> Another perf question:
>
> As I said we can write about 170mb/s with the rados bench:
> rados bench -p test 100 write:
> Bandwidth (MB/sec):     171.744.
>
> With rbd or rgw (w/o https) we get less than 40mb/s:
> (time rados -p connect put 600mb.iso 600mb.iso
> real    0m15.846s
>   user    0m0.640s
> sys     0m0.836s)
>
> I think you can also close the bug! Because of https I have to type t=
he protocol, and then I get the message "bad protocol"( like here: http=
://tracker.ceph.com/issues/3968 ) , so not possible to bench at the mom=
ent with rest-bench.
>
> Ive configured the admin socket, but I don't know who to "read" the o=
utput of perfcounters in a sensefull way...
>
>
> Thank you very much so far.
>
> Philipp
>
> -----Urspr=FCngliche Nachricht-----
> Von: Mark Nelson [mailto:mark.nelson@inktank.com]
> Gesendet: Mittwoch, 12. Juni 2013 16:53
> An: J=E4ger, Philipp
> Cc: ceph-devel@vger.kernel.org
> Betreff: Re: AW: radosrgw performance problems
>
> Interesting.  Was Apache using excessive CPU?  Do your processors and=
 libraries support AES-NI?  Seems strange that at this level that would=
 be the limiting factor, but I've seen stranger things...  Glad you fig=
ured it out!
>
> Mark
>
> On 06/12/2013 05:52 AM, J=E4ger, Philipp wrote:
>> Hello,
>>
>> identified the problem.
>>
>> When I deactivate SSL in Apache Config, and connect via http, I get=20
>> the 40MB/s. (with ssl 8mb/s) Have you experience with SSL? Is this n=
ormal?
>>
>> Thanks
>>
>> Regards
>>
>>
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von: J=E4ger, Philipp
>> Gesendet: Mittwoch, 12. Juni 2013 10:22
>> An: 'Mark Nelson'
>> Cc: ceph-devel@vger.kernel.org
>> Betreff: AW: radosrgw performance problems
>>
>> Hello,
>>
>> i've added my answers below.
>>
>> Thanks
>>
>> Regards
>>
>> Philipp
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von: Mark Nelson [mailto:mark.nelson@inktank.com]
>> Gesendet: Dienstag, 11. Juni 2013 16:38
>> An: J=E4ger, Philipp
>> Cc: ceph-devel@vger.kernel.org
>> Betreff: Re: radosrgw performance problems
>>
>> On 06/11/2013 08:27 AM, J=E4ger, Philipp wrote:
>>> Hello,
>>>
>>> we have a performance problem with radosrgw.
>>> Only 8mb/s-9 per upload, also tested with s3cmd on the rgw itself.
>>> (2 uploads at the same time: combined 15mb/s, 3 uploads at the same
>>> time: comb. 21mb/s) But when putting a file via rados rbd , we get =
40mb/s upload, so no network or other problem in general.
>>
>> One thing to check is to make sure that the rgw pool you are writing=
 to has enough placement groups for your cluster.  The default may be e=
xtremely low.
>>
>> [Philipp] We don't use standard pool, new pool with 1500pg, same=20
>> problem. (30 osds)
>>
>>>
>>> Same speed with the inktank apache/fastcgi and the original one.
>>> Hardware also fast enough. We use Ubuntu 12.04 lts, ceph 0.61.2
>>>
>>> So have you any idea why the rgw is so slow? How can we identify wh=
ere the problem is?
>>
>> RBD is pretty streamlined so you can get good performance with it.  =
On my test setup I'm seeing 80-90% of the performance of raw rados obje=
ct writes/reads (and in some cases much faster with RBD cache enabled!)=
=2E
>> RGW, Apache, fastcgi, and simply the requirements of supporting the =
S3 protocol itself add a lot of overhead.  MD5 calculations by themselv=
es start chewing up a ton of CPU once you try to support high throughpu=
t scenarios and there is a non-trivial amount of extra latency added as=
 well.  You may be able to improve things with some tweaks, but I would=
n't be surprised if RBD is always going to be faster to an extent.
>>
>> [Philipp]We are talking about 9mb/s per rgw, which is less then 1/4 =
of rbd (rados put: 40mb/s), with the rados bench we get actually: Bandw=
idth (MB/sec):     171.744.
>> So I think we are not talking about tweaking, rather a general probl=
em?
>>
>>
>> For folks who want really fast object storage I think directly utili=
zing rados is probably the way to go, but that requires modifying the a=
pp and it's not for everyone.
>>
>>>
>>> (I've heard something about the rgw admin socket to check=20
>>> perfcounters, but it seems that this is deprecated? Because when i=20
>>> type ceph --admin-daemon ... it says unknown command and I cannot=20
>>> find it in the ceph docu. Then i wanted to bench via rest-bench, bu=
t=20
>>> it says "ERROR: failed to create bucket: XmlParseFailure -failed=20
>>> initializing benchmark", so I could not bench the speed.)
>>
>> connecting with the admin daemon should still be supported.
>> Documentation is here:
>>
>> http://ceph.com/docs/next/radosgw/troubleshooting/
>>
>> If this doesn't work please let me know!
>>
>> [Philipp] How can you activate a rgw admin socket? I think we have t=
o add an entry in the ceph.conf?  The admin socket is not the "rgw sock=
et path" I think?
>>
>>
>> Also, I've created a bug for the rest-bench issue:
>>
>> http://tracker.ceph.com/issues/5302
>>
>> Personally I've been using swift-bench for most of my recent rgw tes=
ting.
>>
>> Mark
>>
>>>
>>> Ceph.conf- rgw part:
>>>
>>> [client.radosgw.connect2]
>>> host =3D hcrgwko2
>>> rgw socket path =3D /tmp/connect2.sock log file =3D=20
>>> /var/log/ceph/connect2.log rgw dns name =3D  FQDN
>>>
>>> Thank you very much.
>>>
>>>
>>> Regards
>>>
>>> Philipp
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
