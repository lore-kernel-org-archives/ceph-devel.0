From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Build failed in Jenkins: ceph-master #1758
Date: Fri, 9 Feb 2018 17:13:27 +0100
Message-ID: <bb1f8624-4776-981b-5c0e-5c6d676f5eb5@digiware.nl>
References: <1275455898.55.1518102782484.JavaMail.jenkins@cephdev.digiware.nl>
 <dfc202fa-e5d3-1d3f-99be-86eb87a20dd9@digiware.nl>
 <CAJE9aONEDL0GBJMD+pA4GHQf9-Kjc8D9A0n5o4G3bCKLU3U2QA@mail.gmail.com>
 <CAJE9aONPSJBKpixjrM3J+3tgDVrZicWUU=Mfj28tZJpzLqq4tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:27115 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeBIQNa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:13:30 -0500
In-Reply-To: <CAJE9aONPSJBKpixjrM3J+3tgDVrZicWUU=Mfj28tZJpzLqq4tQ@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 9-2-2018 16:37, kefu chai wrote:
> On Fri, Feb 9, 2018 at 11:36 AM, kefu chai <tchaikov@gmail.com> wrote:
>> On Thu, Feb 8, 2018 at 11:19 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi Kefu,
>>>
>>> Clang complains since your commit:
>>> https://github.com/ceph/ceph/commit/0e0d0cd8d1adee998109c2714ed04f43b3212d7e
>>>
>>> about:
>>> /home/jenkins/workspace/ceph-master/src/test/librados/lock.cc:24:33:
>>> error: no template named 'invoke_result_t' in namespace 'std'
>>>          typename Return = std::invoke_result_t<Func, Args...>>
>>>                            ~~~~~^
>>> 1 error generated.
>>> gmake[2]: ***
>>> [src/test/librados/CMakeFiles/ceph_test_rados_api_lock.dir/build.make:63:
>>> src/test/librados/CMakeFiles/ceph_test_rados_api_lock.dir/lock.cc.o] Error 1
>>>
>>> Suggestions on how to fix this?
>>>
>>
>> could you give a spin of https://github.com/ceph/ceph/pull/20379 ?
>> sorry for the inconvenience.
> 
> 
> also, what is your clang version?

Clang is 5.0 on the jenkins box. So it should do most/all c++17 stuff.
But I guess the problem is in the includes...

grepping in invoke_result_t gave a hit in the .svn source tree, so I
guess I just might need to install the most recent updates.

--WjW


% clang -v
FreeBSD clang version 5.0.0 (tags/RELEASE_500/final 312559) (based on
LLVM 5.0.0svn)
Target: x86_64-unknown-freebsd12.0
Thread model: posix
InstalledDir: /usr/bin


