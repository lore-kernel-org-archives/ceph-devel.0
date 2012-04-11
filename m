From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 15:34:55 -0700
Message-ID: <CAC-hyiF=AHeLjF8kOj9rW-G3bU_8oQWjGZdFa6y=CbtUi7yf4Q@mail.gmail.com>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
	<CAC-hyiGhR-ayeffsT6ZTAS4aozr_Ub_YJQN8L5Hs9zM3zWBS5g@mail.gmail.com>
	<20E3E083-D1C5-4D86-9709-95515538C1BA@cs.ucsc.edu>
	<CE79CB0202FC4C04ACB4EBAC3A0C1232@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52281 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2DKWez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 18:34:55 -0400
Received: by vbbff1 with SMTP id ff1so977576vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 15:34:55 -0700 (PDT)
In-Reply-To: <CE79CB0202FC4C04ACB4EBAC3A0C1232@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Apr 11, 2012 at 3:13 PM, Greg Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Wednesday, April 11, 2012 at 2:59 PM, Noah Watkins wrote:
>>
>> On Apr 11, 2012, at 11:22 AM, Yehuda Sadeh Weinraub wrote:
>>
>> > Also need to check that cmount is initialized. I'd add a helper:
>> >
>> > Client *ceph_get_client(struct ceph_mount_info *cmont)
>> > {
>> > if (cmount && cmount->is_mounted())
>> > return cmount->get_client();
>> >
>> > return NULL;
>> > }
>>
>>
>>
>> How useful is checking cmount != NULL here? This defensive check depends on users initializing their cmount pointers to NULL, but the API doesn't do anything to require this initialization assumption.
>>
>> - Noah
> I had a whole email going until I realized you were just right. So, yeah, that wouldn't do anything since a cmount they forgot to have the API initialize is just going to hold random data. Urgh.

There's no destructor either, maybe it's a good time to add one?

Yehuda
