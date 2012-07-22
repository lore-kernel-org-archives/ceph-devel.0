From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: getting started with RADOSGW
Date: Sun, 22 Jul 2012 07:59:40 -0700
Message-ID: <CAC-hyiGaY6b=3PgY2jANMLM6ALLbe02j9KfWv7vR9JLW5q2XAA@mail.gmail.com>
References: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41066 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2GVO7m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 10:59:42 -0400
Received: by bkwj10 with SMTP id j10so4522844bkw.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 07:59:40 -0700 (PDT)
In-Reply-To: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@jonproulx.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 22, 2012 at 7:43 AM, Jonathan Proulx <jon@jonproulx.com> wrote:
> Hi All,
>
> I've created a testuser with testuser:swift subuser, setup apache with
> fcgi but client access with either S3 or Swift clients result in HTTP
> 500 errors on the server:
>
> [Sun Jul 22 10:14:33 2012] [error] [client 128.52.x.x] (2)No such file
> or directory: FastCGI: failed to connect to server
> "/var/www/s3gw.fcgi": connect() failed
> [Sun Jul 22 10:14:33 2012] [error] [client 128.52.x.x] FastCGI:
> incomplete headers (0 bytes) received from server "/var/www/s3gw.fcgi"
>
>
>  ls -lh /var/www/s3gw.fcgi
> -rwxrwxr-x 1 root root 79 Jul 10 10:28 /var/www/s3gw.fcgi
>
> cat /var/www/s3gw.fcgi
> #!/bin/sh
> exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.rados.gateway
>
> /usr/bin/radosgw is in the right place and executable by all
> /etc/ceph/ceph.conf is also in the correct location and readable by
> all, so I'm a bit confused by the "No such file or directory" error.
>
> I *think* I've followed all the steps but have obviously missed
> something, any idea what?
>
I think you've set up your apache to use external fastcgi, but you
have to run radosgw manually using this method.

Yehuda
