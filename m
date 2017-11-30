From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: C++11, std::list::size(), and trusty
Date: Thu, 30 Nov 2017 12:00:29 +0100
Message-ID: <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53811 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdK3LAc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 06:00:32 -0500
In-Reply-To: <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, "kchai@redhat.com" <kchai@redhat.com>, Sage Weil <sweil@redhat.com>, James Page <james.page@ubuntu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I thought we already agreed to drop Trusty in Mimic?

On 11/30/2017 11:15 AM, kefu chai wrote:
> On Wed, Nov 15, 2017 at 2:47 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Wed, Nov 15, 2017 at 6:04 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>>> On Tue, Nov 14, 2017 at 5:49 AM, kefu chai <tchaikov@gmail.com> wrote:
>>>> On Mon, Nov 13, 2017 at 5:29 PM, kefu chai <tchaikov@gmail.com> wrote:
>>>>> On Sat, Nov 11, 2017 at 1:47 AM, Sage Weil <sweil@redhat.com> wrote:
>>>>>> We noticed a big performance regression when switching some code to
>>>>>> use list::size() because although C++11 promizes that it is O(1), some of
>>>>>> the libstdc++'s out there are still O(n).  This PR aims to fix that
>>>>>>
>>>>>>          https://github.com/ceph/ceph/pull/18863
>>>>>>
>>>>>> by adding the various devtoolset packages as dependencies to pull in
>>>>>> updated build toolchains.  For el7 that's devtoolset-7-{binutils,gcc-c++}.
>>>>>>
>>>>
>>>> when running the binaries built using GCC 5.1 in an env where an old
>>>> libstdc++ (typically comes with GCC 4.8):
>>>>
>>>> $ rados
>>>> rados: relocation error: /usr/lib/ceph/libceph-common.so.0: symbol
>>>> _ZTINSt8ios_base7failureB5cxx11E, version GLIBCXX_3.4.21 not defined
>>>> in file libstdc++.so.6 with link time reference
>>>>
>>>> because libstdc++ introduced a new ABI which is incompatible with the old one.
>>>> see https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html
>>>> and https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi/ .
>>>>
>>>> in other words, we need to either 1) link statically with libstdc++.so or
>>>> 2) include it in librados2 on distros with GCC version less than 5.1. because
>>>> ceph-osd (and other daemons packages) => ceph-base => ceph-common =>
>>>> python-rados => librados2.
>>>
>>> For 1), what does that imply for packages' debuginfo sizes?
>>
>> since we don't compile the source of libstdc++, i don't think this
>> will increase the size of debuginfo.
>>
>>>
>>> For 2), where would libstdc++.so ship in the filesystem? What does
>>> that mean for other applications that would load libstdc++.so and also
>>> link with ceph?
>>
>> if we just statically link libceph-common against libstdc++, and let
>> daemons link againt libceph-common, the problem will be solved. that's
>> actually 2) but after a second thought, i think it's a better
>> approach. please note, the daemons are linked against libceph-common
>> statically. [OT] we could let daemon link libceph-common dynamically,
>> but the downside is that the daemon will need to depend on a client
>> side library: librados2. which is a little bit weird. but the upside
>> is: this will shrink the size of debug-info and the size of daemons,
>> as the daemon will not include ceph-common statically.
> 
> i just confirmed with the devtoolset maintainer offline, that the bits
> not included by
> the base libstdc++ will be statically linked into the binary. and i
> verified this behavior
> on centos7. but this is not true, when it comes to trusty.
> 
> 
> $ bin/rados
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `CXXABI_1.3.8' not found (required by bin/rados)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `CXXABI_1.3.8' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/librados.so.2)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.21' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/librados.so.2)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.22' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/librados.so.2)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `CXXABI_1.3.8' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libradosstriper.so.1)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.21' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libradosstriper.so.1)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.22' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libradosstriper.so.1)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `CXXABI_1.3.8' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libceph-common.so.0)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.22' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libceph-common.so.0)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.21' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libceph-common.so.0)
> bin/rados: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
> `GLIBCXX_3.4.20' not found (required by
> /var/ceph/ceph-ubuntu-14.04-kefu/build/lib/libceph-common.so.0)
> 
> so, an obvious solution is to use "-static-libstdc++"[1] on trusty,
> libceph-common is a good candidate for where the libstdc++ is
> included. or just drop the support of it. thoughts?
> 
> ---
> [1] https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html
> 

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
