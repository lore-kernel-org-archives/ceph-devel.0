From: Loic Dachary <loic@dachary.org>
Subject: Re: make error while building ceph
Date: Tue, 1 Mar 2016 00:34:32 +0700
Message-ID: <56D48128.8020701@dachary.org>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
 <56D2D089.7090109@dachary.org>
 <CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
 <56D2D55C.7060603@dachary.org>
 <CAPpuMWyePM_TvmO1MHFRF=jQMw5KRqyy4FA3+QRU2pAq97UwSw@mail.gmail.com>
 <56D460AD.9070806@dachary.org>
 <CAPpuMWxo-qSeMyiv2eMNhbM-5=dp-+eQOxqvH_yZUNCenfDQUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47318 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcB2Rek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 12:34:40 -0500
In-Reply-To: <CAPpuMWxo-qSeMyiv2eMNhbM-5=dp-+eQOxqvH_yZUNCenfDQUg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jai <jai_97@rediffmail.com>
Cc: ceph-devel@vger.kernel.org

It appears to be a problem with your installation: the compiler's not w=
orking as it should ?

On 01/03/2016 00:13, Jai wrote:
> That was the output from make.
> ps shows the actual compilation  command as --
>=20
> jai       2822  2821  3 19:47 pts/0    00:05:09
> /usr/libexec/gcc/x86_64-redhat-linux/4.8.5/cc1plus -quiet -I . -I
> /usr/include/nss3 -I /usr/include/nspr4 -MD
> test/encoding/ceph_dencoder-ceph_dencoder.d -MF
> test/encoding/.deps/ceph_dencoder-ceph_dencoder.Tpo -MP -MT
> test/encoding/ceph_dencoder-ceph_dencoder.o -D_GNU_SOURCE -D
> HAVE_CONFIG_H -D __CEPH__ -D _FILE_OFFSET_BITS=3D64 -D _THREAD_SAFE -=
D
> __STDC_FORMAT_MACROS -D _GNU_SOURCE -D CEPH_LIBDIR=3D"/usr/local/lib"=
 -D
> CEPH_PKGLIBDIR=3D"/usr/local/lib/ceph" -D GTEST_USE_OWN_TR1_TUPLE=3D0=
 -D
> _REENTRANT -D WITH_RBD -D WITH_RADOSGW -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 test/encoding/ceph_dencoder.cc -quiet -dumpbase
> ceph_dencoder.cc -mtune=3Dgeneric -march=3Dx86-64 -auxbase-strip
> test/encoding/ceph_dencoder-ceph_dencoder.o -g -g -O2 -O2
> -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith
> -Wnon-virtual-dtor -Wno-invalid-offsetof -Wall -Wstrict-null-sentinel
> -std=3Dgnu++11 -fno-strict-aliasing -fsigned-char -ftemplate-depth=3D=
1024
> -fexceptions -fPIE -fstack-protector -fno-builtin-malloc
> -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free
> -fno-var-tracking-assignments --param ssp-buffer-size=3D4 -o -
>=20
> It appears to be stuck in strcmp in libc.
>=20
> gstack 2822
> #0  0x00007f57bd9b3006 in __strcmp_sse42 () from /lib64/libc.so.6
> #1  0x000000000096447c in ?? ()
> #2  0x0000000000dcd027 in htab_find_slot_with_hash ()
> #3  0x000000000096b3b1 in ?? ()
> #4  0x000000000098b741 in ?? ()
> #5  0x0000000000e2f626 in ?? ()
> #6  0x0000000000e3005c in toplev_main(int, char**) ()
> #7  0x00007f57bd8a2b15 in __libc_start_main () from /lib64/libc.so.6
> #8  0x0000000000dceaad in _start ()
>=20
> On Mon, Feb 29, 2016 at 8:45 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>
>>
>> On 29/02/2016 21:34, Jai wrote:
>>> Loic,
>>>
>>> With centos 7, I ve moved further .. The build is stuck however at =
this --
>>>
>>> ./make_version -g ./.git_version
>>> if [ -n "$NO_VERSION" ] ; then \
>>>         ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
>>> else \
>>>         ./make_version -g ./.git_version -c ./ceph_ver.h ; \
>>> fi
>>>   CXX      test/encoding/ceph_dencoder-ceph_dencoder.o
>>>
>>> I ve tried restarting the make a few times after cleaning up, but i=
t
>>> comes back to this point. Could this be a failed/hung test ?
>>
>> I'm not sure, it looks like the compilation is not finished yet and =
the tests did not start. Could you provide details about what is stuck =
?
>>
>> Cheers
>>
>>>
>>> --
>>> Jai
>>>
>>> On Sun, Feb 28, 2016 at 4:39 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>> Hi,
>>>>
>>>> Ubuntu 12.04 is no longer supported, reason why you're having trou=
bles. I recommend CentOS 7 or Ubunut 14.04 instead.
>>>>
>>>> Cheers
>>>>
>>>> On 28/02/2016 17:55, Jai wrote:
>>>>> Loic,
>>>>>
>>>>> I did run install-deps before the make, and it completed without
>>>>> error. I have an Ubuntu (1204) VM (uname shows 3.5.0-30-generic
>>>>> #51~precise1-Ubuntu)
>>>>>
>>>>> I ran these as per the README --
>>>>> ./install-deps.sh
>>>>> ./autogen.sh
>>>>>   ./configure
>>>>>   make
>>>>>
>>>>> I found the bugs link on http://ceph.com/community/contribute/ un=
der
>>>>> "submit issues"
>>>>>
>>>>> --
>>>>> Jai
>>>>>
>>>>> On Sun, Feb 28, 2016 at 4:18 PM, Loic Dachary <loic@dachary.org> =
wrote:
>>>>>> Hi,
>>>>>>
>>>>>> You should try to run ./install-deps.sh first so that the requir=
ed dependencies are all installed. Which operating system are you using=
 ?
>>>>>> The bug tracker is at http://tracker.ceph.com/. Where did you fi=
nd a link to http://tracker.newdream.net/projects/ceph ? It should be f=
ixed :-)
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> On 28/02/2016 17:29, Jai wrote:
>>>>>>> I followed instructions in the README, but "make" gives me this=
 error --
>>>>>>>
>>>>>>> In file included from ./include/types.h:21:0,
>>>>>>>                  from kv/LevelDBStore.h:6,
>>>>>>>                  from kv/KeyValueDB.cc:5:
>>>>>>> ./include/uuid.h:14:42: fatal error: boost/random/random_device=
=2Ehpp:
>>>>>>> No such file or directory
>>>>>>> compilation terminated.
>>>>>>>
>>>>>>> I m compiling on ubuntu, and it looks like I have boost headers
>>>>>>> (/usr/include/boost), but this file is absent. llibboost appear=
s to be
>>>>>>> 1.46.1
>>>>>>> appreciate any pointers to resolve this error.
>>>>>>>
>>>>>>> Also, I couldn't access the web page for bugs
>>>>>>> (http://tracker.newdream.net/projects/ceph) - where can I find =
a list
>>>>>>> of bugs/ features ?
>>>>>>> --
>>>>>>> Jai
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
