From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: build on centos-7 and trusty
Date: Fri, 8 Dec 2017 12:11:53 -0500
Message-ID: <20171208171152.GA22621@ultraspiritum.eng.arb.redhat.com>
References: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
 <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com>
 <alpine.DEB.2.11.1712081616250.2838@piezo.novalocal>
 <CAJE9aOOxtTOJpjGYmh2FpLg8kLG68yfN4uKHaFf_8y1tZSSTCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdLHRLy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 8 Dec 2017 12:11:54 -0500
Content-Disposition: inline
In-Reply-To: <CAJE9aOOxtTOJpjGYmh2FpLg8kLG68yfN4uKHaFf_8y1tZSSTCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Casey Bodley <cbodley@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/12/2017, kefu chai wrote:
> not sure, i will check the C++14 support of GCC-6.

The feature matrix says it does, and I've used GCC6 for C++14, so that should be fine.

> so, if we have the luxury to use RHEL for building aarch64 binaries,
> we are good. if all we have is CentOS, either we need to build the DTS
> by ourselves, or we should stick with GCC-6.

This would be great if we could swing it.

> <strike>also, i have not reached out to centos community on this.
> probably i am just missing something.</strike>
> 
> i just found this:
> https://lists.centos.org/pipermail/arm-dev/2016-July/002247.html, and
> https://bugs.centos.org/view.php?id=14078&nbn=1

Would it be worth chiming in and saying we as a project would make active
use of it?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
