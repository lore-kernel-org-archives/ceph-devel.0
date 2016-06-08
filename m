From: Tone Zhang <tone.zhang@linaro.org>
Subject: Re: Fresh deploy Ceph (Jewel) failed because the ceph OSD deamon is
 not activated
Date: Wed, 8 Jun 2016 18:00:46 +0800
Message-ID: <CAOCf4A=EjpU0i02SZp+1z13n61ecx=GE5StMKd3pP5qerJ1hAg@mail.gmail.com>
References: <CAOCf4A=8WiBpmYV9NBFyQ639TpHxN74h3O6sT1UqMPiopaY5zQ@mail.gmail.com>
 <alpine.DEB.2.11.1606030825210.6221@cpach.fuggernut.com> <CAC-Np1w-TZJXfwGdi81wVK7xTdJdJwRJ1zrhfVh1Bc+JkuktUw@mail.gmail.com>
 <alpine.DEB.2.11.1606030856470.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33564 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423555AbcFHKAr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2016 06:00:47 -0400
Received: by mail-vk0-f46.google.com with SMTP id d64so4160541vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jun 2016 03:00:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606030856470.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello Sage and Alfredo,

Thanks a lot for the clarification.

Br,
Tone ZHANG

On 3 June 2016 at 20:56, Sage Weil <sage@newdream.net> wrote:
> On Fri, 3 Jun 2016, Alfredo Deza wrote:
>> On Fri, Jun 3, 2016 at 8:25 AM, Sage Weil <sage@newdream.net> wrote:
>> > On Fri, 3 Jun 2016, Tone Zhang wrote:
>> >> Hello all,
>> >>
>> >> I fresh deployed Ceph within 3 ceph nodes according to the manual
>> >> http://docs.ceph.com/docs/master/start/quick-ceph-deploy/.
>> >> Ceph version is Jewel (ceph version 10.2.1
>> >> (3a66dd4f30852819c1bdaa8ec23c795d4ad77269)).
>> >> Ubuntu 16.04 is used in each node.
>> >> After run the command "ceph-deploy osd activate", there is warning
>> >> reported, following an ERROR, ENAMETOOLONG. After check in each ceph
>> >> OSD node, the ceph osd daemon is not start up.
>> >
>> > This probably happened because you deployed the OSD on ext4.  We should
>> > probably remove that option (or add a warning) to ceph-deploy.
>>
>> Since ceph-deploy is meant to be opinionated about these things, I
>> think the option should be removed:
>>
>> PR: https://github.com/ceph/ceph-deploy/pull/399
>> Tracker issue: http://tracker.ceph.com/issues/16140
>
> Even better!  Merged.
>
> Thanks!
> sage
