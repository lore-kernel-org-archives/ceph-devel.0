From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] man: Update the configuration example for radosgw
Date: Fri, 16 Dec 2011 22:16:51 -0800
Message-ID: <CAC-hyiFuJn8FbfBugsnDbQAb0e-rYU195GRyw1AXTsBnRcRWQQ@mail.gmail.com>
References: <1324069265-19005-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52014 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1LQGQx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Dec 2011 01:16:53 -0500
Received: by yenm11 with SMTP id m11so2676814yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 22:16:52 -0800 (PST)
In-Reply-To: <1324069265-19005-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Thanks, pushed both patches.

Yehuda

On Fri, Dec 16, 2011 at 1:01 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
> =A0man/radosgw.8 | =A0 65 ++++++++++++++++++++++++++++++++++++-------=
--------------
> =A01 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/man/radosgw.8 b/man/radosgw.8
> index 6ae9a9b..3119c57 100644
> --- a/man/radosgw.8
> +++ b/man/radosgw.8
> @@ -59,31 +59,28 @@ Connect to specified monitor (instead of looking =
through
> =A0.B \-\-rgw\-socket\-path=3Dpath
> =A0Specify a unix domain socket path.
> =A0.UNINDENT
> -.SH EXAMPLES
> +.SH CONFIGURATION
> =A0.sp
> -An apache example configuration for using the RADOS gateway:
> +Currently it's the easiest to use the RADOS Gateway with Apache and =
mod_fastcgi
> =A0.sp
> =A0.nf
> =A0.ft C
> +FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
> +
> =A0<VirtualHost *:80>
> =A0 ServerName rgw.example1.com
> =A0 ServerAlias rgw
> =A0 ServerAdmin webmaster@example1.com
> - =A0DocumentRoot /var/www/web1/web/
> + =A0DocumentRoot /var/www
>
> - =A0#turn engine on
> =A0 RewriteEngine On
> -
> - =A0#following is important for RGW/rados
> =A0 RewriteRule ^/([a\-zA\-Z0\-9\-_.]*)([/]?.*) /s3gw.fcgi?page=3D$1&=
params=3D$2&%{QUERY_STRING} [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorizatio=
n},L]
>
> - =A0<IfModule mod_fcgid.c>
> - =A0 =A0SuexecUserGroup web1 web1
> - =A0 =A0<Directory /var/www/web1/web/>
> + =A0<IfModule mod_fastcgi.c>
> + =A0 =A0<Directory /var/www>
> =A0 =A0 =A0 Options +ExecCGI
> =A0 =A0 =A0 AllowOverride All
> - =A0 =A0 =A0SetHandler fcgid\-script
> - =A0 =A0 =A0FCGIWrapper /var/www/fcgi\-scripts/web1/radosgw .fcgi
> + =A0 =A0 =A0SetHandler fastcgi\-script
> =A0 =A0 =A0 Order allow,deny
> =A0 =A0 =A0 Allow from all
> =A0 =A0 =A0 AuthBasicAuthoritative Off
> @@ -91,37 +88,57 @@ An apache example configuration for using the RAD=
OS gateway:
> =A0 </IfModule>
>
> =A0 AllowEncodedSlashes On
> -
> - =A0# ErrorLog /var/log/apache2/error.log
> - =A0# CustomLog /var/log/apache2/access.log combined
> =A0 ServerSignature Off
> -
> =A0</VirtualHost>
> =A0.ft P
> =A0.fi
> =A0.sp
> -And the corresponding radosgw script:
> +And the corresponding radosgw script (/var/www/s3gw.fgci):
> =A0.sp
> =A0.nf
> =A0.ft C
> =A0#!/bin/sh
> -exec /usr/bin/radosgw \-c /etc/ceph.conf
> +exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gatew=
ay
> =A0.ft P
> =A0.fi
> =A0.sp
> -By default radosgw will run as single threaded and its execution wil=
l
> -be controlled by the fastcgi process manager. An alternative way to
> -run it would be by specifying (along the lines of) the following in
> -the apache config:
> +The radosgw daemon is a standalone process which needs a configurati=
on section in the ceph.conf
> +The section name should start with 'client.radosgw.' as specified in=
 /etc/init.d/radosgw
> =A0.sp
> =A0.nf
> =A0.ft C
> -FastCgiExternalServer /var/www/web1/web/s3gw.fcgi \-socket /tmp/.rad=
osgw.sock
> +[client.radosgw.gateway]
> + =A0 =A0host =3D gateway
> + =A0 =A0keyring =3D /etc/ceph/keyring.radosgw.gateway
> + =A0 =A0rgw socket path =3D /tmp/radosgw.sock
> =A0.ft P
> =A0.fi
> =A0.sp
> -and specify a unix domain socket path (either by passing a command
> -line option, or through ceph.conf).
> +You will also have to generate a key for the radosgw to use for auth=
entication with the cluster
> +.sp
> +.nf
> +.ft C
> +ceph-authtool -C -n client.radosgw.gateway --gen-key /etc/ceph/keyri=
ng.radosgw.gateway
> +ceph-authtool -n client.radosgw.gateway --cap mon 'allow r' --cap os=
d 'allow rwx' --cap mds 'allow' /etc/ceph/keyring.radosgw.gateway
> +.ft P
> +.fi
> +.sp
> +And add the key to the auth entries
> +.sp
> +.nf
> +.ft C
> +ceph auth add client.radosgw.gateway --in-file=3Dkeyring.radosgw.gat=
eway
> +.ft P
> +.fi
> +.sp
> +Now you can start Apache and the radosgw daemon
> +.sp
> +.nf
> +.ft C
> +/etc/init.d/apache2 start
> +/etc/init.d/radosgw start
> +.ft P
> +.fi
> =A0.SH AVAILABILITY
> =A0.sp
> =A0\fBradosgw\fP is part of the Ceph distributed file system. Please =
refer
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
