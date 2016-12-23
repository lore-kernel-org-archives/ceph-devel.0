From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 02:23:13 +0100
Message-ID: <fa76db8f-1e2a-28b3-1a7f-7514d9f01ea0@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <CAF-wwdHbSejTSYGDvRdYcu03Dz=22wMP619cWfCcO1sx9h+wTw@mail.gmail.com>
 <CAF-wwdH5wQP11gQKcwoh0uVQpVHQXw=8XYCj+t=mhx0rfFSJSg@mail.gmail.com>
 <16b4b953-6369-626e-8348-21bbf39ca21c@digiware.nl>
 <CAF-wwdEhQL+rBQCqRdqTgdYCXWqDTVcJBPH8jHG5eiXn8-KRHA@mail.gmail.com>
 <80d484c5-acf3-6bc9-17f6-dddbae8d3ca5@digiware.nl>
 <20161223011510.GA6408@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:33582 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938967AbcLWBXT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 20:23:19 -0500
In-Reply-To: <20161223011510.GA6408@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23-12-2016 02:15, Brad Hubbard wrote:
> The valgrind output I posted seems to indicate an issue in the stl, which is
> unlikely and probably a false positive. Strange coincidence though...
> 
> Another option for attacking this might be sanitizers?

Not sure if all Clang sanitizers are available, and I have to read up on
those as well.

Valgrind does build with Clang, but running it gives me a non killable
process. So that is not easily going to work.

--WjW

PS: Off to bed, it is way pas midnight here.

