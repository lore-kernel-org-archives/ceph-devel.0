From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD volumes for bare-metal hosts
Date: Thu, 7 Jul 2016 12:43:19 +0200
Message-ID: <CAOi1vP_64+AqJ3viovav8G7EfWNu5vfQs5ORx1Q0xUG4FCMvDw@mail.gmail.com>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
 <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com> <CA+H5UW1_M+bDMu6xu9JL9Ojb6j3JihyTnQcFvMYb6BPU49dPUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35439 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcGGKnV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 06:43:21 -0400
Received: by mail-wm0-f42.google.com with SMTP id z126so143264989wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2016 03:43:20 -0700 (PDT)
In-Reply-To: <CA+H5UW1_M+bDMu6xu9JL9Ojb6j3JihyTnQcFvMYb6BPU49dPUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>

On Wed, Jul 6, 2016 at 2:21 AM, Radoslaw Zarzynski
<rzarzynski@mirantis.com> wrote:
> Hi Ilya,
>
> Thanks for the quick and detailed response.
>
> On Wed, Jul 6, 2016 at 1:41 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> The code for exclusive-lock, object-map and fast-diff is pretty much
>> ready.  We had a large prerequisite that had to go in before any of
>> these and it's been merged into 4.7, so it's now a matter of review and
>> more comprehensive testing.  deep-flatten isn't ready, but should
>> follow shortly after.
>
> This sounds great.
>
>> No concrete plans for mirroring support yet.
>
> AFAIK the sole dependency for mirroring (from RBD volume
> consumer's POV) is journaling that in turn requires exclusive-lock.
> Having the last one in the code base opens a door for the whole
> feature. The user-space daemon (rbd-mirror) and tooling might be
> reused. Is that correct?

Yes, that should be correct.

Thanks,

                Ilya
