From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 3 Sep 2012 21:08:21 -0700
Message-ID: <CAC-hyiGqcK5WhCJKPxnnJ67VNUFYbxq=-W_b60wNv+LeGZHQqw@mail.gmail.com>
References: <loom.20120903T104858-555@post.gmane.org>
	<CAC-hyiESAAtXu2woKQRN6K0U=8PV8LRkMYAozMcD_yq9W9PqUA@mail.gmail.com>
	<loom.20120903T145424-592@post.gmane.org>
	<504473FC02000099000E9622@collaborate.seakr.com>
	<loom.20120904T055945-878@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58551 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab2IDEIW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 00:08:22 -0400
Received: by bkwj10 with SMTP id j10so2429741bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 21:08:21 -0700 (PDT)
In-Reply-To: <loom.20120904T055945-878@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 3, 2012 at 9:02 PM, ramu eppa <ramu.freesystems@gmail.com> wrote:
> Hi,
>
> This is the FastcgiExternalServer status in apache2,
>
> grep -RIs "FastCgiExternalServer" /etc/apache2
>
> /etc/apache2/httpd.conf:FastCgiExternalServer /var/www/s3gw.fcgi -socket
> /tmp/radosgw.sock

Remove this one (/etc/apache2/httpd.conf).

> /etc/apache2/sites-available/rgw.conf:FastCgiExternalServer /var/www/s3gw.fcgi -
> socket /tmp/radosgw.sock
> /etc/apache2/sites-enabled/rgw.conf:FastCgiExternalServer /var/www/s3gw.fcgi -
> socket /tmp/radosgw.sock
>
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
