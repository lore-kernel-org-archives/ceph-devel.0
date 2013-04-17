From: proguest <proguest1942@hotmail.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 15:13:11 +0000 (UTC)
Message-ID: <loom.20130417T170632-546@post.gmane.org>
References: <loom.20130417T164538-81@post.gmane.org> <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43979 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966615Ab3DQPNZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 11:13:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USU30-0006FE-2A
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 17:13:22 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 17:13:22 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 17:13:22 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

> 
> On Wed, Apr 17, 2013 at 7:54 AM, proguest <proguest1942 <at> hotmail.com> 
wrote:
> > hi,
> > I really need some help for my ceph radosgw.
> > stuck on it for a really long time.
> >
> > I followed by the ceph document
> > http://ceph.com/docs/master/start/quick-rgw/
> >
> > without any error or warnimg.
> >
> > i can even use radosgw-admin to create user successfully.
> >
> > But, I cant get into cephfs neither S3 nor swift.
> >
> > #swift -A http://<radosgw-host>/auth -U <user> -K <key> post test
> >
> > only responded Auth GET failed: http://<radosgw-host>:80 404 Not Found
> >
> > How can I solve this problem...? I really need a help
> >
> 
> Hard to know without additional info. It looks though as you might
> have apache config issues (if you're using apache).
> 
> Yehuda
hi Yehuda

thanks for replied me.
It's only stardard setting with radosgw document.
here's /etc/apache2/httpd.conf  only 1 line

ServerName node74

and here's /etc/apache2/sites-enabled  (just follow the website)

FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
<VirtualHost *:80>
        ServerName node74
        ServerAdmin proguest1942@hotmail.com
        DocumentRoot /var/www
</VirtualHost>

RewriteEngine On
RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*) /s3gw.fcgi?page=$1&params=$2&%
{QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

<VirtualHost *:80>

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

without any other edit.
Also create a fcgi file named s3gw.fcgi in /var/www/
here's s3gw.fcgi

#!/bin/sh
exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gateway

I don't know what's wrong with my radosgw..



