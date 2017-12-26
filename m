From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 26 Dec 2017 14:35:19 +0800
Message-ID: <CAJACTudfCvShHvZJAAZvqnCDifyR7NoEF__xsd+wRek-xW0jGA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz> <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com> <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl>
 <CAJ4mKGYxEeGKFonx_UBbYMiTcPh-4yGt8VuryoBFSQCbj8Pz-A@mail.gmail.com>
 <05f1ef85-e307-7c6b-17be-dbebe43dc824@digiware.nl> <CAJACTufEmyB_r0HKdF_CZH1kSC+e4gkxpJJPjn=mu-stFJkdhQ@mail.gmail.com>
 <CAJE9aOM2-G9sewdUchUrxHosRp17RUSS_CvzV1b4N7qPdRvV8w@mail.gmail.com> <CAJE9aOOOOROXmPXcwHJo_31-qdt9HmFdcpHuGZMarncfTpGOQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46355 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdLZGfU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Dec 2017 01:35:20 -0500
Received: by mail-ot0-f193.google.com with SMTP id v40so19934431ote.13
        for <ceph-devel@vger.kernel.org>; Mon, 25 Dec 2017 22:35:20 -0800 (PST)
In-Reply-To: <CAJE9aOOOOROXmPXcwHJo_31-qdt9HmFdcpHuGZMarncfTpGOQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks for your reply, kefu:-)

I checked /opt/rh/devtoolset-7/root/usr/include/c++/7/x86_64-redhat-linux/bits/c++config.h,
and saw the following configuration:

# define _GLIBCXX_USE_DUAL_ABI 0

#if ! _GLIBCXX_USE_DUAL_ABI
// Ignore any pre-defined value of _GLIBCXX_USE_CXX11_ABI
# undef _GLIBCXX_USE_CXX11_ABI
#endif

#ifndef _GLIBCXX_USE_CXX11_ABI
# define _GLIBCXX_USE_CXX11_ABI 0
#endif

It seems that no matter how we config MAKEFILE or CMakeFile,
_GLIBCXX_USE_CXX11_ABI would always be 0 under the circumstance.
So I think https://github.com/ceph/ceph/pull/18755 is still needed.

Is this right?

On 26 December 2017 at 00:38, kefu chai <tchaikov@gmail.com> wrote:
> On Mon, Dec 25, 2017 at 10:43 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Sat, Dec 23, 2017 at 5:46 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>> Hi, everyone.
>>>
>>> I'm using CentOS 7 with devtoolset-7 to build ceph. However, I found
>>> that the list::size() in my ceph executables is still counting the
>>> number of nodes. It's so odd, I googled it, and found that this may
>>> have something to do with _GLIBCXX_USE_CXX11_ABI. But even if I
>>> explicitly set _GLIBCXX_USE_CXX11_ABI to 1 when building ceph, the
>>> problem remains. It seems that _GLIBCXX_USE_CXX11_ABI is set to 0 by
>>> gcc no matter how I build the source code, even with
>>> -D_GLIBCXX_USE_CXX11_ABI=1.
>>
>> Xuehan, thanks for testing!
>>
>> turns out the gcc-7 in devtoolset is compiled with
>> "--with-default-libstdcxx-abi=gcc4-compatible", see the output of "g++
>> -v", so it is using "_GLIBCXX_USE_CXX11_ABI=0", you can by checking
>> /opt/rh/devtoolset-7/root/usr/include/c++/7/x86_64-redhat-linux/bits/c++config.h
>> .
>>
>> in other words, we still need https://github.com/ceph/ceph/pull/18755.
>
>
> hmm, probably not.
>
>  add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
>
> and
>
>  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fabi-version=0")
>
> might help. I will give it a try tomorrow.
>
>
>
> --
> Regards
> Kefu Chai
