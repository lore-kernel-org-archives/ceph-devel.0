From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: how to disable all complier optimizations
Date: Thu, 2 Feb 2017 09:00:21 -0500 (EST)
Message-ID: <2097727258.99392049.1486044021323.JavaMail.zimbra@redhat.com>
References: <914C48E9796C6046B6424CA69C30AB3B03BBBA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com> <CACKY0b95F8GJRqG=ZOgvY2Exh6jzJ4YENOO40wfWBBF=LC+VRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:54453 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdBBOAY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 09:00:24 -0500
In-Reply-To: <CACKY0b95F8GJRqG=ZOgvY2Exh6jzJ4YENOO40wfWBBF=LC+VRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

FWIW, I use:

  -DCMAKE_CXX_FLAGS="-O0 -g3 -gdwarf-4" -DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4"

Matt

----- Original Message -----
> From: "liuchang0812" <liuchang0812@gmail.com>
> To: "Ramesh Chander" <Ramesh.Chander@sandisk.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 1, 2017 12:02:34 PM
> Subject: Re: how to disable all complier optimizations
> 
> hi, try this
> 
> cmake -DCMAKE_BUILD_TYPE=Debug ..
> 
> 2017-02-01 19:48 GMT+08:00 Ramesh Chander <Ramesh.Chander@sandisk.com>:
> > I am trying to compile ceph-osd and debug it but keep getting "optimized
> > out " message for local variables.
> >
> > How to I disable compiler optimization for ceph-osd ?
> >
> > Thanks in advance.
> >
> > -Ramesh
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is
> > intended only for the use of the designated recipient(s) named above. If
> > the reader of this message is not the intended recipient, you are hereby
> > notified that you have received this message in error and that any review,
> > dissemination, distribution, or copying of this message is strictly
> > prohibited. If you have received this communication in error, please
> > notify the sender by telephone or e-mail (as shown above) immediately and
> > destroy any and all copies of this message in your possession (whether
> > hard copies or electronically stored copies).
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
