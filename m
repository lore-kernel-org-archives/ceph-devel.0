From: <ghislain.chevalier@orange.com>
Subject: RE: Issue with radosgw in Ubuntu 13.10/emperor/fcgid
Date: Fri, 14 Mar 2014 10:39:37 +0000
Message-ID: <2779_1394793578_5322DC6A_2779_14428_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D58B2@PEXCVZYM14.corporate.adroot.infra.ftgroup>
References: <29593_1394708284_53218F3C_29593_6617_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D51E5@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CABBk=J8BEfo0JomU1Km00_nz+T6JtXSj3DaM+t4FYj7O5BG89g@mail.gmail.com>
	<3199_1394729307_5321E15B_3199_7525_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D53EA@PEXCVZYM14.corporate.adroot.infra.ftgroup>
 <CABBk=J9JfioyT0Acgc0vP60_UK3o86a7DVQo9j3Px+pyjY6Hcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias245.francetelecom.com ([80.12.204.245]:52948 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbaCNKjl convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Mar 2014 06:39:41 -0400
In-Reply-To: <CABBk=J9JfioyT0Acgc0vP60_UK3o86a7DVQo9j3Px+pyjY6Hcw@mail.gmail.com>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I set the --debug-rgw=3D20 parameter and it shows that the log is
2014-03-13 18:11:58.748840 7f24475d17c0  0 ceph version 0.72.2 (a913ded=
2ff138aefb8cb84d347d72164099cfd60), process radosgw, pid 20791
2014-03-13 18:11:58.765029 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:11:58.766251 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:default.region state=3D0x14724a8 s->prefetch_data=3D=
0
2014-03-13 18:11:58.766305 7f24475d17c0 10 cache get: name=3D.rgw.root+=
default.region : miss
2014-03-13 18:11:58.769856 7f24475d17c0 10 cache put: name=3D.rgw.root+=
default.region
2014-03-13 18:11:58.769889 7f24475d17c0 10 adding .rgw.root+default.reg=
ion to cache LRU end
2014-03-13 18:11:58.769904 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.769923 7f24475d17c0 10 moving .rgw.root+default.reg=
ion to cache LRU end
2014-03-13 18:11:58.769931 7f24475d17c0 10 cache get: name=3D.rgw.root+=
default.region : type miss (requested=3D1, cached=3D6)
2014-03-13 18:11:58.769946 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:default.region state=3D0x1476698 s->prefetch_data=3D=
0
2014-03-13 18:11:58.769955 7f24475d17c0 10 moving .rgw.root+default.reg=
ion to cache LRU end
2014-03-13 18:11:58.769957 7f24475d17c0 10 cache get: name=3D.rgw.root+=
default.region : hit
2014-03-13 18:11:58.769963 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.769970 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:default.region state=3D0x1476698 s->prefetch_data=3D=
0
2014-03-13 18:11:58.769973 7f24475d17c0 20 state for obj=3D.rgw.root:de=
fault.region is not atomic, not appending atomic test
2014-03-13 18:11:58.769976 7f24475d17c0 20 rados->read obj-ofs=3D0 read=
_ofs=3D0 read_len=3D524288
2014-03-13 18:11:58.771629 7f24475d17c0 20 rados->read r=3D0 bl.length=3D=
17
2014-03-13 18:11:58.771692 7f24475d17c0 10 cache put: name=3D.rgw.root+=
default.region
2014-03-13 18:11:58.771696 7f24475d17c0 10 moving .rgw.root+default.reg=
ion to cache LRU end
2014-03-13 18:11:58.771741 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:region_info.default state=3D0x1477158 s->prefetch_d=
ata=3D0
2014-03-13 18:11:58.771754 7f24475d17c0 10 cache get: name=3D.rgw.root+=
region_info.default : miss
2014-03-13 18:11:58.773429 7f24475d17c0 10 cache put: name=3D.rgw.root+=
region_info.default
2014-03-13 18:11:58.773451 7f24475d17c0 10 adding .rgw.root+region_info=
=2Edefault to cache LRU end
2014-03-13 18:11:58.773461 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.773473 7f24475d17c0 10 moving .rgw.root+region_info=
=2Edefault to cache LRU end
2014-03-13 18:11:58.773476 7f24475d17c0 10 cache get: name=3D.rgw.root+=
region_info.default : type miss (requested=3D1, cached=3D6)
2014-03-13 18:11:58.773487 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:region_info.default state=3D0x1477158 s->prefetch_d=
ata=3D0
2014-03-13 18:11:58.773494 7f24475d17c0 10 moving .rgw.root+region_info=
=2Edefault to cache LRU end
2014-03-13 18:11:58.773496 7f24475d17c0 10 cache get: name=3D.rgw.root+=
region_info.default : hit
2014-03-13 18:11:58.773502 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.773505 7f24475d17c0 20 get_obj_state: rctx=3D0x146e=
b10 obj=3D.rgw.root:region_info.default state=3D0x1477158 s->prefetch_d=
ata=3D0
2014-03-13 18:11:58.773509 7f24475d17c0 20 state for obj=3D.rgw.root:re=
gion_info.default is not atomic, not appending atomic test
2014-03-13 18:11:58.773513 7f24475d17c0 20 rados->read obj-ofs=3D0 read=
_ofs=3D0 read_len=3D524288
2014-03-13 18:11:58.774936 7f24475d17c0 20 rados->read r=3D0 bl.length=3D=
145
2014-03-13 18:11:58.774993 7f24475d17c0 10 cache put: name=3D.rgw.root+=
region_info.default
2014-03-13 18:11:58.774997 7f24475d17c0 10 moving .rgw.root+region_info=
=2Edefault to cache LRU end
2014-03-13 18:11:58.775068 7f24475d17c0 20 get_obj_state: rctx=3D0x1477=
290 obj=3D.rgw.root:zone_info.default state=3D0x1479788 s->prefetch_dat=
a=3D0
2014-03-13 18:11:58.775081 7f24475d17c0 10 cache get: name=3D.rgw.root+=
zone_info.default : miss
2014-03-13 18:11:58.778538 7f24475d17c0 10 cache put: name=3D.rgw.root+=
zone_info.default
2014-03-13 18:11:58.778561 7f24475d17c0 10 adding .rgw.root+zone_info.d=
efault to cache LRU end
2014-03-13 18:11:58.778570 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.778582 7f24475d17c0 10 moving .rgw.root+zone_info.d=
efault to cache LRU end
2014-03-13 18:11:58.778585 7f24475d17c0 10 cache get: name=3D.rgw.root+=
zone_info.default : type miss (requested=3D1, cached=3D6)
2014-03-13 18:11:58.778594 7f24475d17c0 20 get_obj_state: rctx=3D0x1477=
290 obj=3D.rgw.root:zone_info.default state=3D0x147b088 s->prefetch_dat=
a=3D0
2014-03-13 18:11:58.778602 7f24475d17c0 10 moving .rgw.root+zone_info.d=
efault to cache LRU end
2014-03-13 18:11:58.778604 7f24475d17c0 10 cache get: name=3D.rgw.root+=
zone_info.default : hit
2014-03-13 18:11:58.778610 7f24475d17c0 20 get_obj_state: s->obj_tag wa=
s set empty
2014-03-13 18:11:58.778624 7f24475d17c0 20 get_obj_state: rctx=3D0x1477=
290 obj=3D.rgw.root:zone_info.default state=3D0x147b088 s->prefetch_dat=
a=3D0
2014-03-13 18:11:58.778628 7f24475d17c0 20 state for obj=3D.rgw.root:zo=
ne_info.default is not atomic, not appending atomic test
2014-03-13 18:11:58.778631 7f24475d17c0 20 rados->read obj-ofs=3D0 read=
_ofs=3D0 read_len=3D524288
2014-03-13 18:11:58.780169 7f24475d17c0 20 rados->read r=3D0 bl.length=3D=
616
2014-03-13 18:11:58.780223 7f24475d17c0 10 cache put: name=3D.rgw.root+=
zone_info.default
2014-03-13 18:11:58.780228 7f24475d17c0 10 moving .rgw.root+zone_info.d=
efault to cache LRU end
2014-03-13 18:11:58.780274 7f24475d17c0  2 zone default is master
2014-03-13 18:11:58.780307 7f24475d17c0 20 get_obj_state: rctx=3D0x147c=
630 obj=3D.rgw.root:region_map state=3D0x147cc18 s->prefetch_data=3D0
2014-03-13 18:11:58.780319 7f24475d17c0 10 cache get: name=3D.rgw.root+=
region_map : miss
2014-03-13 18:11:58.781868 7f24475d17c0 10 cache put: name=3D.rgw.root+=
region_map
2014-03-13 18:11:58.781893 7f24475d17c0 10 adding .rgw.root+region_map =
to cache LRU end
2014-03-13 18:11:58.905504 7f2434ff2700  2 garbage collection: start
2014-03-13 18:11:58.909290 7f24475d17c0 10 allocated request req=3D0x14=
8f620
2014-03-13 18:11:59.467781 7f2434ff2700  2 garbage collection: stop
2014-03-13 18:12:20.765198 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:12:42.765317 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:13:04.765448 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:13:26.765544 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:13:48.765675 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:14:10.765799 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:14:32.765916 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:14:54.766026 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:15:16.766115 7f2435ffb700  2 RGWDataChangesLog::ChangesRe=
newThread: start
2014-03-13 18:15:30.304899 7f23f7fff700  1 handle_sigterm
2014-03-13 18:15:30.304968 7f23f7fff700  1 handle_sigterm set alarm for=
 120
2014-03-13 18:15:30.304999 7f23f7fff700  1 handle_sigterm
2014-03-13 18:15:30.305111 7f24475d17c0  0 ERROR: FCGX_Accept_r returne=
d -4
2014-03-13 18:15:30.312083 7f24475d17c0 -1 shutting down
2014-03-13 18:15:30.485996 7f24475d17c0  1 final shutdown

But there is nothing logged when I send a http request..
I agree that it's a communication issue btw apache/fcgi and the radosgw=
 process

So I decided to remove apache2 from the server and to reinstall it with=
 fastcgi.

AND IT WORKS for swift and s3 requests.

Thx a lot for your support...

-----Message d'origine-----
De=A0: Yehuda Sadeh [mailto:yehuda@inktank.com]=20
Envoy=E9=A0: jeudi 13 mars 2014 18:09
=C0=A0: CHEVALIER Ghislain IMT/OLPS
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: [Ceph-devel] Issue with radosgw in Ubuntu 13.10/emperor/f=
cgid

On Thu, Mar 13, 2014 at 9:48 AM,  <ghislain.chevalier@orange.com> wrote=
:
> Hi Yehuda,
>
> and thx for answering quickly...
>
> I suppose you want me to add --debug_ms 20 in the radosgw command.
> Was it right?

Nope. Just --debug-rgw=3D20.

> Or is it an entry (not documented) in the ceph.conf: rgw_debug =3D 20=
?
>
> I trapped some exchanges btw the rasdosgw server and all the osd serv=
ers but it's very verbose...
>
> 2014-03-13 17:02:38.625252 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 reaper deleted pipe 0x7f5f4c006230
> 2014-03-13 17:02:38.625257 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 reaper reaping pipe 0x13efb00 10.194.182.58:6800/4728
> 2014-03-13 17:02:38.625264 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 >> 10.194.182.58:6800/4728 pipe(0x13efb00 sd=3D13 :36491 s=3D4 pgs=3D1=
32 cs=3D1 l=3D1 c=3D0x13ef580).discard_queue
> 2014-03-13 17:02:38.625273 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 >> 10.194.182.58:6800/4728 pipe(0x13efb00 sd=3D13 :36491 s=3D4 pgs=3D1=
32 cs=3D1 l=3D1 c=3D0x13ef580).unregister_pipe - not registered
> 2014-03-13 17:02:38.625282 7f5fa96177c0 20 -- 10.194.182.60:0/1019860=
 >> 10.194.182.58:6800/4728 pipe(0x13efb00 sd=3D13 :36491 s=3D4 pgs=3D1=
32 cs=3D1 l=3D1 c=3D0x13ef580).join
> 2014-03-13 17:02:38.625299 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 reaper reaped pipe 0x13efb00 10.194.182.58:6800/4728
> 2014-03-13 17:02:38.625308 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 reaper deleted pipe 0x13efb00
> 2014-03-13 17:02:38.625313 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 reaper reaping pipe 0x13e44d0 10.194.182.43:6789/0
> 2014-03-13 17:02:38.625319 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 >> 10.194.182.43:6789/0 pipe(0x13e44d0 sd=3D9 :60694 s=3D4 pgs=3D165 c=
s=3D1 l=3D1 c=3D0x13e4730).discard_queue
> 2014-03-13 17:02:38.625328 7f5fa96177c0 10 -- 10.194.182.60:0/1019860=
 >> 10.194.182.43:6789/0 pipe(0x13e44d0 sd=3D9 :60694 s=3D4 pgs=3D165 c=
s=3D1 l=3D1 c=3D0x13e4730).unregister_pipe - not registered
> 2014-03-13 17:02:38.625336 7f5fa96177c0 20 -- 10.194.182.60:0/1019860=
 >> 10.194.182.43:6789/0 pipe(0x13e44d0 sd=3D9 :60694 s=3D4 pgs=3D165 c=
s=3D1 l=3D1 c=3D0x13e4730).join
>
> The reason I'm using fcgid is that fastcgi is not available in Ubuntu=
 13.10 (maybe I'm wrong!!)
>

I don't think that's correct.

> What I didn't understand is
> why I got as many radosgw processes as launched http requests? socket=
 issue?

Probably because apache wasn't able to communicate with the radosgw
process so it just spawned another process.

> why I got a script header error in the error.log meaning that the scr=
ipt is launched?

Because it could not communicate with the radosgw backend.

>
> I set the log level to debug in apache and I got
>
> [Thu Mar 13 17:15:56.071467 2014] [authz_core:debug] [pid 20351:tid 1=
40472486065920] mod_authz_core.c(802): [client 10.194.182.60:44440] AH0=
1626: authorization result of Require all granted: granted
> [Thu Mar 13 17:15:56.071558 2014] [authz_core:debug] [pid 20351:tid 1=
40472486065920] mod_authz_core.c(802): [client 10.194.182.60:44440] AH0=
1626: authorization result of <RequireAny>: granted
> [Thu Mar 13 17:15:56.072527 2014] [fcgid:info] [pid 20350:tid 1404725=
80695936] mod_fcgid: server r-cephrgw01:/usr/local/bin/radosgw(20415) s=
tarted
> [Thu Mar 13 17:15:56.090184 2014] [fcgid:warn] [pid 20351:tid 1404724=
86065920] (104)Connection reset by peer: [client 10.194.182.60:44440] m=
od_fcgid: error reading data from FastCGI server
> [Thu Mar 13 17:15:56.090247 2014] [core:error] [pid 20351:tid 1404724=
86065920] [client 10.194.182.60:44440] End of script output before head=
ers: radosgw.fcgi
> [Thu Mar 13 17:16:02.078648 2014] [fcgid:info] [pid 20350:tid 1404725=
80695936] mod_fcgid: process /usr/local/bin/radosgw(20415) exit(communi=
cation error), terminated by calling exit(), return code: 0
>
> Best Regards
>
>
> -----Message d'origine-----
> De : Yehuda Sadeh [mailto:yehuda@inktank.com]
> Envoy=E9 : jeudi 13 mars 2014 16:19
> =C0 : CHEVALIER Ghislain IMT/OLPS
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: [Ceph-devel] Issue with radosgw in Ubuntu 13.10/emperor/f=
cgid
>
> On Thu, Mar 13, 2014 at 3:58 AM,  <ghislain.chevalier@orange.com> wro=
te:
>>
>> Hi All,
>>
>> I currently try to install a radosgw/emperor on a dedicated server u=
nder Ubuntu 13.10
>> This server is an exception in the cluster which is in Emperor under=
 Ubuntu 12.04 LTS
>>
>> The apache2 and radosgw installation seem to be correct; I created a=
 S3 user with a swift subuser but I get an error 500 trying to use it.
>> I use fcgid module instead of fastcgi and so the configuration is qu=
ite different.
>> FYI : I installed a radosgw/dumpling/fastcgi on another platform and=
 it works well !!
>>
>> In radosgw log, I got no errors.
>> In apache2 error log, I got
>> [Thu Mar 13 11:38:15.584859 2014] [fcgid:warn] [pid 15279:tid 140016=
017676032] (104)Connection reset by peer: [client 10.194.182.60:43871] =
mod_fcgid: error reading data from FastCGI server
>> [Thu Mar 13 11:38:15.584953 2014] [core:error] [pid 15279:tid 140016=
017676032] [client 10.194.182.60:43871] End of script output before hea=
ders: radosgw.fcgi
>>
>> I noticed that a radosgw script is launched at every http request...
>
> Yeah, that  could be one of the issues with fcgid, not sure if there'=
s
> a way to tell it to just be static (as we do with mod_fastcgi), any
> reason why you're using fcgid?
>
> A 500 response usually means that apache was not able to communicate
> with the radosgw backend. Not sure what the issue with your config, i=
t
> has been a while since I configured fcgid. Try bumping up the radosgw
> logs (debug rgw =3D 20) to see if the requests do get there or not.
>
>
> Yehuda
>
>> I hope someone will find what is wrong in my configuration!!!
>>
>> Here are my configuration files.
>>
>> rgw.conf:
>> <VirtualHost *:88>
>> ServerName  r-cephrgw01
>> DocumentRoot /var/www
>> <IfModule mod_rewrite.c>
>> RewriteEngine On
>> RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*) /radosgw.fcgi?page=3D$1&para=
ms=3D$2&%{QUERY_STRING} [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L=
]
>> </IfModule>
>> <IfModule mod_fcgid.c>
>> <Directory /var/www>
>> Options +ExecCGI
>> AllowOverride All
>> SetHandler fcgid-script
>> FcgidWrapper "/usr/local/bin/radosgw -n client.radosgw.r-cephrgw01" =
=2Efcgi virtual
>> Order allow,deny
>> Allow from all
>> AuthBasicAuthoritative Off
>> </Directory>
>> </IfModule>
>> AllowEncodedSlashes On
>> ServerSignature Off
>> </VirtualHost>
>>
>>
>> ceph.conf:
>> [client.radosgw.r-cephrgw01]
>> host =3D r-cephrgw01
>> rgw_socket_path =3D /var/run/ceph/radosgw.sock
>> keyring =3D /etc/ceph/keyring.radosgw.r-cephrgw01
>> rgw_dns_name =3D r-cephrgw01
>> log_file =3D /var/log/ceph/radosgw.log
>> rgw_port =3D 88
>> rgw_print_continue =3D false
>> user =3D www-data
>>
>> radosgw.fcgi:
>> #!/bin/sh
>> exec /usr/local/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw=
=2Er-cephrgw01
>>
>>
>> User johndoe in radosgw:
>> radosgw-admin user info --uid=3Djohndoe
>> { "user_id": "johndoe",
>>   "display_name": "John Doe",
>>   "email": "john@example.com",
>>   "suspended": 0,
>>   "max_buckets": 1000,
>>   "auid": 0,
>>   "subusers": [
>>         { "id": "johndoe:swift",
>>           "permissions": "full-control"}],
>>   "keys": [
>>         { "user": "johndoe",
>>           "access_key": "s3johndoe",
>>           "secret_key": "s3secret"}],
>>   "swift_keys": [
>>         { "user": "johndoe:swift",
>>           "secret_key": "swsecret"}],
>>   "caps": [],
>>   "op_mask": "read, write, delete",
>>   "default_placement": "",
>>   "placement_tags": [],
>>   "bucket_quota": { "enabled": false,
>>       "max_size_kb": -1,
>>       "max_objects": -1}}
>>
>>
>> ceph auth list for radosgw client
>> client.radosgw.r-cephrgw01
>>         key: AQAvdwdTwMSvGxAAsctezTxARKVVq9sWsUmAPg=3D=3D
>>         caps: [mon] allow rw
>>         caps: [osd] allow rwx
>>
>> - - - - - - - - - - - - - - - - -
>> Ghislain Chevalier
>> ORANGE/OLNC/OLPS/ASE/DAPI/CSE
>> Storage Service Architect
>>  +33299124432
>> ghislain.chevalier@orange.com
>>
>> ____________________________________________________________________=
_____________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations c=
onfidentielles ou privilegiees et ne doivent donc
>> pas etre diffuses, exploites ou copies sans autorisation. Si vous av=
ez recu ce message par erreur, veuillez le signaler
>> a l'expediteur et le detruire ainsi que les pieces jointes. Les mess=
ages electroniques etant susceptibles d'alteration,
>> Orange decline toute responsabilite si ce message a ete altere, defo=
rme ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or privile=
ged information that may be protected by law;
>> they should not be distributed, used or copied without authorisation=
=2E
>> If you have received this email in error, please notify the sender a=
nd delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that hav=
e been modified, changed or falsified.
>> Thank you.
>>
>
> _____________________________________________________________________=
____________________________________________________
>
> Ce message et ses pieces jointes peuvent contenir des informations co=
nfidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous ave=
z recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messa=
ges electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, defor=
me ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileg=
ed information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>

_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
