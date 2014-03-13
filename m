From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Issue with radosgw in Ubuntu 13.10/emperor/fcgid
Date: Thu, 13 Mar 2014 10:09:12 -0700
Message-ID: <CABBk=J9JfioyT0Acgc0vP60_UK3o86a7DVQo9j3Px+pyjY6Hcw@mail.gmail.com>
References: <29593_1394708284_53218F3C_29593_6617_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D51E5@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CABBk=J8BEfo0JomU1Km00_nz+T6JtXSj3DaM+t4FYj7O5BG89g@mail.gmail.com>
	<3199_1394729307_5321E15B_3199_7525_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D53EA@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:35036 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbaCMRJN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Mar 2014 13:09:13 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so1385091veb.25
        for <ceph-devel@vger.kernel.org>; Thu, 13 Mar 2014 10:09:12 -0700 (PDT)
In-Reply-To: <3199_1394729307_5321E15B_3199_7525_1_B9C8EFBF13B1354DB5FA000660D66DD00C0D53EA@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
