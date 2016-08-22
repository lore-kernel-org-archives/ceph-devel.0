From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/db/slice.cc'
Date: Mon, 22 Aug 2016 15:00:06 -0700
Message-ID: <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:32791 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756483AbcHVWAJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 18:00:09 -0400
Received: by mail-ua0-f182.google.com with SMTP id 74so214155337uau.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 15:00:07 -0700 (PDT)
In-Reply-To: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 22, 2016 at 2:00 AM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> HI All,
>
> The following lines from make-debs.sh:
>
>         vers=$(git describe --match "v*" | sed s/^v//)
>         ./autogen.sh
>         ./configure --with-rocksdb --with-ocf \
>             --with-nss --with-debug --enable-cephfs-java \
>             --with-lttng --with-babeltrace
>         make distdir=ceph-$vers dist
>
> produces the following error:
>
>         make  dist-gzip am__post_remove_distdir='@:'
>         make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
>         if test -d "ceph-11.0.0-1689-g23eeb74"; then find "ceph-11.0.0-1689-g23eeb74" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-11.0.0-1689-g23eeb74" || { sleep 5 && rm -rf "ceph-11.0.0-1689-g23eeb74"; }; else :; fi
>         test -d "ceph-11.0.0-1689-g23eeb74" || mkdir "ceph-11.0.0-1689-g23eeb74"
>          (cd src && make  top_distdir=../ceph-11.0.0-1689-g23eeb74 distdir=../ceph-11.0.0-1689-g23eeb74/src \
>              am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir)
>         make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
>         ./make_version -g ./.git_version
>         if [ -n "$NO_VERSION" ] ; then \
>                 ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>         else \
>                 ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>         fi
>         make[2]: *** No rule to make target 'rocksdb/db/slice.cc', needed by 'distdir'.  Stop.
>         make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
>         Makefile:976: recipe for target 'distdir' failed
>         make[1]: *** [distdir] Error 1
>         make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
>         Makefile:1078: recipe for target 'dist' failed
>         make: *** [dist] Error 2

Errors here generally occur if you've got an outdated submodule (or
it's just missing). Try deleting it and re-doing the submodule
entirely.
-Greg
