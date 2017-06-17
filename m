From: John Spray <jspray@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Sat, 17 Jun 2017 18:52:06 +0100
Message-ID: <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33528 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdFQRw2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jun 2017 13:52:28 -0400
Received: by mail-wr0-f176.google.com with SMTP id r103so52600078wrb.0
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jun 2017 10:52:27 -0700 (PDT)
In-Reply-To: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jun 17, 2017 at 11:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I think I've found the first fact where the errno translation (ceph ->
> hostos -> client-ceph ) goes wrong....
>
> Repeatedly I get the following error:
> 116:
> /home/jenkins/workspace/ceph-master/src/test/libradosstriper/rados-striper.sh:42:
> run:  rados --pool rbd --striper put toy
> file td/rados-striper/toyfile
> 116: 2017-06-17 12:32:05.290234 810016000 -1 libradosstriper:
> RadosStriperImpl::openStripedObjectForWrite : could not set new s
> ize for toyfile : rc = -125error putting rbd/toyfile: (125) Unknown
> error: 125
>
> 125 is ECANCELD on Linux
> but FreeBSD
> #define ECANCELED       85              /* Operation canceled */
>
> So probably the server returns ECANCELD in network format (125)
> but the client does not translate back...

Somewhat related perhaps: people running cephfs on ARM recently had
this problem, for that case the solution was simply to define in Ceph
some constants that mirror the linux ones, see commit 88d2da5e9.

John

> Now if I want to have some logging for this in Freebsd_errno.cc
> What is the easiest way to get something in the logs?
> What descriptor is available there?
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
