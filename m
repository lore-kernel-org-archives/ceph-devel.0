From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw:s3 create doesn't work
Date: Thu, 25 Aug 2011 11:09:50 -0700
Message-ID: <CAC-hyiFROui5Y0PXZDrcQre1iEz9_BZ96w41YSG7vf0HfXWDbg@mail.gmail.com>
References: <CABAwU-ZxPeQu1b=EbBjxWeNSn7X7+jOwiywO5hPOnsAxUe0Pvw@mail.gmail.com>
	<CAC-hyiHS4EiR+XYZcm==dYgo0U4MYM0kfj6+KWhNSt2Dk67tMA@mail.gmail.com>
	<CABAwU-Za395xBC_qR4GWN1sBPHgPn+6PShraNa+J1eDwzbbE_g@mail.gmail.com>
	<CABAwU-a5=QeA=sKHpQJAtQbcQOECF=OOP=vut8oX+Q8nr4OUSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1HYSJw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 14:09:52 -0400
Received: by bke11 with SMTP id 11so1939025bke.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 11:09:51 -0700 (PDT)
In-Reply-To: <CABAwU-a5=QeA=sKHpQJAtQbcQOECF=OOP=vut8oX+Q8nr4OUSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2011/8/25 huang jun <hjwsm1989@gmail.com>:
> ---------- =D2=D1=D7=AA=B7=A2=D3=CA=BC=FE ----------
> =B7=A2=BC=FE=C8=CB=A3=BA huang jun <hjwsm1989@gmail.com>
> =C8=D5=C6=DA=A3=BA 2011=C4=EA8=D4=C226=C8=D5 =C9=CF=CE=E712:17
> =D6=F7=CC=E2=A3=BA Re: radosgw:s3 create doesn't work
> =CA=D5=BC=FE=C8=CB=A3=BA Yehuda Sadeh Weinraub <yehudasa@gmail.com>
>
>
> i followed the wiki/rados_gateway.
> and after i correct this problem, just encountered with another.
>
> httpd.conf file:
> FastCgiWrapper /var/www/s3gw.fcgi
> FastCgiServer /bsd/bin/radosgw
>
> <VirtualHost *:80>
>  ServerName s3.bsdocfs.com
>  ServerAlias skinny.ops.newdream.net

You probably want to change the ServerAlias.

>  DocumentRoot /var/www
>
>  RewriteEngine On
>  RewriteRule   ^/([a-zA-Z0-9\-\_\.]*)([/]?.*)
> /s3gw.fcgi?page=3D$1&params=3D$2&%{QUERY_STRING}
> [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>
>  <IfModule mod_fastcgi.c>
> #    SuexecUserGroup web1 web1
>   <Directory /var/www/>
>       Options +ExecCGI
>           AllowOverride All
>               SetHandler fastcgi-script
>               Order allow,deny
>               Allow from all
>               AuthBasicAuthoritative Off
>       </Directory>
>  </IfModule>
>
>       SetEnv RGW_DNS_NAME "s3."
>
>       AllowEncodedSlashes On
>
>       ErrorLog /var/log/apache2/error.log
>       CustomLog /var/log/apache2/access.log combined
>   ServerSignature Off
> </VirtualHost>
> /etc/init.d/apache2 restart
>  * Restarting web server apache2
> apache2: Could not reliably determine the server's fully qualified
> domain name, using 192.168.1.102 for ServerName
>  ... waiting apache2: Could not reliably determine the server's fully
> qualified domain name, using 192.168.1.102 for ServerName
>  ...done.
> (***anything wrong=A3=BF=A3=BF=A3=BF***)
>
>
> start ceph cluster
> $ /etc/init.d/ceph -a start
> everything is ok!
>
> $ vim /etc/hosts
> 192.168.1.102   s3.amazonaws.com
> 192.168.1.102   alpha.s3.amazonaws.com
>
> create users:
> radosgw_admin -c /etc/ceph/ceph.conf user create
> --display-name=3D"chuyunhanzhi" --email=3Dservice_wh@chinfotech.com.c=
n -i
> 7
> User ID: 7
> RADOS UID: 0
> Keys:
>  User: 7
>  Access Key: GGWH7X0TGOD2JPBQ07NC
>  Secret Key: yWV+FhDDPoO4D21K6R/c2tu5rSorv7lv9/pmzF6f
> Users:
> Display Name: chuyunhanzhi
> Email: service_wh@chinfotech.com.cn
> OpenStack User: <undefined>
> OpenStack Key: <undefined>
>
> exports S3 parms:
> export S3_ACCESS_KEY_ID=3DGGWH7X0TGOD2JPBQ07NC
> export S3_SECRET_ACCESS_KEY=3DyWV+FhDDPoO4D21K6R/c2tu5rSorv7lv9/pmzF6=
f
> export S3_HOSTNAME=3Ds3.bsdocfs.com
>
> create bucket=A3=BA
> bsd02:~# s3 -u create alpha
> ERROR: ErrorUnknown

We'll need to have the apache and radosgw logs for that. By any chance
you were running the radosgw off the latest git? There was a short
lived bug that got every operation to fail in the same manner.

>
> bsd02:~# s3  create alpha
> ERROR: FailedToConnect

You don't have https configure, so that wouldn't work.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
