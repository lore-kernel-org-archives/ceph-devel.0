From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: using radosgw with mod_proxy_fcgi
Date: Wed, 11 Feb 2015 20:10:28 -0500 (EST)
Message-ID: <211191187.4180548.1423703428235.JavaMail.zimbra@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:38899 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbBLBKc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 20:10:32 -0500
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Deneau <tom.deneau@amd.com>
Cc: ceph-devel@vger.kernel.org



----- Original Message -----
> From: "Tom Deneau" <tom.deneau@amd.com>
> To: ceph-devel@vger.kernel.org
> Sent: Wednesday, February 11, 2015 4:21:46 PM
> Subject: using radosgw with mod_proxy_fcgi
> 
> I am a Ceph novice and have the rados and rbd setups working and would like
> to use the radosgw stack.
> 
> I am running on a platform (aarch64) for which there are no pre-built
> binaries of the ceph patched apache and the ceph patched mod_fastcgi.  But
> since I gather from the mail lists that the future is just to use
> mod_proxy_fcgi and since my apache install has mod_proxy_fcgi build in
> already that seems like the way to go.
> 
> I realize the documentation to explain exactly how to set things up with
> mod_proxy_fcgi is still in the works but if there is any preliminary
> documentation on this, I'd be glad to try it out.
> 

That's the apache site config that I was using:

<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    LogLevel debug


    RewriteEngine On

    RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

    # RewriteRule ^/(.*) /?%{QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

    SetEnv proxy-nokeepalive 1

    ProxyPass / fcgi://127.0.01:9000/
    #ProxyPass / unix:///tmp/.radosgw.sock|fcgi://localhost:9000/
</VirtualHost>

Note that there are two options here, and it really depends your apache version. For vanilla apache 2.4.8+ (or maybe 2.4.7+) you can use the regular unix domain socket setup (as described in the docs), just modify the path appropriately. For older apaches (2.4.0+) you need to use tcp for fastcgi, and that requires somewhat different rgw configuration, e.g. have the following in your ceph.conf:

        rgw frontends = fastcgi socket_port=9000 socket_host=0.0.0.0

For apache 2.2 there's no mod-proxy-fcgi out of the box. I did backport that module, and you can find it here: https://github.com/ceph/mod-proxy-fcgi, but you'll need to compile it yourself at this point.

Note that mod-proxy-fcgi does not support 100-continue, so you'll need to add the following to your ceph.conf:

        rgw print continue = false

Yehuda


