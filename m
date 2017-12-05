From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 5 Dec 2017 17:58:14 +0100
Message-ID: <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz>
 <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:10746 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbdLEQ6O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 11:58:14 -0500
In-Reply-To: <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 5-12-2017 17:40, Adam C. Emerson wrote:
> On 05/12/2017, kefu chai wrote:
>> once all trusty testnodes are re-imaged with xenial, i will try to
>> remove the trusty build support on ceph/ceph-build. BTW, if we want to
>> use gcc-7 on xenial, which ships GCC 5.3, we can apply the same fix on
>> it also.
> 
> If we can get GCC-7 on Xenial and there's a way for people building
> Ceph to get it without too much trouble, then I think we should use
> GCC-7.
> 
> In general, so long as they are reasonably gettable on our target
> operating systems, I think we ought to target the latest stable
> release stream of GCC and Clang.
> 

"somebody" dropped the Clang word. :)

Dare I then suggest that some of the build be done against Clang whilest 
building PRs also.

--WjW

