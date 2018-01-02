From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 2 Jan 2018 08:28:45 -0700
Message-ID: <CALqRxCyhG6DrkpmoHQbS5TyATEXnwogSq5S5yPdcEKFAMiiq4Q@mail.gmail.com>
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
 <CAJE9aOM2-G9sewdUchUrxHosRp17RUSS_CvzV1b4N7qPdRvV8w@mail.gmail.com>
 <CAJE9aOOOOROXmPXcwHJo_31-qdt9HmFdcpHuGZMarncfTpGOQA@mail.gmail.com>
 <CAJACTudfCvShHvZJAAZvqnCDifyR7NoEF__xsd+wRek-xW0jGA@mail.gmail.com> <CAJE9aOMeKX++y9+ktEN=ZJ=zua1zCVuMSdmV=ZCBUF_kp2qcBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34876 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeABP2q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 10:28:46 -0500
Received: by mail-vk0-f50.google.com with SMTP id o73so18042394vkd.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 07:28:46 -0800 (PST)
In-Reply-To: <CAJE9aOMeKX++y9+ktEN=ZJ=zua1zCVuMSdmV=ZCBUF_kp2qcBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Xuehan Xu <xxhdx1985126@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, Dec 26, 2017 at 4:24 AM, kefu chai <tchaikov@gmail.com> wrote:
> right. unless we swing our own homebrew gcc-7.

Can we ask the devtoolset maintainers to change this option?

I imagine they would be interested in this type of feedback from the field.

- Ken
