From: Alfredo Deza <adeza@redhat.com>
Subject: Re: two tarballs for ceph 10.0.1
Date: Fri, 8 Jan 2016 06:58:06 -0500
Message-ID: <CAC-Np1x9nNX71eRj46MokpXbzLj9kyNF=VN729L=gxJmX9T8cw@mail.gmail.com>
References: <CALqRxCzYFNfzhd4fR8J0ytM+yW6eHegciDQ8Lj6d7i1OP2wViA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35156 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbcAHL6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jan 2016 06:58:07 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so132268288wmf.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jan 2016 03:58:07 -0800 (PST)
In-Reply-To: <CALqRxCzYFNfzhd4fR8J0ytM+yW6eHegciDQ8Lj6d7i1OP2wViA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is certainly perplexing. I am not sure how we managed to get
something like that. The correct tarball is the one closer
to 10MB.

Fortunately, we do keep these things around in our binary API service
so it is an easy fix.

Thanks for spotting this

On Thu, Jan 7, 2016 at 11:23 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> In http://download.ceph.com/tarballs/ , there's two tarballs:
> "ceph_10.0.1.orig.tar.gz" and "ceph_10.0.1.orig.tar.gz.1"
>
> Which one is correct? Can we delete one?
>
> - Ken
