From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 12:19:07 +1000
Message-ID: <20161223021907.GB6408@rskikr.localdomain>
References: <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <CAF-wwdHbSejTSYGDvRdYcu03Dz=22wMP619cWfCcO1sx9h+wTw@mail.gmail.com>
 <CAF-wwdH5wQP11gQKcwoh0uVQpVHQXw=8XYCj+t=mhx0rfFSJSg@mail.gmail.com>
 <16b4b953-6369-626e-8348-21bbf39ca21c@digiware.nl>
 <CAF-wwdEhQL+rBQCqRdqTgdYCXWqDTVcJBPH8jHG5eiXn8-KRHA@mail.gmail.com>
 <80d484c5-acf3-6bc9-17f6-dddbae8d3ca5@digiware.nl>
 <20161223011510.GA6408@rskikr.localdomain>
 <fa76db8f-1e2a-28b3-1a7f-7514d9f01ea0@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35160 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbcLWCTQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2016 21:19:16 -0500
Received: by mail-pg0-f43.google.com with SMTP id i5so38913488pgh.2
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2016 18:19:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fa76db8f-1e2a-28b3-1a7f-7514d9f01ea0@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sorry, thought the question about "Does it run" was aimed at me.

I'm leaning towards the valgrind output being a false positive so I don't think
it is the smoking gun in this case.

On Fri, Dec 23, 2016 at 11:23 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 23-12-2016 02:15, Brad Hubbard wrote:
>> The valgrind output I posted seems to indicate an issue in the stl, which is
>> unlikely and probably a false positive. Strange coincidence though...
>>
>> Another option for attacking this might be sanitizers?
>
> Not sure if all Clang sanitizers are available, and I have to read up on
> those as well.
>
> Valgrind does build with Clang, but running it gives me a non killable
> process. So that is not easily going to work.
>
> --WjW
>
> PS: Off to bed, it is way pas midnight here.
>



-- 
Cheers,
Brad
