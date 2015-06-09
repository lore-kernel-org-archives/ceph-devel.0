From: Gregory Farnum <greg@gregs42.com>
Subject: Re: OSD-Based Object Stubs
Date: Tue, 9 Jun 2015 16:58:46 -0700
Message-ID: <CAC6JEv_oZ2x6AbQSJzJ5==R+8KSZMbpfqk=WZnd-HGcMRYzSoA@mail.gmail.com>
References: <87a8wqct38.fsf@irq0.org>
	<CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com>
	<87617dc965.fsf@irq0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36249 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbFIX6s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 19:58:48 -0400
Received: by ieclw1 with SMTP id lw1so23940446iec.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 16:58:47 -0700 (PDT)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com. [209.85.213.175])
        by mx.google.com with ESMTPSA id lq3sm2241482igb.3.2015.06.09.16.58.46
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 16:58:46 -0700 (PDT)
Received: by igbsb11 with SMTP id sb11so22228165igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 16:58:46 -0700 (PDT)
In-Reply-To: <87617dc965.fsf@irq0.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 3:01 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>
> Gregory Farnum <greg@gregs42.com> writes:
>
>> On Wed, May 27, 2015 at 1:39 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>>> Hi,
>>>
>>> I wrote a prototype for an OSD-based object stub feature. An object stub
>>> being an object with it's data moved /elsewhere/. I hope to get some
>>> feedback, especially whether I'm on the right path here and if it
>>> is a feature you are interested in.
>>>
>>>
>>>
>>> Code is in my "osd-stubs" branch:
>>>  https://github.com/ceph/ceph/compare/master...irq0:osd-stubs
>>>  https://github.com/irq0/ceph/tree/osd-stubs
>>>
>>>  Tools to toy around with osd-stubs + web server to send stubs to:
>>>  https://github.com/irq0/ceph_osd-stub_tools
>>>
>>>
>>>
>>> Related:
>>> - https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd:_tiering:_object_redirects
>>
>> Do you have a shorter summary than the code of how these stub and
>> unstub operations relate to the object redirects? We didn't make a
>> great deal of use of them but the basic data structures are mostly
>> present in the codebase, are interpreted in at least some of the right
>> places, and were definitely intended to cover this kind of use case.
>> :)
>> -Greg
>
>
> As far as I understood the redirect feature it is about pointing to
> other objects inside the Ceph cluster. The stubs feature allows
> pointing to anything. An HTTP server in concept code.
>
> Then stubs use an IMHO simpler approach to getting objects back: It's
> the task of the OSD. Stubbed objects just take longer to access, due to
> unstubbing it first.
> Redirects on the other hand leave this to the client: Object redirected
> -> Tell client to retrieve it elsewhere.

Ah, of course.

I got a chance to look at this briefly today. Some notes:

* You're using synchronous reads. That will prevent use of stubbing on
EC pools (which only do async reads, as they might need to hit another
OSD for the data), which seems sad.
* There seems to be a race if you need to unstub an op for two
separate requests that come in simultaneously, with nothing preventing
both of them from initiating the unstub.
* You can inject an unstub for read ops, but that turns them into a
write. That will cause problems in various cases where the object
isn't writeable yet.
* Why does a delete need the object data?
* You definitely wouldn't want to unstub data for scrubbing.
* There's a CEPH_OSD_OP_STAT which looks at what's in the object info;
that is broken here because you're using the normal truncation path.
There probably needs to be more cleverness or machinery distinguishing
between the "local" size used and the size of the object represented.
* I am concerned about recovery, but I think as long as the stub is
just a normal zero-sized object with an extra flag in the object info
that shouldn't be a big deal.
* I think snapshots are probably busted with this; did you check how
they interact?
-Greg
