From: kefu chai <tchaikov@gmail.com>
Subject: Re: static member variable in libcommon and double free
Date: Wed, 27 Jul 2016 20:04:31 +0800
Message-ID: <CAJE9aONRiJaOBEkOGhZBUAy6=_cEFTd0hCgmaUyOQ5=a8dvCvQ@mail.gmail.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com> <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160727015433.GB22132@rskikr.localdomain> <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33844 "EHLO
	mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcG0MEd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 08:04:33 -0400
Received: by mail-qt0-f173.google.com with SMTP id u25so27907325qtb.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2016 05:04:32 -0700 (PDT)
In-Reply-To: <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Jesse Williamson <jwilliamson@suse.de>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2016 at 10:33 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Tue, Jul 26, 2016 at 9:54 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>> I'm guessing that the source of the problem is that the AsyncMessager.cc file is included twice, one in each library. If so, then the solution is to break out the offending *.cc file into a separate third library that's linked in the right combination with the others so that there's no duplication.
>>>
>>
>> I believe the problem can also be solved with a static member function or a
>> wrapper function for the static variable. I tried this and it appears to
>> resolve the issue.
>
> Another solution is to use anonymous namespaces which will force the
> symbol to be local to the translation unit.

but anonymous namespace has its own limitation, for example, we cannot use
wrap class WorkerPool in anonymous namespace, see
https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncMessenger.cc#L308,
as WorkerPool is forward declared in the header file.

>
>> It would be possible to audit use of such variables using nm or objdump but
>> this might be a bit difficult to maintain?
>
> There was a proposal to add -Wglobal-variable to gcc about this same
> issue but it didn't appear to go anywhere:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46097
>
>> Since this is easy to reproduce it would also be simple to write a test to
>> check for this specific issue along the lines of the following.
>>
>> $ g++ -O2 -x c++ - -Wl,--rpath=./lib -L./lib -lrados -lcephfs<<EOF
>> int main(int, char**)
>> {
>>   return 0;
>> }
>> EOF
>
> Ideally the shared libraries should not export any global variables.

thanks Patrick, yeah. this would force us to do the right thing:

* for cephfs
 - pass `--exclude-libs=libcommon.a` to linker,
 - find a way to implement libtools' "-export-symbols-regex
'^ceph_.*'" with cmake
* for librados
 - pass `--exclude-libs=ALL` to linker,
* for those naughty tests who use the internal symbols
 - link them against the convenience libs (or objects) by which the
symbols are offered.

> There are numerous bugs other than double delete. For example, if a
> global variable (address) is used as a sentinel in librados and then
> later libceph is loaded defining a new sentinel (same type), any data
> structures created relying on the address of the previous sentinel may
> break. [This is not purely limited to global variables or even C++,
> you can also have magnificent breakage if functions defined in a
> common static library with external linkage are replaced. In that
> case, code which depends on variables with local linkage may also
> break. Ultimately, the fix is to explicitly export only the desired
> functions of some API in the shared library.]
>
> A test which checks for the double delete is a good start...
>
> --
> Patrick Donnelly



-- 
Regards
Kefu Chai
