From: kefu chai <tchaikov@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 5 Dec 2017 22:53:00 +0800
Message-ID: <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz> <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45681 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdLEOxC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 09:53:02 -0500
Received: by mail-qt0-f193.google.com with SMTP id g10so1231908qtj.12
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 06:53:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, "kchai@redhat.com" <kchai@redhat.com>, James Page <james.page@ubuntu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 30, 2017 at 10:38 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 30 Nov 2017, Nathan Cutler wrote:
>> I thought we already agreed to drop Trusty in Mimic?
>
> I'm not sure we made any final decision, but I haven't seen anyone
> complain this time around, so I'd say let's do it!

good news, every one! we are now building ceph using gcc-7 on centos7
and trusty.

an example build with gcc-4.8 on trusty:
https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=trusty,DIST=trusty,MACHINE_SIZE=huge/13152//consoleFull
/// we have following warning message:
----8<----
CMake Warning at src/CMakeLists.txt:176 (message):
  performance regression is expected due to an O(n) implementation of
  'std::list::size()' in libstdc++ older than 5.1.0
------>8----
an example build with gcc-7 on trusty:
see https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=trusty,DIST=trusty,MACHINE_SIZE=huge/13156//consoleFull
/// the warning message is gone.

a build with gcc-7 on centos-7,
see https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/13155//consoleFull

once all trusty testnodes are re-imaged with xenial, i will try to
remove the trusty build support on ceph/ceph-build. BTW, if we want to
use gcc-7 on xenial, which ships GCC 5.3, we can apply the same fix on
it also.

the only issue is http://tracker.ceph.com/issues/22301. its fix is
pending on review.

-- 
Regards
Kefu Chai
