From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph master - build broken unless --enable-debug specified
Date: Thu, 16 Apr 2015 17:27:05 -0700
Message-ID: <CAC6JEv_uRE=UfVQpZ+NtzX2nCpMthienXuTdNHtynDK6oQ4G1A@mail.gmail.com>
References: <5529E9BC.2090203@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38520 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbDQA1H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 20:27:07 -0400
Received: by igbhj9 with SMTP id hj9so2783137igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 17:27:06 -0700 (PDT)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com. [209.85.213.171])
        by mx.google.com with ESMTPSA id n7sm231723iga.13.2015.04.16.17.27.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 17:27:06 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so2782913igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 17:27:05 -0700 (PDT)
In-Reply-To: <5529E9BC.2090203@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, Josh Durgin <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Apr 11, 2015 at 8:42 PM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> Hi,
>
> Building without --enable-debug produces:
>
> ceph_fuse.cc: In member function =E2=80=98virtual void* main(int, con=
st char**,
> const char**)::RemountTest::entry()=E2=80=99:
> ceph_fuse.cc:146:15: warning: ignoring return value of =E2=80=98int s=
ystem(const
> char*)=E2=80=99, declared with attribute warn_unused_result [-Wunused=
-result]
>     system(buf);
>                ^
>   CXX      ceph_osd.o
>   CXX      ceph_mds.o
> make[3]: *** No rule to make target '../src/gmock/lib/libgmock_main.l=
a',
> needed by 'unittest_librbd'.  Stop.
> make[3]: *** Waiting for unfinished jobs....
>   CXX      test/erasure-code/ceph_erasure_code_non_regression.o
> make[3]: Leaving directory '/home/markir/develop/c/ceph/src'
> Makefile:20716: recipe for target 'all-recursive' failed
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory '/home/markir/develop/c/ceph/src'
> Makefile:8977: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory '/home/markir/develop/c/ceph/src'
> Makefile:467: recipe for target 'all-recursive' failed
> make: *** [all-recursive] Error 1
>
>
> Adding in --enable-debug gives a successful build.
>
> This is on Ubuntu 14.10 64 bit, and the build procedure is:
>
> $ git pull
> $ git submodule update --init
> $ ./autogen.sh
> $ ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/=
var \
>               [--with-debug \ ]
>               --with-nss \
>               --with-radosgw \
>               --with-librocksdb-static=3Dcheck \
>
> $ make [ -j4 ]

Yep, looks like the unittest_librbd binary is in the noinst_PROGRAMS
target (whatever that is) rather than the check_PROGRAMS target.
Changing that seems to work =E2=80=94 I pushed a branch wip-nodebug-bui=
ld
fixing it, but if you have your own fix a PR is welcome. If not I'll
make a PR in the next couple days.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
