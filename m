From: proguest <proguest1942@hotmail.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 18:02:05 +0000 (UTC)
Message-ID: <loom.20130417T194925-931@post.gmane.org>
References: <loom.20130417T164538-81@post.gmane.org> <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com> <loom.20130417T170632-546@post.gmane.org> <CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com> <loom.20130417T172954-546@post.gmane.org> <CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com> <loom.20130417T183106-585@post.gmane.org> <CABBk=J9uw5WUcOvkCAuzO2R_nhNmbxzFVFFSQXM5vypVgXAykQ@mail.gmail.com> <loom.20130417T185651-134@post.gmane.org> <CABBk=J-P4KPXqsg7gZQBDvvyiaWHrStyQYx1mLWQ3YGMR0UN0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38230 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935915Ab3DQSCX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 14:02:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USWgU-0000iZ-8w
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 20:02:18 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 20:02:18 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 20:02:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

> 
> On Wed, Apr 17, 2013 at 9:58 AM, proguest <proguest1942 <at> hotmail.com> 
wrote:
> > Yehuda Sadeh <yehuda <at> inktank.com> writes:
> >
> >>
> >> Do you have radosgw logs?
> >>
> > Here're radosgw log
> > The last two line are restart radosgw (2 times)
> > Others are trying to connect radosgw..
> >
> > 2013-04-17 14:58:24.335168 7fdb2af5c700  2 req 1:0.316409:s3:GET
> > /s3gw.fcgi:list_bucket:http status=404
> 
> I noticed that the example closes and reopens the VirtualHost section.
> Can you try the following config (doesn't close and reopens the
> section, modified RewriteRule):
> 
> FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
> 
> <VirtualHost *:80>
>         ServerName {fqdn}
>         ServerAdmin {email.address}
>         DocumentRoot /var/www
> 
> RewriteEngine On
> RewriteRule             ^/(.*) /s3gw.fcgi?%{QUERY_STRING}
> [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
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

woo, it seems work!!

but there're another problem...

i tried:
# curl -H "X-Auth-User: richard:swift" -H "X-Auth-Key: 
IlEOJlX08uuvXb\/\/xIhz5bLaDGIZmOV0oPSjB2eD" http://node74/auth

it resposed:
<?xml version="1.0" encoding="UTF-8"?><Error><Code>AccessDenied</Code>
</Error>

but here's my user info
{ "user_id": "richard",
  "rados_uid": 0,
  "display_name": "richard",
  "email": "richardchang@lsalab.cd.nthu.edu.tw",
  "suspended": 0,
  "max_buckets": 1000,
  "subusers": [
        { "id": "richard:swift",
          "permissions": "full-control"}],
  "keys": [
        { "user": "richard",
          "access_key": "OCDVLF6P4QGWIZP3Q7CF",
          "secret_key": "IlEOJlX08uuvXb\/\/xIhz5bLaDGIZmOV0oPSjB2eD"}],
  "swift_keys": [
        { "user": "richard:swift",
          "secret_key": "ojS\/KYsrUWnOmyJPREOBkwS26NqQl5tI9f7un28t"}]}

Am I choose the wrong key??







