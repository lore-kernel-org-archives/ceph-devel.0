From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 11:46:55 +0000
Message-ID: <DB5PR05MB16077168F7C87BB9D63F41ECA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0074.outbound.protection.outlook.com ([104.47.2.74]:63030
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751722AbcHWPVZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 11:21:25 -0400
In-Reply-To: <20160823112140.GH5955@rskikr.localdomain>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks Brad,

I am not sure I encountered same issue:
1st - I don't use cmake
2nd - my error is regardless of "ceph-build-deps", it will be popped immedi=
ately with "make dist" even when performing just the following commands (fr=
om ./make-debs.sh) on a clean git clone=20

	vers=3D$(git describe --match "v*" | sed s/^v//)
	./autogen.sh
	./configure --with-rocksdb --with-ocf \
	    --with-nss --with-debug --enable-cephfs-java \
	    --with-lttng --with-babeltrace
	make distdir=3Dceph-$vers dist

-----Original Message-----
From: Brad Hubbard
Sent: Tuesday, August 23, 2016 14:22
To: Avner Ben Hanoch
Cc: Gregory Farnum; Ceph Development <ceph-devel@vger.kernel.org>
Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/d=
b/slice.cc'

 On Tue, Aug 23, 2016 at 9:01 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> On Tue, Aug 23, 2016 at 8:46 PM, Avner Ben Hanoch <avnerb@mellanox.com> w=
rote:
>> Additional info, if I "git checkout v11.0.0" then ./make-debs.sh works o=
kay.
>> Hence, perhaps something was broken after this tag
>>
>> -----Original Message-----
>> From: Avner Ben Hanoch
>> Sent: Tuesday, August 23, 2016 11:27
>> To: 'Gregory Farnum'
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: RE: errors in make-debs.sh because "make dist" fails on 'rocksd=
b/db/slice.cc'
>>
>> Thanks Greg,
>>
>> The same error exists even if start with new clone:
>>         git clone https://github.com/ceph/ceph.git ceph-github
>>         cd ceph-github
>>         ./make-debs.sh
>>
>> In the output, I can now see many clones of submodules, including:
>>         ...
>>         Cloning into 'src/rocksdb'...
>>         remote: Counting objects: 41223, done.
>>         remote: Compressing objects: 100% (4/4), done.
>>         remote: Total 41223 (delta 0), reused 0 (delta 0), pack-reused 4=
1219
>>         Receiving objects: 100% (41223/41223), 51.05 MiB | 1.85 MiB/s, d=
one.
>>         Resolving deltas: 100% (30718/30718), done.
>>         Checking connectivity... done.
>>         Submodule path 'src/rocksdb': checked out '6797e6ffacd90470140f6=
4cea068970bb3a30aaf'
>>         ...
>>
>> And still, same error, at the end:
>>         ...
>>         + make distdir=3Dceph-11.0.0-1718-g2202bcc dist
>>         make  dist-gzip am__post_remove_distdir=3D'@:'
>>         make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
>>         if test -d "ceph-11.0.0-1718-g2202bcc"; then find "ceph-11.0.0-1=
718-g2202bcc" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-1=
1.0.0-1718-g2202bcc" || { sleep 5 && rm -rf "ceph-11.0.0-1718-g2202bcc"; };=
 else :; fi
>>         test -d "ceph-11.0.0-1718-g2202bcc" || mkdir "ceph-11.0.0-1718-g=
2202bcc"
>>          (cd src && make  top_distdir=3D../ceph-11.0.0-1718-g2202bcc dis=
tdir=3D../ceph-11.0.0-1718-g2202bcc/src \
>>              am__remove_distdir=3D: am__skip_length_check=3D: am__skip_m=
ode_fix=3D: distdir)
>>         make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
>>         ./make_version -g ./.git_version
>>         if [ -n "$NO_VERSION" ] ; then \
>>                 ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>>         else \
>>                 ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>>         fi
>>
>>         make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
>>         Makefile:976: recipe for target 'distdir' failed
>>         make[1]: *** [distdir] Error 1
>>         make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
>>         Makefile:1078: recipe for target 'dist' failed
>>         make: *** [dist] Error 2
>
> You could try changing to src/rocksdb and running "make clean" and=20
> "git clean -fdx" and retrying the build. It's possible some build=20
> artefact was left over in that submodule's directory structure for=20
> that commit. You could also compare the
> SHA1 of the src/rocksdb submodule in each case (workingv11.0.0  and=20
> not working) and see what changed between them.
>
> --
> HTH,
> Brad
>
>>
>> -----Original Message-----
>> From: Gregory Farnum
>> Sent: Tuesday, August 23, 2016 01:00
>> To: Avner Ben Hanoch
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksd=
b/db/slice.cc'
>>
>> On Mon, Aug 22, 2016 at 2:00 AM, Avner Ben Hanoch <avnerb@mellanox.com> =
wrote:
>>> HI All,
>>>
>>> The following lines from make-debs.sh:
>>>
>>>         vers=3D$(git describe --match "v*" | sed s/^v//)
>>>         ./autogen.sh
>>>         ./configure --with-rocksdb --with-ocf \
>>>             --with-nss --with-debug --enable-cephfs-java \
>>>             --with-lttng --with-babeltrace
>>>         make distdir=3Dceph-$vers dist
>>>
>>> produces the following error:
>>>
>>>         make  dist-gzip am__post_remove_distdir=3D'@:'
>>>         make[1]: Entering directory '/mnt/sdh/avnerb/ceph-github'
>>>         if test -d "ceph-11.0.0-1689-g23eeb74"; then find "ceph-11.0.0-=
1689-g23eeb74" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "ceph-=
11.0.0-1689-g23eeb74" || { sleep 5 && rm -rf "ceph-11.0.0-1689-g23eeb74"; }=
; else :; fi
>>>         test -d "ceph-11.0.0-1689-g23eeb74" || mkdir "ceph-11.0.0-1689-=
g23eeb74"
>>>          (cd src && make  top_distdir=3D../ceph-11.0.0-1689-g23eeb74 di=
stdir=3D../ceph-11.0.0-1689-g23eeb74/src \
>>>              am__remove_distdir=3D: am__skip_length_check=3D: am__skip_=
mode_fix=3D: distdir)
>>>         make[2]: Entering directory '/mnt/sdh/avnerb/ceph-github/src'
>>>         ./make_version -g ./.git_version
>>>         if [ -n "$NO_VERSION" ] ; then \
>>>                 ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>>>         else \
>>>                 ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>>>         fi
>>>         make[2]: *** No rule to make target 'rocksdb/db/slice.cc', need=
ed by 'distdir'.  Stop.
>>>         make[2]: Leaving directory '/mnt/sdh/avnerb/ceph-github/src'
>>>         Makefile:976: recipe for target 'distdir' failed
>>>         make[1]: *** [distdir] Error 1
>>>         make[1]: Leaving directory '/mnt/sdh/avnerb/ceph-github'
>>>         Makefile:1078: recipe for target 'dist' failed
>>>         make: *** [dist] Error 2
>>
>> Errors here generally occur if you've got an outdated submodule (or it's=
 just missing). Try deleting it and re-doing the submodule entirely.
>> -Greg
>
>

There is some discussion in http://tracker.ceph.com/issues/16819 of make-de=
b.sh not being "cmake aware". Perhaps this is related in some way?

--
Cheers,
Brad
