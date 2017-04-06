From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Jewel 10.2.7 QE status
Date: Thu, 6 Apr 2017 11:28:15 +0200
Message-ID: <CAOi1vP-TZog6Hb+ZKehmrU_cR534TQER1xUh0+KEZ+YZfXAyuA@mail.gmail.com>
References: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36295 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755728AbdDFJ2R (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 05:28:17 -0400
Received: by mail-vk0-f52.google.com with SMTP id s68so33938620vke.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 02:28:16 -0700 (PDT)
In-Reply-To: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

On Wed, Apr 5, 2017 at 10:16 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/19055#note-13
> The following suites were in scope of this point release validation:
>
> rados (subset 35/50 227 jobceph-ansibles)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> rest
> hadoop - EXCLUDED
> samba - EXCLUDED
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/jewel-x/point-to-point-x
> powercycle
> ceph-ansible
>
> (please let me know if any suites are missing from this ^ list)
>
> =====================
> Outstanding issues
>
> rados - two jobs failed, need Josh's approval
> krbd - seems similar to previous release, need Ilya's approval

The first two failed to compile ltp, both on 7.3 and 16.04:

smithi022.stderr:/tmp/ccHOwwst.o: In function `doio_fprintf':
smithi022.stderr:/home/ubuntu/cephtest/xfstests/ltp/doio.c:2410:
undefined reference to `va_start'
smithi022.stderr:/home/ubuntu/cephtest/xfstests/ltp/doio.c:2414:
undefined reference to `va_end'
smithi022.stderr:collect2: error: ld returned 1 exit status
smithi022.stderr:gmake[3]: *** [doio] Error 1
smithi022.stderr:gmake[3]: *** Waiting for unfinished jobs....

The rerun on 14.04 succeeded -- need to look into that.

Approved.

Thanks,

                Ilya
