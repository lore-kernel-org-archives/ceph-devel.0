From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Tue, 26 Jul 2016 22:33:51 -0400
Message-ID: <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com> <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160727015433.GB22132@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:32934 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbcG0CeW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2016 22:34:22 -0400
Received: by mail-qt0-f181.google.com with SMTP id w38so22600208qtb.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2016 19:34:21 -0700 (PDT)
In-Reply-To: <20160727015433.GB22132@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Jesse Williamson <jwilliamson@suse.de>, kefu chai <tchaikov@gmail.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 26, 2016 at 9:54 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>> I'm guessing that the source of the problem is that the AsyncMessager.cc file is included twice, one in each library. If so, then the solution is to break out the offending *.cc file into a separate third library that's linked in the right combination with the others so that there's no duplication.
>>
>
> I believe the problem can also be solved with a static member function or a
> wrapper function for the static variable. I tried this and it appears to
> resolve the issue.

Another solution is to use anonymous namespaces which will force the
symbol to be local to the translation unit.

> It would be possible to audit use of such variables using nm or objdump but
> this might be a bit difficult to maintain?

There was a proposal to add -Wglobal-variable to gcc about this same
issue but it didn't appear to go anywhere:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46097

> Since this is easy to reproduce it would also be simple to write a test to
> check for this specific issue along the lines of the following.
>
> $ g++ -O2 -x c++ - -Wl,--rpath=./lib -L./lib -lrados -lcephfs<<EOF
> int main(int, char**)
> {
>   return 0;
> }
> EOF

Ideally the shared libraries should not export any global variables.
There are numerous bugs other than double delete. For example, if a
global variable (address) is used as a sentinel in librados and then
later libceph is loaded defining a new sentinel (same type), any data
structures created relying on the address of the previous sentinel may
break. [This is not purely limited to global variables or even C++,
you can also have magnificent breakage if functions defined in a
common static library with external linkage are replaced. In that
case, code which depends on variables with local linkage may also
break. Ultimately, the fix is to explicitly export only the desired
functions of some API in the shared library.]

A test which checks for the double delete is a good start...

-- 
Patrick Donnelly
