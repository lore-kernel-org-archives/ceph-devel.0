From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 3 Sep 2012 03:46:29 -0700
Message-ID: <CAC-hyiESAAtXu2woKQRN6K0U=8PV8LRkMYAozMcD_yq9W9PqUA@mail.gmail.com>
References: <loom.20120903T104858-555@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45523 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2ICKqb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Sep 2012 06:46:31 -0400
Received: by bkwj10 with SMTP id j10so2102151bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 03:46:30 -0700 (PDT)
In-Reply-To: <loom.20120903T104858-555@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 3, 2012 at 1:51 AM, ramu eppa <ramu.freesystems@gmail.com> wrote:
> Hi all,
>    I configured radosgateway through,
> "http://ceph.com/docs/master/radosgw/config/" this documentation.
>
> But after restarting apache2 server,
> it was not starting and it was showing error.
>
> The error is,
> Starting web server apache2.
>
> Syntax error on line 1 of /etc/apache2/sites-enabled/rgw.conf.
>
> FastCgiExternalServer:redefinition of previously defined class
> "/var/www/s3gw.fcgi".

Sounds like you have multiple conflicting configurations. Maybe you
have something else defined on a different config file already?

Yehuda
