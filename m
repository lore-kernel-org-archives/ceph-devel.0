From: kefu chai <tchaikov@gmail.com>
Subject: Re: build on centos-7 and trusty
Date: Sat, 9 Dec 2017 20:45:34 +0800
Message-ID: <CAJE9aOMazhRniBRHLGa23PCdfQuhRLvafoNtSsX6ZtKF8BY7pA@mail.gmail.com>
References: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
 <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com>
 <alpine.DEB.2.11.1712081616250.2838@piezo.novalocal> <CAJE9aOOxtTOJpjGYmh2FpLg8kLG68yfN4uKHaFf_8y1tZSSTCw@mail.gmail.com>
 <CAJE9aOMtB8rST75ygg3HWDJceJ4OF6=B_aH8_6cG+GgJ-ndzCw@mail.gmail.com>
 <CAJE9aOP8uQaAeBvuB3e-W6MsWdpUcwbgtXPG=3D6Kw-b=o93oQ@mail.gmail.com> <CAJE9aOOw-T=CkeR3Jab=z-JsctWgSe=1h5w0w7j-XFztTd0FDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36647 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdLIMpf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Dec 2017 07:45:35 -0500
Received: by mail-qk0-f177.google.com with SMTP id t187so2006818qkh.3
        for <ceph-devel@vger.kernel.org>; Sat, 09 Dec 2017 04:45:35 -0800 (PST)
In-Reply-To: <CAJE9aOOw-T=CkeR3Jab=z-JsctWgSe=1h5w0w7j-XFztTd0FDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Casey Bodley <cbodley@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Dec 9, 2017 at 5:57 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Sat, Dec 9, 2017 at 5:55 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Sat, Dec 9, 2017 at 1:11 AM, kefu chai <tchaikov@gmail.com> wrote:
>>> On Sat, Dec 9, 2017 at 12:58 AM, kefu chai <tchaikov@gmail.com> wrote:
>>>> On Sat, Dec 9, 2017 at 12:16 AM, Sage Weil <sage@newdream.net> wrote:
>>>>> On Fri, 8 Dec 2017, Casey Bodley wrote:
>>>>>> Thanks Kefu! is there anything more we need to do before turning on =
-std=3Dc++14?
>>>>
>>>> not sure, i will check the C++14 support of GCC-6.
>>>
>>> also i need to confirm that the generated binaries do not require the
>>> libstdc++ symbols not offered by the libstdc++ shipped by xenial
>>> first.
>
> bin/rados is compiled using gcc-7 on a ubuntu/xenial system:
>
>>
>> kefu@7e8e193067e5$ bin/rados
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `CXXABI_1.3.8' not found (required by bin/rados)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.21' not found (required by bin/rados)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `CXXABI_1.3.8' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libradosstriper.so.1)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.22' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libradosstriper.so.1)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.21' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libradosstriper.so.1)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `CXXABI_1.3.8' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/librados.so.2)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.22' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/librados.so.2)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.21' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/librados.so.2)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `CXXABI_1.3.8' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libceph-common.so.0)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.22' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libceph-common.so.0)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.20' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libceph-common.so.0)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `CXXABI_1.3.9' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libceph-common.so.0)
>> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
>> `GLIBCXX_3.4.21' not found (required by
>> /var/ceph/ceph-ubuntu-16.04-kefu/build/lib/libceph-common.so.0)
>>
>> so, we need to link against libstdc++ statically.

https://github.com/ceph/ceph/pull/19418 and
https://github.com/ceph/ceph-build/pull/936 should address this.

>>
>>>
>>>>
>>>>>
>>>>> Have we addressed the aarch64 build question?  Is a sufficiently new
>>>>> toolchain available?
>>>
>>> forgot to mention, yes. that's GCC-6.
>>>
>>>>
>>>> i am copying the my reply on https://github.com/ceph/ceph/pull/19403 h=
ere:
>>>>
>>>> sadly, centos community does not have SCL repo ready for aarch64:
>>>> http://mirror.centos.org/centos/7/sclo/: x86_64 only. and the testing
>>>> repo only has devtools-6, see
>>>> https://buildlogs.centos.org/centos/7/sclo/aarch64/rh/, the
>>>> https://buildlogs.centos.org/centos/7/sclo/aarch64/rh/devtoolset-7/ is
>>>> empty!
>>>>
>>>> but RHEL does have the support for developer toolset of aarch64, see
>>>> https://developers.redhat.com/blog/2017/10/25/announcing-release-softw=
are-collections-developer-toolset-new-compilers/
>>>>
>>>>> New architecture support
>>>>>
>>>>> In recognition that different CPU architectures solve different IT pr=
oblems, Red Hat is now supporting additional architectures as part of Red H=
at Software Collections 3. In addition to x86_64, the curated, supported co=
mponents in Red Hat Software Collections 3 and Red Hat Developer Toolset 7 =
are now available across 64-bit ARM architecture (aarch64), IBM z Systems a=
nd IBM Power, little endian. This extends the ability of IT organizations t=
o build supported enterprise applications using the latest stable open sour=
ce tools on the architecture that meets their unique needs.
>>>>>
>>>>
>>>> so, if we have the luxury to use RHEL for building aarch64 binaries,
>>>> we are good. if all we have is CentOS, either we need to build the DTS
>>>> by ourselves, or we should stick with GCC-6.
>>>>
>>>> <strike>also, i have not reached out to centos community on this.
>>>> probably i am just missing something.</strike>
>>>>
>>>> i just found this:
>>>> https://lists.centos.org/pipermail/arm-dev/2016-July/002247.html, and
>>>> https://bugs.centos.org/view.php?id=3D14078&nbn=3D1
>>>>
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>> On Fri, Dec 8, 2017 at 12:28 AM, kefu chai <tchaikov@gmail.com> wrot=
e:
>>>>>> > hi developers building master and mimic-dev1 on centos-7 and/or tr=
usty,
>>>>>> >
>>>>>> > please use install-deps.sh to install the gcc-7 for compiling Ceph=
. as
>>>>>> > from now on, we will need GCC >=3D 5.1 [1] for better C++11 suppor=
t.
>>>>>> >
>>>>>> > cheers,
>>>>>> >
>>>>>> > ---
>>>>>> > [1] https://github.com/ceph/ceph/pull/19344
>>>>>> >
>>>>>> > --
>>>>>> > Regards
>>>>>> > Kefu Chai
>>>>>> > --
>>>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>>>> > the body of a message to majordomo@vger.kernel.org
>>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Regards
>>>> Kefu Chai
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>>
>>
>> --
>> Regards
>> Kefu Chai
>
>
>
> --
> Regards
> Kefu Chai



--=20
Regards
Kefu Chai
