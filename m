From: Milosz Tanski <milosz@adfin.com>
Subject: Re: firefly timing
Date: Tue, 18 Mar 2014 12:38:53 -0400
Message-ID: <CANP1eJEDccw7doegUSoNKceQUgoNOfpHW1_y1Oz1fk54WDdb4w@mail.gmail.com>
References: <alpine.DEB.2.00.1403172115140.24236@cobra.newdream.net>
	<5327F0A7.8010105@profihost.ag>
	<alpine.DEB.2.00.1403180905500.316@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64775 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaCRQiy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Mar 2014 12:38:54 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so3978015wiw.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Mar 2014 09:38:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1403180905500.316@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

Is this statement in the documentation still valid: "Stale data is
expired from the cache pools based on some as-yet undetermined
policy." As that sounds a bit scary.

- Milosz

On Tue, Mar 18, 2014 at 12:06 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 18 Mar 2014, Stefan Priebe - Profihost AG wrote:
>> Hi Sage,
>>
>> i really would like to test the tiering. Is there any detailed
>> documentation about it and how it works?
>
> Great!  Here is a quick synopiss on how to set it up:
>
>         http://ceph.com/docs/master/dev/cache-pool/
>
> sage
>
>
>
>>
>> Greets,
>> Stefan
>>
>> Am 18.03.2014 05:45, schrieb Sage Weil:
>> > Hi everyone,
>> >
>> > It's taken longer than expected, but the tests for v0.78 are calming down
>> > and it looks like we'll be able to get the release out this week.
>> >
>> > However, we've decided NOT to make this release firefly.  It will be a
>> > normal development release.  This will be the first release that includes
>> > some key new functionality (erasure coding and cache tiering) and although
>> > it is passing our tests we'd like to have some operational experience with
>> > it in more users' hands before we commit to supporting it long term.
>> >
>> > The tentative plan is to freeze and then release v0.79 after a normal two
>> > week cycle.  This will serve as a 'release candidate' that shaves off a
>> > few rough edges from the pending release (including some improvements with
>> > the API for setting up erasure coded pools).  It is possible that 0.79
>> > will turn into firefly, but more likely that we will opt for another two
>> > weeks of hardening and make 0.80 the release we name firefly and maintain
>> > for the long term.
>> >
>> > Long story short: 0.78 will be out soon, and you should test it!  It is
>> > will vary from the final firefly in a few subtle ways, but any feedback or
>> > usability and bug reports at this point will be very helpful in shaping
>> > things.
>> >
>> > Thanks!
>> > sage
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
