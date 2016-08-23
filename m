From: Wido den Hollander <wido@42on.com>
Subject: Re: Ceph Upgrade Issue
Date: Tue, 23 Aug 2016 20:44:36 +0200 (CEST)
Message-ID: <1953555259.2912.1471977877142@ox.pcextreme.nl>
References: <CAMDPVREGpHRimVhFvZy8VcptZsS2AXdiXvJ9xFbtmyZ5Ca1uOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:34145 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbcHWSol (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 14:44:41 -0400
In-Reply-To: <CAMDPVREGpHRimVhFvZy8VcptZsS2AXdiXvJ9xFbtmyZ5Ca1uOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>, ceph-devel@vger.kernel.org


> Op 23 augustus 2016 om 18:01 schreef Thipparapu Vijaykumar <thipparapu.vijaykumar@gmail.com>:
> 
> 
> Hi All,
>            I've a requirement where my existing ceph cluster need to
> run with the newly build ceph source with instrumented additional
> debugs.
>  Could anyone help me to achieve the above requirement?
> 

Why not build DEB or RPM packages from source and install them? That's usually a easy route to take in this case.

For DEB it's just:

$ dpkg-buildpackage

Wido

> 
> Thanks & Regards,
> Vijay Kumar.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
