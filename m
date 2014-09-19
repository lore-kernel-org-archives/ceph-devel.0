From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Fri, 19 Sep 2014 08:12:57 +0200
Message-ID: <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net> <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42622 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbaISGNU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 02:13:20 -0400
Received: by mail-qc0-f174.google.com with SMTP id m20so2563206qcx.19
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 23:13:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 19, 2014 at 12:27 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 19 Sep 2014, Florian Haas wrote:
>> Hi Sage,
>>
>> was the off-list reply intentional?
>
> Whoops!  Nope :)
>
>> On Thu, Sep 18, 2014 at 11:47 PM, Sage Weil <sweil@redhat.com> wrote:
>> >> So, disaster is a pretty good description. Would anyone from the core
>> >> team like to suggest another course of action or workaround, or are
>> >> Dan and I generally on the right track to make the best out of a
>> >> pretty bad situation?
>> >
>> > The short term fix would probably be to just prevent backfill for the time
>> > being until the bug is fixed.
>>
>> As in, osd max backfills = 0?
>
> Yeah :)
>
> Just managed to reproduce the problem...
>
> sage

Saw the wip branch. Color me freakishly impressed on the turnaround. :) Thanks!

Cheers,
Florian
