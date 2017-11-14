From: kefu chai <tchaikov@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 14 Nov 2017 21:06:35 +0800
Message-ID: <CAJE9aOOPBT05p5b23e+LJ8mft2-c3revrWwmkjYzNYD5FBgMUg@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CACJqLyamZeEro6htJDV3EDohtH=WbQaHFFXkiRLWiC3t7hWHrA@mail.gmail.com> <CACJqLyZ=Q4rNHZ9y8-DEUdSqCAK8UyjVg9QXYFzxqTf_Rvf-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:54929 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbdKNNGh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 08:06:37 -0500
Received: by mail-qk0-f178.google.com with SMTP id n3so5142437qkn.11
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 05:06:36 -0800 (PST)
In-Reply-To: <CACJqLyZ=Q4rNHZ9y8-DEUdSqCAK8UyjVg9QXYFzxqTf_Rvf-hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: James Page <james.page@ubuntu.com>, Nathan Cutler <ncutler@suse.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, "kchai@redhat.com" <kchai@redhat.com>

On Tue, Nov 14, 2017 at 8:58 PM, Haomai Wang <haomai@xsky.com> wrote:
>
> Haomai Wang <haomai@xsky.com>=E4=BA=8E2017=E5=B9=B411=E6=9C=8814=E6=97=A5=
 =E5=91=A8=E4=BA=8C20:57=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>> kefu chai <tchaikov@gmail.com>=E4=BA=8E2017=E5=B9=B411=E6=9C=8814=E6=97=
=A5 =E5=91=A8=E4=BA=8C20:51=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On Mon, Nov 13, 2017 at 5:29 PM, kefu chai <tchaikov@gmail.com> wrote:
>>> > On Sat, Nov 11, 2017 at 1:47 AM, Sage Weil <sweil@redhat.com> wrote:
>>> >> We noticed a big performance regression when switching some code to
>>> >> use list::size() because although C++11 promizes that it is O(1), so=
me
>>> >> of
>>> >> the libstdc++'s out there are still O(n).  This PR aims to fix that
>>> >>
>>> >>         https://github.com/ceph/ceph/pull/18863
>>> >>
>>> >> by adding the various devtoolset packages as dependencies to pull in
>>> >> updated build toolchains.  For el7 that's
>>> >> devtoolset-7-{binutils,gcc-c++}.
>>> >>
>>>
>>> when running the binaries built using GCC 5.1 in an env where an old
>>> libstdc++ (typically comes with GCC 4.8):
>>>
>>> $ rados
>>> rados: relocation error: /usr/lib/ceph/libceph-common.so.0: symbol
>>> _ZTINSt8ios_base7failureB5cxx11E, version GLIBCXX_3.4.21 not defined
>>> in file libstdc++.so.6 with link time reference
>>>
>>> because libstdc++ introduced a new ABI which is incompatible with the o=
ld
>>> one.
>>> see https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html
>>> and https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi/=
 .
>>>
>>> in other words, we need to either 1) link statically with libstdc++.so =
or
>>> 2) include it in librados2 on distros with GCC version less than 5.1.
>>> because
>>> ceph-osd (and other daemons packages) =3D> ceph-base =3D> ceph-common =
=3D>
>>> python-rados =3D> librados2.
>>>
>>> i think the 2) approach is better. what do you think?
>>
>>
>> Do we consider to keep it? I checked the usage of std::c++
>
> list
>
>> , most is ok. Large list only used by pglog which is newly introdeced
>>

i guess by "keep it", what you mean is to keep using whatever the
toolchain comes with the distro.

yeah, we *can* live with it. but a standard conforming C++
implementation can save us more time
in long term. it took me at least 1 whole day in total to understand
that 1) the std::regex in GCC 4.8
is incomplete and buggy 2) list::size() in GCC 4.8 is O(n).

the list will be growing over the time. i am sure.

>>>
>>>
>>> >> I'm not sure what the requirement for deb-based distros is.
>>> >> ubuntu-toolchain-r?
>>> >
>>> > for ubuntu trusty, yes. for old stable (jessie) of debian, not sure i=
f
>>> > "apt-get -t experimental" works or not.
>>> >
>>> >>
>>> >> My preference would to move our build requirements forward so that y=
ou
>>> >> have to have a modern libstdc++ in order to build, allowing us to ma=
ke
>>> >> C++11-ish assumptions (like an O(1) list::size()).
>>> >>
>>> >> 1) Is this needed for xenial, or just trusty?
>>> >
>>> > it's just trusty. xenial comes with gcc 5.3.1, see
>>> >
>>> > https://packages.ubuntu.com/search?keywords=3Dgcc&searchon=3Dnames&su=
ite=3Dxenial&section=3Dall.
>>> >
>>> >>
>>> >> 2) If only trusty, should we do something weird here to keep
>>> >> buliding for it post-luminous, or can we (finally!) drop the trusty
>>> >> builds?
>>> >
>>> > i'd vote for dropping it. but if we need to stick with trusty, here
>>> > comes the weird thing: https://github.com/ceph/ceph-build/pull/914 =
=3D)
>>> >
>>> >>
>>> >> sage
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>>> >> in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> >
>>> >
>>> >
>>> > --
>>> > Regards
>>> > Kefu Chai
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
