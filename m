From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 08:20:16 -0700
Message-ID: <CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com>
References: <loom.20130417T164538-81@post.gmane.org>
	<CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com>
	<loom.20130417T170632-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43059 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab3DQPUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 11:20:16 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so2059057ieb.31
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 08:20:16 -0700 (PDT)
In-Reply-To: <loom.20130417T170632-546@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: proguest <proguest1942@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 17, 2013 at 8:13 AM, proguest <proguest1942@hotmail.com> wrote:
> Yehuda Sadeh <yehuda <at> inktank.com> writes:
>
>>
>> On Wed, Apr 17, 2013 at 7:54 AM, proguest <proguest1942 <at> hotmail.com>
> wrote:
>> > hi,
>> > I really need some help for my ceph radosgw.
>> > stuck on it for a really long time.
>> >
>> > I followed by the ceph document
>> > http://ceph.com/docs/master/start/quick-rgw/
>> >
>> > without any error or warnimg.
>> >
>> > i can even use radosgw-admin to create user successfully.
>> >
>> > But, I cant get into cephfs neither S3 nor swift.
>> >
>> > #swift -A http://<radosgw-host>/auth -U <user> -K <key> post test
>> >
>> > only responded Auth GET failed: http://<radosgw-host>:80 404 Not Found
>> >
>> > How can I solve this problem...? I really need a help
>> >
>>
>> Hard to know without additional info. It looks though as you might
>> have apache config issues (if you're using apache).
>>
>> Yehuda
> hi Yehuda
>
> thanks for replied me.
> It's only stardard setting with radosgw document.
> here's /etc/apache2/httpd.conf  only 1 line
>
> ServerName node74
>
> and here's /etc/apache2/sites-enabled  (just follow the website)

is that the actual file name, or is that the directory where this
config file resides? do you have by any chance another default web
site set up under sites-enabled? did you restart apache after
configuring?

>
> FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
> <VirtualHost *:80>
>         ServerName node74
>         ServerAdmin proguest1942@hotmail.com
>         DocumentRoot /var/www
> </VirtualHost>
>
> RewriteEngine On
> RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*) /s3gw.fcgi?page=$1&params=$2&%
> {QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>
> <VirtualHost *:80>
>
>         <IfModule mod_fastcgi.c>
>                 <Directory /var/www>
>                         Options +ExecCGI
>                         AllowOverride All
>                         SetHandler fastcgi-script
>                         Order allow,deny
>                         Allow from all
>                         AuthBasicAuthoritative Off
>                 </Directory>
>         </IfModule>
>
>         AllowEncodedSlashes On
>         ErrorLog /var/log/apache2/error.log
>         CustomLog /var/log/apache2/access.log combined
>         ServerSignature Off
> </VirtualHost>
>
> without any other edit.
> Also create a fcgi file named s3gw.fcgi in /var/www/
> here's s3gw.fcgi
>
> #!/bin/sh
> exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gateway
>
> I don't know what's wrong with my radosgw..
>
>
