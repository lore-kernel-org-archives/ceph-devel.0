From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 14 Nov 2017 15:04:34 -0700
Message-ID: <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com> <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43691 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbdKNWEf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 17:04:35 -0500
Received: by mail-ua0-f196.google.com with SMTP id q18so13972401uaa.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 14:04:35 -0800 (PST)
In-Reply-To: <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, "kchai@redhat.com" <kchai@redhat.com>, Nathan Cutler <ncutler@suse.com>, James Page <james.page@ubuntu.com>

On Tue, Nov 14, 2017 at 5:49 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Mon, Nov 13, 2017 at 5:29 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Sat, Nov 11, 2017 at 1:47 AM, Sage Weil <sweil@redhat.com> wrote:
>>> We noticed a big performance regression when switching some code to
>>> use list::size() because although C++11 promizes that it is O(1), some of
>>> the libstdc++'s out there are still O(n).  This PR aims to fix that
>>>
>>>         https://github.com/ceph/ceph/pull/18863
>>>
>>> by adding the various devtoolset packages as dependencies to pull in
>>> updated build toolchains.  For el7 that's devtoolset-7-{binutils,gcc-c++}.
>>>
>
> when running the binaries built using GCC 5.1 in an env where an old
> libstdc++ (typically comes with GCC 4.8):
>
> $ rados
> rados: relocation error: /usr/lib/ceph/libceph-common.so.0: symbol
> _ZTINSt8ios_base7failureB5cxx11E, version GLIBCXX_3.4.21 not defined
> in file libstdc++.so.6 with link time reference
>
> because libstdc++ introduced a new ABI which is incompatible with the old one.
> see https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html
> and https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi/ .
>
> in other words, we need to either 1) link statically with libstdc++.so or
> 2) include it in librados2 on distros with GCC version less than 5.1. because
> ceph-osd (and other daemons packages) => ceph-base => ceph-common =>
> python-rados => librados2.

For 1), what does that imply for packages' debuginfo sizes?

For 2), where would libstdc++.so ship in the filesystem? What does
that mean for other applications that would load libstdc++.so and also
link with ceph?

- Ken
