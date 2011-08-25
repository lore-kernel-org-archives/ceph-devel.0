From: huang jun <hjwsm1989@gmail.com>
Subject: Fwd: radosgw:s3 create doesn't work
Date: Fri, 26 Aug 2011 00:26:44 +0800
Message-ID: <CABAwU-a5=QeA=sKHpQJAtQbcQOECF=OOP=vut8oX+Q8nr4OUSA@mail.gmail.com>
References: <CABAwU-ZxPeQu1b=EbBjxWeNSn7X7+jOwiywO5hPOnsAxUe0Pvw@mail.gmail.com>
	<CAC-hyiHS4EiR+XYZcm==dYgo0U4MYM0kfj6+KWhNSt2Dk67tMA@mail.gmail.com>
	<CABAwU-Za395xBC_qR4GWN1sBPHgPn+6PShraNa+J1eDwzbbE_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62911 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1HYQ0s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 12:26:48 -0400
Received: by vws1 with SMTP id 1so2129708vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 09:26:47 -0700 (PDT)
In-Reply-To: <CABAwU-Za395xBC_qR4GWN1sBPHgPn+6PShraNa+J1eDwzbbE_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

---------- =D2=D1=D7=AA=B7=A2=D3=CA=BC=FE ----------
=B7=A2=BC=FE=C8=CB=A3=BA huang jun <hjwsm1989@gmail.com>
=C8=D5=C6=DA=A3=BA 2011=C4=EA8=D4=C226=C8=D5 =C9=CF=CE=E712:17
=D6=F7=CC=E2=A3=BA Re: radosgw:s3 create doesn't work
=CA=D5=BC=FE=C8=CB=A3=BA Yehuda Sadeh Weinraub <yehudasa@gmail.com>


i followed the wiki/rados_gateway.
and after i correct this problem, just encountered with another.

httpd.conf file:
=46astCgiWrapper /var/www/s3gw.fcgi
=46astCgiServer /bsd/bin/radosgw

<VirtualHost *:80>
 ServerName s3.bsdocfs.com
 ServerAlias skinny.ops.newdream.net
 DocumentRoot /var/www

 RewriteEngine On
 RewriteRule   ^/([a-zA-Z0-9\-\_\.]*)([/]?.*)
/s3gw.fcgi?page=3D$1&params=3D$2&%{QUERY_STRING}
[E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]

 <IfModule mod_fastcgi.c>
#    SuexecUserGroup web1 web1
   <Directory /var/www/>
       Options +ExecCGI
           AllowOverride All
               SetHandler fastcgi-script
               Order allow,deny
               Allow from all
               AuthBasicAuthoritative Off
       </Directory>
 </IfModule>

       SetEnv RGW_DNS_NAME "s3."

       AllowEncodedSlashes On

       ErrorLog /var/log/apache2/error.log
       CustomLog /var/log/apache2/access.log combined
   ServerSignature Off
</VirtualHost>
/etc/init.d/apache2 restart
 * Restarting web server apache2
apache2: Could not reliably determine the server's fully qualified
domain name, using 192.168.1.102 for ServerName
 ... waiting apache2: Could not reliably determine the server's fully
qualified domain name, using 192.168.1.102 for ServerName
 ...done.
(***anything wrong=A3=BF=A3=BF=A3=BF***)


start ceph cluster
$ /etc/init.d/ceph -a start
everything is ok!

$ vim /etc/hosts
192.168.1.102   s3.amazonaws.com
192.168.1.102   alpha.s3.amazonaws.com

create users:
radosgw_admin -c /etc/ceph/ceph.conf user create
--display-name=3D"chuyunhanzhi" --email=3Dservice_wh@chinfotech.com.cn =
-i
7
User ID: 7
RADOS UID: 0
Keys:
 User: 7
 Access Key: GGWH7X0TGOD2JPBQ07NC
 Secret Key: yWV+FhDDPoO4D21K6R/c2tu5rSorv7lv9/pmzF6f
Users:
Display Name: chuyunhanzhi
Email: service_wh@chinfotech.com.cn
OpenStack User: <undefined>
OpenStack Key: <undefined>

exports S3 parms:
export S3_ACCESS_KEY_ID=3DGGWH7X0TGOD2JPBQ07NC
export S3_SECRET_ACCESS_KEY=3DyWV+FhDDPoO4D21K6R/c2tu5rSorv7lv9/pmzF6f
export S3_HOSTNAME=3Ds3.bsdocfs.com

create bucket=A3=BA
bsd02:~# s3 -u create alpha
ERROR: ErrorUnknown

bsd02:~# s3  create alpha
ERROR: FailedToConnect

so i don't know what wrong with it?


2011/8/25 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Thu, Aug 25, 2011 at 6:51 AM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>> hi,all
>> i try to use radosgw in ceph 0.30.
>> but i always got error in "s3 -u create alpha"
>> steps below:
>> bsd02:/data#ceph -s
>> 2011-08-25 21:47:33.256884    pg v149: 230 pgs: 230
>> active+clean+degraded; 29 KB data, 7868 MB used, 6481 MB / 15118 MB
>> avail; 29/58 degraded (50.000%)
>> 2011-08-25 21:47:33.257330   mds e4: 1/1/1 up {0=3D0=3Dup:active}
>> 2011-08-25 21:47:33.257355   osd e6: 1 osds: 1 up, 1 in
>> 2011-08-25 21:47:33.257399   log 2011-08-25 21:32:26.114013 osd0
>> 192.168.1.102:6801/5163 230 : [INF] 6.7 scrub ok
>> 2011-08-25 21:47:33.257454   mon e1: 1 mons at {0=3D192.168.1.102:67=
89/0}
>>
>> bsd02:/data#  radosgw_admin -m 192.168.1.102:6789 -c
>> /etc/ceph/ceph.conf user create --display-name=3D"chuyunhanzhi"
>> --email=3Dservice_wh@chinfotech.com.cn -i 0
>> User ID: 0
>> RADOS UID: 0
>> Keys:
>>  User: 0
>>  Access Key: 669L0E71AIIGD5GZL4EJ
>>  Secret Key: IwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
>> Users:
>> Display Name: chuyunhanzhi
>> Email: service_wh@chinfotech.com.cn
>> OpenStack User: <undefined>
>> OpenStack Key: <undefined>
>>
>> bsd02:/data# export S3_ACCESS_KEY_ID=3D669L0E71AIIGD5GZL4EJ
>> bsd02:/data# export
>> S3_SECRET_ACCESS_KEY=3DIwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
>> bsd02:/data# export S3_HOSTNAME=3D192.168.1.102
>>
>> bsd02:/data# s3 create alpha
>>
>> ERROR: ErrorInvalidAccessKeyId
>>  Message: The AWS Access Key Id you provided does not exist in our r=
ecords.
>>  Extra Details:
>>    RequestId: 006D8781356B1B00
>>    HostId: d6lXuxT+ospDfgMYayaz7YjTzB5If4Q9s9mkoZno9fgyGe0shHrhfGGv3=
y3WGCAb
>>    AWSAccessKeyId: 669L0E71AIIGD5GZL4EJ
>>
>> and i tried another two times,but the error always occur.
>> so what should i do to avoid this problem?
>
> You're going to Amazon here and get that response from there. Are you
> using the correct s3 utility?
>
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
