From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: unable to build Debian Stretch for 12.1.2
Date: Wed, 26 Jul 2017 15:43:21 +0200 (CEST)
Message-ID: <68916451.345723.1501076601021.JavaMail.zimbra@oxygem.tv>
References: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com> <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com> <CAC-Np1xnvw9KtwdKcTLTsKdarWH25FAeoExWhzB0Ad+TuTHM4A@mail.gmail.com> <CAF-wwdFhpUowuBT7Rxfmw4wPQUWHnxF7ZKQ0hRMoPo79cY-hEQ@mail.gmail.com> <CAF-wwdHQ9Zcp58VBBGqFOTFGz5acsLxe5ZVXX9jTyc_uSSAzvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:44484 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdGZNwq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jul 2017 09:52:46 -0400
In-Reply-To: <CAF-wwdHQ9Zcp58VBBGqFOTFGz5acsLxe5ZVXX9jTyc_uSSAzvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

It's building fine here on a real debian strech.

git clone https://github.com/ceph/ceph
git submodule update --force --init --recursive
git checkout v12.1.1
./install-deps.sh
dpkd-buildpackage



ii  gcc                                    4:6.3.0-4                             amd64        GNU C compiler
ii  gcc-4.4                                4.4.7-2                               amd64        GNU C compiler
ii  gcc-4.4-base:amd64                     4.4.7-2                               amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-4.9                                4.9.2-10                              amd64        GNU C compiler
ii  gcc-4.9-base:amd64                     4.9.2-10                              amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-6                                  6.3.0-18                              amd64        GNU C compiler
ii  gcc-6-base:amd64                       6.3.0-18                              amd64        GCC, the GNU Compiler Collection (base package)
ii  libgcc-4.9-dev:amd64                   4.9.2-10                              amd64        GCC support library (development files)
ii  libgcc-6-dev:amd64                     6.3.0-18                              amd64        GCC support library (development files)
ii  libgcc1:amd64                          1:6.3.0-18                            amd64        GCC support library
ii  libc6:amd64                            2.24-11+deb9u1                        amd64        GNU C Library: Shared libraries
ii  libc6-dbg:amd64                        2.24-11+deb9u1                        amd64        GNU C Library: detached debugging symbols
ii  libc6-dev:amd64                        2.24-11+deb9u1                        amd64        GNU C Library: Development Libraries and Header Files
ii  libc6-i386                             2.24-11+deb9u1                        amd64        GNU C Library: 32-bit shared libraries for AMD64


----- Mail original -----
De: "Brad Hubbard" <bhubbard@redhat.com>
À: "Alfredo Deza" <adeza@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoyé: Mercredi 26 Juillet 2017 03:18:20
Objet: Re: unable to build Debian Stretch for 12.1.2

Ah, here's the exact command. Disguised due to multi-threading. 

cd /build/ceph-12.1.2/obj-x86_64-linux-gnu/src/test/librbd && 
/usr/bin/c++ -DCEPH_LIBDIR=\"/usr/lib\" 
-DCEPH_PKGLIBDIR=\"/usr/lib/ceph\" -DTEST_LIBRBD_INTERNALS 
-D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D__linux__ -isystem 
/build/ceph-12.1.2/obj-x86_64-linux-gnu/boost/include 
-I/build/ceph-12.1.2/obj-x86_64-linux-gnu/src/include 
-I/build/ceph-12.1.2/src -isystem 
/build/ceph-12.1.2/obj-x86_64-linux-gnu/include 
-I/build/ceph-12.1.2/src/xxHash -isystem 
/build/ceph-12.1.2/src/rapidjson/include 
-I/build/ceph-12.1.2/src/dmclock/src 
-I/build/ceph-12.1.2/src/dmclock/support/src 
-I/build/ceph-12.1.2/src/googletest/googletest/include 
-I/build/ceph-12.1.2/src/googletest/googlemock/include -g -O2 
-fdebug-prefix-map=/build/ceph-12.1.2=. -fstack-protector-strong 
-Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -Wall 
-Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
-Werror=format-security -fno-strict-aliasing -fsigned-char 
-Wno-unknown-pragmas -rdynamic -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 
-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fstack-protector-strong 
-fdiagnostics-color=auto -I/usr/include/nss -I/usr/include/nspr 
-I/usr/include -fno-builtin-malloc -fno-builtin-calloc 
-fno-builtin-realloc -fno-builtin-free -fPIE -DHAVE_CONFIG_H 
-D__CEPH__ -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS 
-I/build/ceph-12.1.2/src/googletest/googlemock/include 
-I/build/ceph-12.1.2/obj-x86_64-linux-gnu/src/googletest/googlemock/include 
-I/build/ceph-12.1.2/src/googletest/googletest/include 
-I/build/ceph-12.1.2/obj-x86_64-linux-gnu/src/googletest/googletest/include 
-fno-strict-aliasing -std=c++11 -o 
CMakeFiles/unittest_librbd.dir/object_map/test_mock_LockRequest.cc.o 
-c /build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc 


On Wed, Jul 26, 2017 at 11:14 AM, Brad Hubbard <bhubbard@redhat.com> wrote: 
> This is basically the command it's using (although I think this is 
> generating the preprocessed source so we might have to play with some 
> of the args). 
> 
> /usr/lib/gcc/x86_64-linux-gnu/6/cc1plus -quiet -I 
> /build/ceph-12.1.2/obj-x86_64-linux-gnu/src/include -I 
> /build/ceph-12.1.2/src -I /build/ceph-12.1.2/src/xxHash -I 
> /build/ceph-12.1.2/src/dmclock/src -I 
> /build/ceph-12.1.2/src/dmclock/support/src -I 
> /build/ceph-12.1.2/src/googletest/googletest/include -I 
> /build/ceph-12.1.2/src/googletest/googlemock/include -I 
> /usr/include/nss -I /usr/include/nspr -I /usr/include -I 
> /build/ceph-12.1.2/src/googletest/googlemock/include -I 
> /build/ceph-12.1.2/obj-x86_64-linux-gnu/src/googletest/googlemock/include 
> -I /build/ceph-12.1.2/src/googletest/googletest/include -I 
> /build/ceph-12.1.2/obj-x86_64-linux-gnu/src/googletest/googletest/include 
> -imultiarch x86_64-linux-gnu -D_GNU_SOURCE -D CEPH_LIBDIR="/usr/lib" 
> -D CEPH_PKGLIBDIR="/usr/lib/ceph" -D TEST_LIBRBD_INTERNALS -D 
> _FILE_OFFSET_BITS=64 -D _GNU_SOURCE -D __linux__ -D _FORTIFY_SOURCE=2 
> -U _FORTIFY_SOURCE -D _FORTIFY_SOURCE=2 -U _FORTIFY_SOURCE -D 
> _FORTIFY_SOURCE=2 -D HAVE_CONFIG_H -D __CEPH__ -D _REENTRANT -D 
> _THREAD_SAFE -D __STDC_FORMAT_MACROS -isystem 
> /build/ceph-12.1.2/obj-x86_64-linux-gnu/boost/include -isystem 
> /build/ceph-12.1.2/obj-x86_64-linux-gnu/include -isystem 
> /build/ceph-12.1.2/src/rapidjson/include 
> /build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc 
> -quiet -dumpbase test_mock_LockRequest.cc -mtune=generic -march=x86-64 
> -auxbase-strip CMakeFiles/unittest_librbd.dir/object_map/test_mock_LockRequest.cc.o 
> -g -O2 -Wformat=1 -Werror=format-security -Wdate-time -Wall 
> -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -Wno-unknown-pragmas -std=c++11 
> -fdiagnostics-color=auto -fdebug-prefix-map=/build/ceph-12.1.2=. 
> -fstack-protector-strong -fsigned-char -fstack-protector-strong 
> -fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc 
> -fno-builtin-free -fPIE -fno-strict-aliasing -o - -frandom-seed=0 
> -fdump-noaddr 
> 
> If we can set up a machine with env the same as pbuilder is using we 
> can run the command manually and see what we get. 
> 
> On Wed, Jul 26, 2017 at 10:23 AM, Alfredo Deza <adeza@redhat.com> wrote: 
>> On Tue, Jul 25, 2017 at 5:53 PM, Brad Hubbard <bhubbard@redhat.com> wrote: 
>>> 
>>> 
>>> On Wed, Jul 26, 2017 at 5:02 AM, Alfredo Deza <adeza@redhat.com> wrote: 
>>>> We are (consistently) hitting this Segmentation Fault: 
>>>> 
>>>> /build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc:61:3: 
>>>> internal compiler error: Segmentation fault 
>>>> } 
>>>> ^ 
>>>> 
>>>> https://jenkins.ceph.com/job/ceph-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/237/consoleFull#-1443688772a811ea2-3e7b-466b-84b4-d13df7e35809 
>>>> 
>>>> The builds for Debian distros are all produced from Xenial hosts that 
>>>> use pbuilder to accommodate any Deb distro. On the same host, Xenial 
>>>> and Trusty works fine for example. 
>>>> 
>>>> GCC version on the box that failed: 
>>>> 
>>>> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609 
>>>> 
>>>> The scripts we use for building are here: 
>>>> https://github.com/ceph/ceph-build/tree/master/ceph-build/build 
>>>> 
>>>> Unless someone can help out identify why this happens and how to fix 
>>>> it, it means that we will not be able to have Stretch packages. 
>>> 
>>> This looks like a compiler error. 
>>> 
>>> You can use "VERBOSE=1 make" to get it to spit out the command line that it is 
>>> running at the time of failure. Then hopefully you can run the compiler in gdb 
>>> and get a stack trace or, alternatively capture a coredump and get a stack trace 
>>> from that. I'd there compare the stack trace with known gcc bugs and hope we get 
>>> a hit. 
>> 
>> Added it, not sure if that did anything (it might be me though) 
>> 
>> https://jenkins.ceph.com/job/ceph-build/240/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/console 
>> 
>> This is the line that consistently brings this crashing: 
>> https://github.com/ceph/ceph/blob/luminous/src/test/librbd/object_map/test_mock_LockRequest.cc#L61 
>> 
>> We will go ahead with the release without Debian Stretch. Maybe 
>> someone can help figure this out, since it seems consistent (it failed 
>> in the same way on the same spot every time). 
>> 
>> This means that Debian Stretch will also be disabled on other releases 
>> until we at least build it often enough without issues 
>>> 
>>>> 
>>>> -Alfredo 
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
>>>> the body of a message to majordomo@vger.kernel.org 
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html 
>>> 
>>> 
>>> 
>>> -- 
>>> Cheers, 
>>> Brad 
> 
> 
> 
> -- 
> Cheers, 
> Brad 



-- 
Cheers, 
Brad 
-- 
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 

