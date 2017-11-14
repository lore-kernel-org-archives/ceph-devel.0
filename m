From: kefu chai <tchaikov@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 14 Nov 2017 20:49:52 +0800
Message-ID: <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal> <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:50988 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbdKNMtx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 07:49:53 -0500
Received: by mail-qk0-f182.google.com with SMTP id p7so23827417qkd.7
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 04:49:53 -0800 (PST)
In-Reply-To: <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, "kchai@redhat.com" <kchai@redhat.com>, Nathan Cutler <ncutler@suse.com>, James Page <james.page@ubuntu.com>

On Mon, Nov 13, 2017 at 5:29 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Sat, Nov 11, 2017 at 1:47 AM, Sage Weil <sweil@redhat.com> wrote:
>> We noticed a big performance regression when switching some code to
>> use list::size() because although C++11 promizes that it is O(1), some of
>> the libstdc++'s out there are still O(n).  This PR aims to fix that
>>
>>         https://github.com/ceph/ceph/pull/18863
>>
>> by adding the various devtoolset packages as dependencies to pull in
>> updated build toolchains.  For el7 that's devtoolset-7-{binutils,gcc-c++}.
>>

when running the binaries built using GCC 5.1 in an env where an old
libstdc++ (typically comes with GCC 4.8):

$ rados
rados: relocation error: /usr/lib/ceph/libceph-common.so.0: symbol
_ZTINSt8ios_base7failureB5cxx11E, version GLIBCXX_3.4.21 not defined
in file libstdc++.so.6 with link time reference

because libstdc++ introduced a new ABI which is incompatible with the old one.
see https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html
and https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi/ .

in other words, we need to either 1) link statically with libstdc++.so or
2) include it in librados2 on distros with GCC version less than 5.1. because
ceph-osd (and other daemons packages) => ceph-base => ceph-common =>
python-rados => librados2.

i think the 2) approach is better. what do you think?


>> I'm not sure what the requirement for deb-based distros is.
>> ubuntu-toolchain-r?
>
> for ubuntu trusty, yes. for old stable (jessie) of debian, not sure if
> "apt-get -t experimental" works or not.
>
>>
>> My preference would to move our build requirements forward so that you
>> have to have a modern libstdc++ in order to build, allowing us to make
>> C++11-ish assumptions (like an O(1) list::size()).
>>
>> 1) Is this needed for xenial, or just trusty?
>
> it's just trusty. xenial comes with gcc 5.3.1, see
> https://packages.ubuntu.com/search?keywords=gcc&searchon=names&suite=xenial&section=all.
>
>>
>> 2) If only trusty, should we do something weird here to keep
>> buliding for it post-luminous, or can we (finally!) drop the trusty
>> builds?
>
> i'd vote for dropping it. but if we need to stick with trusty, here
> comes the weird thing: https://github.com/ceph/ceph-build/pull/914 =)
>
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai
