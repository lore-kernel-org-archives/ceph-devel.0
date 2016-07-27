From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: static member variable in libcommon and double free
Date: Wed, 27 Jul 2016 00:39:13 +0000
Message-ID: <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:53701
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752319AbcG0AjR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 20:39:17 -0400
In-Reply-To: <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>, kefu chai <tchaikov@gmail.com>
Cc: John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I don't think is the problem that John and Kefu described.

Seems that  the problem is that there are two dynamic libraries that think each one of them is responsible for static run-time initialization of the same global variable. This violates the "One Definition Rule".

I'm guessing that the source of the problem is that the AsyncMessager.cc file is included twice, one in each library. If so, then the solution is to break out the offending *.cc file into a separate third library that's linked in the right combination with the others so that there's no duplication.

I have no idea why this appears to work with autotools.


Allen Samuels
SanDisk |a Western Digital brand
951 SanDisk Drive, Milpitas, CA 95035
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Jesse Williamson
> Sent: Tuesday, July 26, 2016 5:12 PM
> To: kefu chai <tchaikov@gmail.com>
> Cc: John Spray <jspray@redhat.com>; ceph-devel@vger.kernel.org
> Subject: Re: static member variable in libcommon and double free
> 
> 
> Folks,
> 
> I hope this will help.
> 
> Three are some issues that you need to know about when you're writing
> computer programs in C++. Before you decide to change away from the
> whole
> structure, consider what it is currently accomplishing.
> 
> Here is one of them. It may be exactly what you're running in to:
> https://isocpp.org/wiki/faq/ctors#static-init-order
> 
> Please feel free to ask questions.
> 
> -Jesse
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
