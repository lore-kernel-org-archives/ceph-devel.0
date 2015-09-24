From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 11:26:19 -0700
Message-ID: <CAJ4mKGb-V8L6P_StKRO2EL99AJ7R5UrUA=zsQZ8r0qzUP8j-2g@mail.gmail.com>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
	<CAANLjFo7J44QbGRRY0oKTWRy3HPUKvvxPpKz8rYcr4a24riUtA@mail.gmail.com>
	<alpine.DEB.2.00.1509240803460.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33121 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbbIXS0U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 14:26:20 -0400
Received: by wiclk2 with SMTP id lk2so40483311wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 11:26:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240803460.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 24, 2015 at 8:04 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 24 Sep 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>>
>> On Thu, Sep 24, 2015 at 6:30 AM, Sage Weil  wrote:
>> > Xuan Liu recently pointed out that there is a problem with our han=
dling
>> > for full clusters/pools: we don't allow any writes when full,
>> > including delete operations.
>> >
>> > While fixing a separate full issue I ended up making several fixes=
 and
>> > cleanups in the full handling code in
>> >
>> >         https://github.com/ceph/ceph/pull/6052
>> >
>> > The interesting part of that is that we will allow a write as long=
 as it
>> > doesn't increase the overall utilizate of bytes or objects (accord=
ing to
>> > the pg stats we're maintaining).  That will include remove ops, of=
 cours,
>> > but will also allow overwrites while full, which seems fair.
>>
>> What about overwrites on a COW FS, won't that still increase used
>> space? Maybe if it is a COW FS, don't allow overwrites?
>
> Yeah, we could strengthen (optionally?) the check so that only operat=
ions
> that result in a net decrease are allowed..

It's not just COW filesystems, anything that modifies
leveldb/rocksdb/whatever in any way will also increase the space used
=E2=80=94 including regular object deletes which additionally get added=
 to the
PG log, although *hopefully* that's not a problem since we have our
extra buffers to handle this sort of thing. While right now we might
have some hope of being able to tag ops as "net deletes" or "net
adds", I don't see that happening once we have widespread third-party
object classes or that Lua work gets in or something...

So, I'd be really leery of trying to do anything more advanced than
letting clients execute delete operations, and letting privileged
clients keep doing real work. (Or maybe restricting it entirely to the
second half there.)

That latter switch already exists, by the way, although I don't think
it's actually enforced via cephx caps (it should be) =E2=80=94 the Obje=
cter
has an honor_full_flag setting which the MDS sets to false. I don't
think the library interfaces are there to specify it per-op but IIRC
it is part of the data sent to OSDs so it wouldn't require a wire
protocol change.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
