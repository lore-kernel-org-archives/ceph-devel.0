From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Wed, 27 Jul 2016 11:07:08 -0400
Message-ID: <CA+2bHPa_+Jnb5bzb5P2VVPjC54afc9Ji2+6DT0Wa47aN7zFNJw@mail.gmail.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com> <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160727015433.GB22132@rskikr.localdomain> <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
 <BLUPR0201MB1524E467A2745777CB82E20BE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35561 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbcG0PHj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 11:07:39 -0400
Received: by mail-qk0-f174.google.com with SMTP id s63so36757674qkb.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2016 08:07:38 -0700 (PDT)
In-Reply-To: <BLUPR0201MB1524E467A2745777CB82E20BE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Jesse Williamson <jwilliamson@suse.de>, kefu chai <tchaikov@gmail.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 26, 2016 at 10:40 PM, Allen Samuels
<Allen.Samuels@sandisk.com> wrote:
>> -----Original Message-----
>> From: Patrick Donnelly [mailto:pdonnell@redhat.com]
>> Sent: Tuesday, July 26, 2016 7:34 PM
>> To: Brad Hubbard <bhubbard@redhat.com>
>> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Jesse Williamson
>> <jwilliamson@suse.de>; kefu chai <tchaikov@gmail.com>; John Spray
>> <jspray@redhat.com>; ceph-devel@vger.kernel.org
>> Subject: Re: static member variable in libcommon and double free
>>
>> On Tue, Jul 26, 2016 at 9:54 PM, Brad Hubbard <bhubbard@redhat.com>
>> wrote:
>> >> I'm guessing that the source of the problem is that the AsyncMessager.cc
>> file is included twice, one in each library. If so, then the solution is to break
>> out the offending *.cc file into a separate third library that's linked in the right
>> combination with the others so that there's no duplication.
>> >>
>> >
>> > I believe the problem can also be solved with a static member function
>> > or a wrapper function for the static variable. I tried this and it
>> > appears to resolve the issue.
>>
>> Another solution is to use anonymous namespaces which will force the
>> symbol to be local to the translation unit.
>
> Won't this result in two instantiations of the "global" variable? That seems like a huge risk to the integrity of the operation of that class.... IMO, that's the wrong solution as it will eliminate a clear signal of a problem but would allow the language semantics to be degraded silently.

To clarify the context, the class is defined in a .cc file so it is
intended for the entire class to be local linkage. So there should not
be two instantiations of a global variable. An anonymous namespace
forces the entire class to have local linkage so all of its static
members are not exported into global scope. (This an example of C++
abusing the well-defined C static keyword.)

> I think the solution is still to properly implement the ODR rule, break this class into a separate library that's only included once in ANY build.

Unless there is a convincing reason for src/common/* to be shared by
librados/libceph, then I disagree. It is simpler to ensure that these
modules have local linkage by explicitly managing visibility in the
shared objects.

-- 
Patrick Donnelly
