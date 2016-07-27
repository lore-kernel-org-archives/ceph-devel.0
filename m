From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Wed, 27 Jul 2016 11:54:33 +1000
Message-ID: <20160727015433.GB22132@rskikr.localdomain>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com>
 <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34983 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcG0Byp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 21:54:45 -0400
Received: by mail-pf0-f170.google.com with SMTP id x72so5284523pfd.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2016 18:54:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, kefu chai <tchaikov@gmail.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2016 at 12:39:13AM +0000, Allen Samuels wrote:
> I don't think is the problem that John and Kefu described.
> 
> Seems that  the problem is that there are two dynamic libraries that think each one of them is responsible for static run-time initialization of the same global variable. This violates the "One Definition Rule".

I agree, I believe this is a violation of the ODR as well.

> 
> I'm guessing that the source of the problem is that the AsyncMessager.cc file is included twice, one in each library. If so, then the solution is to break out the offending *.cc file into a separate third library that's linked in the right combination with the others so that there's no duplication.
> 

I believe the problem can also be solved with a static member function or a
wrapper function for the static variable. I tried this and it appears to
resolve the issue.

It would be possible to audit use of such variables using nm or objdump but
this might be a bit difficult to maintain?

Since this is easy to reproduce it would also be simple to write a test to
check for this specific issue along the lines of the following.

$ g++ -O2 -x c++ - -Wl,--rpath=./lib -L./lib -lrados -lcephfs<<EOF
int main(int, char**)
{
  return 0;
}
EOF

./a.out
*** Error in `./a.out': double free or corruption (fasttop): 0x0000000000ad45c0 ***
...
Aborted (core dumped)

I'd be happy to create a test that covers this case if we think it is worthwhile?

> I have no idea why this appears to work with autotools.
> 
> 
> Allen Samuels
> SanDisk |a Western Digital brand
> 951 SanDisk Drive, Milpitas, CA 95035
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Jesse Williamson
> > Sent: Tuesday, July 26, 2016 5:12 PM
> > To: kefu chai <tchaikov@gmail.com>
> > Cc: John Spray <jspray@redhat.com>; ceph-devel@vger.kernel.org
> > Subject: Re: static member variable in libcommon and double free
> > 
> > 
> > Folks,
> > 
> > I hope this will help.
> > 
> > Three are some issues that you need to know about when you're writing
> > computer programs in C++. Before you decide to change away from the
> > whole
> > structure, consider what it is currently accomplishing.
> > 
> > Here is one of them. It may be exactly what you're running in to:
> > https://isocpp.org/wiki/faq/ctors#static-init-order
> > 
> > Please feel free to ask questions.
> > 
> > -Jesse
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers,
Brad
