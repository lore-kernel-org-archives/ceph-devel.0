From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 5 Dec 2017 09:51:33 -0800
Message-ID: <CAJ4mKGYxEeGKFonx_UBbYMiTcPh-4yGt8VuryoBFSQCbj8Pz-A@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz> <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com> <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:34748 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLERvf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 12:51:35 -0500
Received: by mail-it0-f46.google.com with SMTP id m11so17763818iti.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 09:51:35 -0800 (PST)
In-Reply-To: <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, Dec 5, 2017 at 8:58 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 5-12-2017 17:40, Adam C. Emerson wrote:
>>
>> On 05/12/2017, kefu chai wrote:
>>>
>>> once all trusty testnodes are re-imaged with xenial, i will try to
>>> remove the trusty build support on ceph/ceph-build. BTW, if we want to
>>> use gcc-7 on xenial, which ships GCC 5.3, we can apply the same fix on
>>> it also.
>>
>>
>> If we can get GCC-7 on Xenial and there's a way for people building
>> Ceph to get it without too much trouble, then I think we should use
>> GCC-7.
>>
>> In general, so long as they are reasonably gettable on our target
>> operating systems, I think we ought to target the latest stable
>> release stream of GCC and Clang.

I was talking with Josh yesterday and he mentioned how newer C++
releases have a less stable ABI and we often need to ship out
libstdc++ with them. Would this change anything we care about?
(I, like, super don't care. But I also don't really know anything about it.)


> "somebody" dropped the Clang word. :)
>
> Dare I then suggest that some of the build be done against Clang whilest
> building PRs also.

I think we'd all love this. Maybe somebody with a vested interest in
Clang working properly and recent experience mucking around with our
build systems will submit a PR? :p
-Greg
