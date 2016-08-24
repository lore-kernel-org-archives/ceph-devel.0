From: Wido den Hollander <wido@42on.com>
Subject: Re: Ceph Upgrade Issue
Date: Wed, 24 Aug 2016 16:00:31 +0200 (CEST)
Message-ID: <718776942.3031.1472047231643@ox.pcextreme.nl>
References: <CAMDPVREGpHRimVhFvZy8VcptZsS2AXdiXvJ9xFbtmyZ5Ca1uOg@mail.gmail.com>
 <1953555259.2912.1471977877142@ox.pcextreme.nl>
 <CAMDPVRGiW6DcBBkr2WBHJmMREcbNDfHc9PqBKUN0J0XsS5s+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:58863 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756281AbcHXOAi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 10:00:38 -0400
In-Reply-To: <CAMDPVRGiW6DcBBkr2WBHJmMREcbNDfHc9PqBKUN0J0XsS5s+CQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>
Cc: ceph-devel@vger.kernel.org


> Op 24 augustus 2016 om 15:06 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
> 
> 
> Hi Wido,
> 
>            Thanks for reply. After building DEB packages from the Ceph
> source, could you please tell me  how  to install all those DEB
> packages on entire cluster.
> 

Just like you do with any other DEB. Copy it to the machines and install it with dpkg.

Wido

> Thanks & Regards,
> Vijay Kumar.
> 
> On Wed, Aug 24, 2016 at 12:14 AM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 23 augustus 2016 om 18:01 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
> >>
> >>
> >> Hi All,
> >>            I've a requirement where my existing ceph cluster need to
> >> run with the newly build ceph source with instrumented additional
> >> debugs.
> >>  Could anyone help me to achieve the above requirement?
> >>
> >
> > Why not build DEB or RPM packages from source and install them? That's usually a easy route to take in this case.
> >
> > For DEB it's just:
> >
> > $ dpkg-buildpackage
> >
> > Wido
> >
> >>
> >> Thanks & Regards,
> >> Vijay Kumar.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
