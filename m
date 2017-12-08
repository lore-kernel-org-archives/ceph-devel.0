From: Sage Weil <sage@newdream.net>
Subject: Re: build on centos-7 and trusty
Date: Fri, 8 Dec 2017 16:16:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712081616250.2838@piezo.novalocal>
References: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com> <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:38177 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754206AbdLHQQv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 11:16:51 -0500
In-Reply-To: <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 8 Dec 2017, Casey Bodley wrote:
> Thanks Kefu! is there anything more we need to do before turning on -std=c++14?

Have we addressed the aarch64 build question?  Is a sufficiently new 
toolchain available?

sage


> 
> On Fri, Dec 8, 2017 at 12:28 AM, kefu chai <tchaikov@gmail.com> wrote:
> > hi developers building master and mimic-dev1 on centos-7 and/or trusty,
> >
> > please use install-deps.sh to install the gcc-7 for compiling Ceph. as
> > from now on, we will need GCC >= 5.1 [1] for better C++11 support.
> >
> > cheers,
> >
> > ---
> > [1] https://github.com/ceph/ceph/pull/19344
> >
> > --
> > Regards
> > Kefu Chai
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
