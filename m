From: kefu chai <tchaikov@gmail.com>
Subject: Re: Cmake build. C compiler.
Date: Fri, 23 Sep 2016 19:12:58 +0800
Message-ID: <CAJE9aOOviq9ZVfQ8JmB8TVmVbA47XG14nC8qGth4P1LjkJxmYA@mail.gmail.com>
References: <D405A8C2.12B32%evgeniy.firsov@sandisk.com> <c41894d2-1d9f-b640-b9e3-bcc958a8a518@digiware.nl>
 <D405E2C2.12B3D%evgeniy.firsov@sandisk.com> <CAJE9aOMzGb920sKSk+AvCnmzCtKsTmk4JFO7QYdB6ZhCVgwujg@mail.gmail.com>
 <D409B01F.12C8C%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33726 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755175AbcIWLNA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 07:13:00 -0400
Received: by mail-oi0-f54.google.com with SMTP id r126so130248315oib.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 04:12:59 -0700 (PDT)
In-Reply-To: <D409B01F.12C8C%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 23, 2016 at 7:02 AM, Evgeniy Firsov
<Evgeniy.Firsov@sandisk.com> wrote:
> Kefu,
>
> You are right. My statement was wrong. I found that the problem was in
> NDEBUG handling in ZS code.
> However, do you know if there is a way to build =E2=80=9Cin tree=E2=80=9D=
, I mean as we
> did with auto tools, without creating =E2=80=9Cbuild=E2=80=9D directory?

why would you want to build "in tree"? because you don't want ceph's
"assert.h" to be include by ZS code?

>
> On 9/20/16, 11:04 PM, "kefu chai" <tchaikov@gmail.com> wrote:
>
>>On Tue, Sep 20, 2016 at 9:48 AM, Evgeniy Firsov
>><Evgeniy.Firsov@sandisk.com> wrote:
>>> It has nothing to do with compilers.
>>> There is a bug in NDEBUG handling in ZetaScale, which Ceph=E2=80=99s
>>> CmakeLists.txt passes down.
>>>
>>> And =E2=80=9Cin tree=E2=80=9D build just uses wrong include paths, I gu=
ess.
>>>
>>> On 9/19/16, 3:00 PM, "Willem Jan Withagen" <wjw@digiware.nl> wrote:
>>>
>>>>On 19-9-2016 23:37, Evgeniy Firsov wrote:
>>>>> Hi, Guys,
>>>>>
>>>>> When I build Ceph using ./do_cmake.sh && cd build && make -j32, looks
>>>>>like
>>>>> everything is compiled using C++ compiler, even files with .c
>>>>>extension.
>>
>>this is not true. src/tracing/librados.c is a pure C source file. when
>>i run following command, i have:
>>
>>$ make rados_tp VERBOSE=3D1
>>...
>>Building C object
>>src/tracing/CMakeFiles/rados_tp.dir/__/__/include/tracing/librados.c.o
>>cd /var/ceph/ceph/build/src/tracing && ccache /usr/bin/cc
>>-DCEPH_LIBDIR=3D\"/home/kefu/.local/lib\"
>>-DCEPH_PKGLIBDIR=3D\"/home/kefu/.local/lib/ceph\" -D__linux__
>>-Drados_tp_EXPORTS -I/var/ceph/ceph/build/src/include
>>-I/var/ceph/ceph/src -I/var/ceph/ceph/build/include
>>-I/var/ceph/ceph/src/xxHash  -Wall -Wtype-limits -Wignored-qualifiers
>>-Winit-self -Wpointer-arith -Werror=3Dformat-security
>>-fno-strict-aliasing -fsigned-char -rdynamic -fstack-protector-strong
>>-fdiagnostics-color=3Dauto -g -fPIC   -DHAVE_CONFIG_H -D__CEPH__
>>-D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE
>>-D_FILE_OFFSET_BITS=3D64 -o
>>CMakeFiles/rados_tp.dir/__/__/include/tracing/librados.c.o   -c
>>/var/ceph/ceph/build/include/tracing/librados.c
>>Linking C shared library ../../lib/librados_tp.so
>>...
>>
>>so it is using cc not c++ to compile this source file.
>>
>>
>>>>> This fails ZetaScale compilation, which is pure C.
>>
>>could you share your repo/branch address of Ceph with ZetaScale so
>>people can try and verify?
>>
>>>>>
>>>>> In oppose to that if I am building =C2=B3in tree=C2=B2, with cmake . =
&& make
>>>>>-j32,
>>>>> Ceph build fails, because it uses proper C compiler for .c extension,
>>>>>but
>>>>> they include Ceph=C2=B9s assert.h which is C++.
>>>>>
>>>>> So, probably, I need to configure compiler on per directory basis, is
>>>>> there known way to do that?
>>>>> Also, can somebody point me where in the CMakeList.txt compiler is
>>>>> configured for =C2=B3out of tree=C2=B2 build? I mean C++ for everythi=
ng.
>>>>
>>>>You can run
>>>>cmake --system-information
>>>>to find out what you system is using for defaults....
>>>>
>>>>Mine (FreeBSD) has:
>>>>
>>>>CMAKE_CXX_COMPILER =3D=3D "/usr/bin/CC"
>>>>CMAKE_C_COMPILER =3D=3D "/usr/bin/cc"
>>>>
>>>>So it sort of already knows from the beginning the difference between C
>>>>and C++
>>>>
>>>>--WjW
>>>>>
>>>>> =E2=80=B9
>>>>> Evgeniy
>>>>>
>>>>>
>>>>> PLEASE NOTE: The information contained in this electronic mail messag=
e
>>>>>is intended only for the use of the designated recipient(s) named
>>>>>above.
>>>>>If the reader of this message is not the intended recipient, you are
>>>>>hereby notified that you have received this message in error and that
>>>>>any review, dissemination, distribution, or copying of this message is
>>>>>strictly prohibited. If you have received this communication in error,
>>>>>please notify the sender by telephone or e-mail (as shown above)
>>>>>immediately and destroy any and all copies of this message in your
>>>>>possession (whether hard copies or electronically stored copies).
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>>> PLEASE NOTE: The information contained in this electronic mail message
>>>is intended only for the use of the designated recipient(s) named above.
>>>If the reader of this message is not the intended recipient, you are
>>>hereby notified that you have received this message in error and that
>>>any review, dissemination, distribution, or copying of this message is
>>>strictly prohibited. If you have received this communication in error,
>>>please notify the sender by telephone or e-mail (as shown above)
>>>immediately and destroy any and all copies of this message in your
>>>possession (whether hard copies or electronically stored copies).
>>
>>
>>
>>--
>>Regards
>>Kefu Chai
>
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).



--=20
Regards
Kefu Chai
