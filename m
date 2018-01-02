From: Sage Weil <sweil@redhat.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Tue, 2 Jan 2018 17:31:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801021722370.8186@piezo.novalocal>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal> <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz> <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal> <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com> <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl> <CAJ4mKGYxEeGKFonx_UBbYMiTcPh-4yGt8VuryoBFSQCbj8Pz-A@mail.gmail.com> <05f1ef85-e307-7c6b-17be-dbebe43dc824@digiware.nl>
 <CAJACTufEmyB_r0HKdF_CZH1kSC+e4gkxpJJPjn=mu-stFJkdhQ@mail.gmail.com> <CAJE9aOM2-G9sewdUchUrxHosRp17RUSS_CvzV1b4N7qPdRvV8w@mail.gmail.com> <CAJE9aOOOOROXmPXcwHJo_31-qdt9HmFdcpHuGZMarncfTpGOQA@mail.gmail.com> <CAJACTudfCvShHvZJAAZvqnCDifyR7NoEF__xsd+wRek-xW0jGA@mail.gmail.com>
 <CAJE9aOMeKX++y9+ktEN=ZJ=zua1zCVuMSdmV=ZCBUF_kp2qcBw@mail.gmail.com> <CALqRxCyhG6DrkpmoHQbS5TyATEXnwogSq5S5yPdcEKFAMiiq4Q@mail.gmail.com> <CAJE9aOMLUUM=ja+L7QCLmuDsTGZtvRBNJ+RmoWRW=O2sCsjRMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeABRbO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 2 Jan 2018 12:31:14 -0500
In-Reply-To: <CAJE9aOMLUUM=ja+L7QCLmuDsTGZtvRBNJ+RmoWRW=O2sCsjRMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Xuehan Xu <xxhdx1985126@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Nathan Cutler <ncutler@suse.cz>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 2 Jan 2018, kefu chai wrote:
> On Tue, Jan 2, 2018 at 11:28 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> > On Tue, Dec 26, 2017 at 4:24 AM, kefu chai <tchaikov@gmail.com> wrote:
> >> right. unless we swing our own homebrew gcc-7.
> >
> > Can we ask the devtoolset maintainers to change this option?
> >
> > I imagine they would be interested in this type of feedback from the field.
> 
> https://git.centos.org/blob/rpms!devtoolset-7-gcc.git/2e5ef6c7934d4417e095855478736742b35bd0af/SPECS!gcc.spec#L1026

For reference,

```
  # Force the old ABI unconditionally, the new one does not work in the
  # libstdc++_nonshared.a model against RHEL 6/7 libstdc++.so.6.
  sed -i -e 's/\(define[[:blank:]]*_GLIBCXX_USE_DUAL_ABI[[:blank:]]*\)1/\10/' $f
```

> I think we need to think about this before sending any inquiries to them.

The problem I see is that it is impossible to write/build many native 
C++11 (or 14 or 17) apps with the toolchain since the old ABI precludes 
O(1) std::list.  

If I'm following the _nonshared thing, it's a feature that lets you build 
with teh new toolchain but deploy on systems with much older libstdc++ 
installed (new symbols are statically instead of dynamically linked).  
Is the problem with the "dual ABI" feature?

sage
