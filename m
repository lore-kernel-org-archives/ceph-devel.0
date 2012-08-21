From: Tommi Virtanen <tv@inktank.com>
Subject: Re: S3 comapatible with java-rados.
Date: Tue, 21 Aug 2012 08:57:44 -0700
Message-ID: <CADvuQREVD5EfDzk5dTFj7tYdDEwboqxy_=ZUB5z+sDZVxrN6Ew@mail.gmail.com>
References: <loom.20120820T091919-196@post.gmane.org> <loom.20120821T072518-665@post.gmane.org>
 <loom.20120821T082125-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58511 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab2HUP6G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 11:58:06 -0400
Received: by vcbfk26 with SMTP id fk26so6274438vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 08:58:05 -0700 (PDT)
In-Reply-To: <loom.20120821T082125-510@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 20, 2012 at 11:25 PM, ramu <ramu.freesystems@gmail.com> wrote:
> Am installing RADOS Gateway from
> $ ./configure --with-radosgw
> $ make install
> It was installed.But After I did the steps from the site is
> "http://ceph.com/docs/master/radosgw/config/"
> In that enable rados gateway configuration it showing the error is,
>
> root@vu-AP480-S:/etc/apache2/sites-enabled# sudo a2ensite rgw.conf
> ERROR: Site rgw.conf does not exist!

You need to create the configuration file, as explained in section
http://ceph.com/docs/master/radosgw/config/#create-rgw-conf of the
documentation.
