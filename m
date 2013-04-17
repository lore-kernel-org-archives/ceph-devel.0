From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 10:33:21 -0700
Message-ID: <CABBk=J-P4KPXqsg7gZQBDvvyiaWHrStyQYx1mLWQ3YGMR0UN0g@mail.gmail.com>
References: <loom.20130417T164538-81@post.gmane.org>
	<CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com>
	<loom.20130417T170632-546@post.gmane.org>
	<CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com>
	<loom.20130417T172954-546@post.gmane.org>
	<CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com>
	<loom.20130417T183106-585@post.gmane.org>
	<CABBk=J9uw5WUcOvkCAuzO2R_nhNmbxzFVFFSQXM5vypVgXAykQ@mail.gmail.com>
	<loom.20130417T185651-134@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:61826 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965409Ab3DQRdW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 13:33:22 -0400
Received: by mail-vc0-f172.google.com with SMTP id gd11so1540157vcb.17
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 10:33:22 -0700 (PDT)
In-Reply-To: <loom.20130417T185651-134@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: proguest <proguest1942@hotmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 17, 2013 at 9:58 AM, proguest <proguest1942@hotmail.com> wrote:
> Yehuda Sadeh <yehuda <at> inktank.com> writes:
>
>>
>> Do you have radosgw logs?
>>
> Here're radosgw log
> The last two line are restart radosgw (2 times)
> Others are trying to connect radosgw..
>
> 2013-04-17 14:58:24.335168 7fdb2af5c700  2 req 1:0.316409:s3:GET
> /s3gw.fcgi:list_bucket:http status=404

I noticed that the example closes and reopens the VirtualHost section.
Can you try the following config (doesn't close and reopens the
section, modified RewriteRule):

FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock


<VirtualHost *:80>
        ServerName {fqdn}
        ServerAdmin {email.address}
        DocumentRoot /var/www

RewriteEngine On
RewriteRule             ^/(.*) /s3gw.fcgi?%{QUERY_STRING}
[E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

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
