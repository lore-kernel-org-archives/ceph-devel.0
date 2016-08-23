From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 21:01:25 +1000
Message-ID: <20160823110125.GG5955@rskikr.localdomain>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35968 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757860AbcHWLGz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 07:06:55 -0400
Received: by mail-pa0-f52.google.com with SMTP id pp5so47366551pac.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 04:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 23, 2016 at 8:46 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Additional info, if I "git checkout v11.0.0" then ./make-debs.sh works okay.
> Hence, perhaps something was broken after this tag
>
> -----Original Message-----
> From: Avner Ben Hanoch
> Sent: Tuesday, August 23, 2016 11:27
> To: 'Gregory Farnum'
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: RE: errors in make-debs.sh because "make dist" fails on 'rocksdb/db/slice.cc'
>
> Thanks Greg,
>
> The same error exists even if start with new clone:
>         git clone https://github.com/ceph/ceph.git ceph-github
>         cd ceph-github
>         ./make-debs.sh
>
> In the output, I can now see many clones of submodules, including:
>         ...
>         Cloning into 'src/rocksdb'...
>         remote: Counting objects: 41223, done.
>         remote: Compressing objects: 100% (4/4), done.
>         remote: Total 41223 (delta 0), reused 0 (delta 0), pack-reused 41219
>         Receiving objects: 100% (41223/41223), 51.05 MiB | 1.85 MiB/s, done.
>         Resolving deltas: 100% (30718/30718), done.
>         Checking connectivity... done.
>         Submodule path 'src/rocksdb': checked out '6797e6ffacd90470140f64cea068970bb3a30aaf'
>         ...
>
> And still, same error, at the end:
>         ...
>         + make distdir=ceph-11.0.0-1718-g2202bcc dist
>         make  dist-gzip am__post_remove_distdir='@:'
>         make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
>         if test -d "ceph-11.0.0-1718-g2202bcc"; then find "ceph-11.0.0-1718-g2202bcc" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-11.0.0-1718-g2202bcc" || { sleep 5 && rm -rf "ceph-11.0.0-1718-g2202bcc"; }; else :; fi
>         test -d "ceph-11.0.0-1718-g2202bcc" || mkdir "ceph-11.0.0-1718-g2202bcc"
>          (cd src && make  top_distdir=../ceph-11.0.0-1718-g2202bcc distdir=../ceph-11.0.0-1718-g2202bcc/src \
>              am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir)
>         make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
>         ./make_version -g ./.git_version
>         if [ -n "$NO_VERSION" ] ; then \
>                 ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>         else \
>                 ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>         fi
>        
>         make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
>         Makefile:976: recipe for target 'distdir' failed
>         make[1]: *** [distdir] Error 1
>         make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
>         Makefile:1078: recipe for target 'dist' failed
>         make: *** [dist] Error 2

You could try changing to src/rocksdb and running "make clean" and "git clean
-fdx" and retrying the build. It's possible some build artefact was left over in
that submodule's directory structure for that commit. You could also compare the
SHA1 of the src/rocksdb submodule in each case (workingv11.0.0  and not working) and see
what changed between them.

-- 
HTH,
Brad

>
> -----Original Message-----
> From: Gregory Farnum
> Sent: Tuesday, August 23, 2016 01:00
> To: Avner Ben Hanoch
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/db/slice.cc'
>
> On Mon, Aug 22, 2016 at 2:00 AM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
>> HI All,
>>
>> The following lines from make-debs.sh:
>>
>>         vers=$(git describe --match "v*" | sed s/^v//)
>>         ./autogen.sh
>>         ./configure --with-rocksdb --with-ocf \
>>             --with-nss --with-debug --enable-cephfs-java \
>>             --with-lttng --with-babeltrace
>>         make distdir=ceph-$vers dist
>>
>> produces the following error:
>>
>>         make  dist-gzip am__post_remove_distdir='@:'
>>         make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
>>         if test -d "ceph-11.0.0-1689-g23eeb74"; then find "ceph-11.0.0-1689-g23eeb74" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-11.0.0-1689-g23eeb74" || { sleep 5 && rm -rf "ceph-11.0.0-1689-g23eeb74"; }; else :; fi
>>         test -d "ceph-11.0.0-1689-g23eeb74" || mkdir "ceph-11.0.0-1689-g23eeb74"
>>          (cd src && make  top_distdir=../ceph-11.0.0-1689-g23eeb74 distdir=../ceph-11.0.0-1689-g23eeb74/src \
>>              am__remove_distdir=: am__skip_length_check=: am__skip_mode_fix=: distdir)
>>         make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
>>         ./make_version -g ./.git_version
>>         if [ -n "$NO_VERSION" ] ; then \
>>                 ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>>         else \
>>                 ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>>         fi
>>         make[2]: *** No rule to make target 'rocksdb/db/slice.cc', needed by 'distdir'.  Stop.
>>         make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
>>         Makefile:976: recipe for target 'distdir' failed
>>         make[1]: *** [distdir] Error 1
>>         make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
>>         Makefile:1078: recipe for target 'dist' failed
>>         make: *** [dist] Error 2
>
> Errors here generally occur if you've got an outdated submodule (or it's just missing). Try deleting it and re-doing the submodule entirely.
> -Greg


