From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Wed, 27 Jul 2016 11:18:53 -0400
Message-ID: <CA+2bHPa_M3TXjbjdzcySPGCOSHuc4q7ynW-ug-N0i=jwTyJRTw@mail.gmail.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com> <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160727015433.GB22132@rskikr.localdomain> <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
 <CAJE9aONRiJaOBEkOGhZBUAy6=_cEFTd0hCgmaUyOQ5=a8dvCvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35410 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634AbcG0PTX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 11:19:23 -0400
Received: by mail-qt0-f170.google.com with SMTP id x25so31613097qtx.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2016 08:19:23 -0700 (PDT)
In-Reply-To: <CAJE9aONRiJaOBEkOGhZBUAy6=_cEFTd0hCgmaUyOQ5=a8dvCvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Jesse Williamson <jwilliamson@suse.de>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2016 at 8:04 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Wed, Jul 27, 2016 at 10:33 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> On Tue, Jul 26, 2016 at 9:54 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>>> I'm guessing that the source of the problem is that the AsyncMessager.cc file is included twice, one in each library. If so, then the solution is to break out the offending *.cc file into a separate third library that's linked in the right combination with the others so that there's no duplication.
>>>>
>>>
>>> I believe the problem can also be solved with a static member function or a
>>> wrapper function for the static variable. I tried this and it appears to
>>> resolve the issue.
>>
>> Another solution is to use anonymous namespaces which will force the
>> symbol to be local to the translation unit.
>
> but anonymous namespace has its own limitation, for example, we cannot use
> wrap class WorkerPool in anonymous namespace, see
> https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncMessenger.cc#L308,
> as WorkerPool is forward declared in the header file.

Ah, that complicates matters. I believe you're right.

-- 
Patrick Donnelly
