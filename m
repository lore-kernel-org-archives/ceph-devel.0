From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 5 Dec 2017 17:41:51 -0500
Message-ID: <20171205224151.GA14507@ultraspiritum.eng.arb.redhat.com>
References: <CAJE9aONaA7dmGWZRtD+SC=nk=JmFV1BU3ouRyAS9wag+HeDuCQ@mail.gmail.com>
 <CAJE9aOMpZgoFoad9j2Onsdza6iYQq8in2bqfiDRvgoQgh+2OMA@mail.gmail.com>
 <CALqRxCyVA5X326pDaC0iT-OhsmFiUvCc1dmVgAVj+LS9r=C8yA@mail.gmail.com>
 <CAJE9aOOHLD5fV=bGWHB35_1YTpn1vRoRAcvqKSKHp=f-ah9aJA@mail.gmail.com>
 <CAJE9aOP82bHGPuhmLeqFLg8PxenCskbO5PC7ymd5g7+zrFtvKA@mail.gmail.com>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz>
 <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com>
 <8f12d8bb-53de-e3e7-902a-9bd49938edb3@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbdLEWlx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 17:41:53 -0500
Content-Disposition: inline
In-Reply-To: <8f12d8bb-53de-e3e7-902a-9bd49938edb3@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: kefu chai <tchaikov@gmail.com>, Sage Weil <sweil@redhat.com>, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 05/12/2017, Nathan Cutler wrote:
[snip]
> This sounds like it is edging towards requiring GCC-7 to build master/Mimic?
> That seems kind of radical, but I don't see it posing any problem for
> openSUSE or SLES since I'm already using GCC-7 to build master/Mimic in OBS.

It is. Well, I didn't intend to edge toward it. I intended to suggest
outright:

If our target platforms have versions of GCC 7 and/or Clang 5 that we
can reasonably expect people to install, (and it looked like that's
the case for both CentOS and Ubuntu), then we should target GCC 7 and
Clang 5.

Having a narrower range of compilers we promise to support should
generally make our lives easier.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
