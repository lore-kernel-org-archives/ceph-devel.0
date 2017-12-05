From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 5 Dec 2017 11:40:18 -0500
Message-ID: <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz>
 <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbdLEQkT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 11:40:19 -0500
Content-Disposition: inline
In-Reply-To: <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 05/12/2017, kefu chai wrote:
> once all trusty testnodes are re-imaged with xenial, i will try to
> remove the trusty build support on ceph/ceph-build. BTW, if we want to
> use gcc-7 on xenial, which ships GCC 5.3, we can apply the same fix on
> it also.

If we can get GCC-7 on Xenial and there's a way for people building
Ceph to get it without too much trouble, then I think we should use
GCC-7.

In general, so long as they are reasonably gettable on our target
operating systems, I think we ought to target the latest stable
release stream of GCC and Clang.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
