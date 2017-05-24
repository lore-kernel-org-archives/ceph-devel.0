From: John Spray <jspray@redhat.com>
Subject: Re: Handling is_readable=0 periods in mon
Date: Wed, 24 May 2017 11:19:53 +0100
Message-ID: <CALe9h7dqh9mw=raWFF1gcn=DyKZTPVVswN8V14SMpPV+WaZPXw@mail.gmail.com>
References: <CALe9h7cSEaLD90iDwjhi1GYogo7SV0mnc=8MjGQG_bnDVA0ygw@mail.gmail.com>
 <CAJ4mKGaARoBiG+A4PSLzBLNVuZqCBHi2VWTGmsfU8ofVTeEUkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35794 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdEXKUP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 06:20:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id b84so59137631wmh.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 03:20:14 -0700 (PDT)
In-Reply-To: <CAJ4mKGaARoBiG+A4PSLzBLNVuZqCBHi2VWTGmsfU8ofVTeEUkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>, Joao Eduardo Luis <joao@suse.de>

On Wed, May 24, 2017 at 6:12 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, May 23, 2017 at 10:31 AM John Spray <jspray@redhat.com> wrote:
>>
>> Hi all,
>>
>> I could use some help from people who understand the mon better than I
>> do with this ticket: http://tracker.ceph.com/issues/19706
>>
>> The issue is that MDSMonitor is incorrectly killing MDSs because it
>> hasn't seen beacon messages, but the beacon messages are actually just
>> held up because is_readable = 0, like this:
>> 2017-05-23 13:34:20.054785 7f772f1c2700 10
>> mon.b@0(leader).paxosservice(mdsmap 1..11) dispatch 0x7f7742989740
>> mdsbeacon(4141/a up:active seq 96 v9) v7 from mds.0
>> 172.21.15.77:6809/2700711429 con 0x7f77428d8f00
>> 2017-05-23 13:34:20.054788 7f772f1c2700  5 mon.b@0(leader).paxos(paxos
>> recovering c 1..293) is_readable = 0 - now=2017-05-23 13:34:20.054789
>> lease_expire=0.000000 has v0 lc 293
>> 2017-05-23 13:34:20.054791 7f772f1c2700 10
>> mon.b@0(leader).paxosservice(mdsmap 1..11)  waiting for paxos ->
>> readable (v9)
>>
>> This appears to be happening when one or more mons are a bit laggy,
>> but it is happening before an election has happened.
>>
>> We have code for handling slow elections by checking how long it has
>> been since the last tick, and resetting our timeout information for
>> MDS beacons if it has been too long
>> (https://github.com/ceph/ceph/blob/master/src/mon/MDSMonitor.cc#L2070)
>>
>>
>> However, in this case the tick() function is getting called
>> throughout, we're just not seeing the beacons because they're held up
>> waiting for readable.
>
>
> This story doesn't seem quite right/complete This code is only invoked
> if the monitor is the leader, which certainly doesn't happen when the
> monitor is out of quorum. Is the beacon maybe going to a peon which
> isn't forwarding quickly enough?

That was what I thought (the messages are indeed being forwarded and
getting held up a bit there), but then I looked at the leader's log
and they were getting held up there too.

I was thinking/hoping that there would be an existing mechanism to
deal with laggy mons not forwarding messages, but perhaps not if they
only look laggy to the other mons and not to the client :-/

>
>>
>>
>> I could hack around this by only doing timeouts if *any* daemon has
>> successfully got a beacon through in the last (mds_beacon_grace*2) or
>> something like that, but I wonder if there's a Right way to handle
>> this for PaxosService subclasses?
>
>
> The MDS is I think the only thing doing this, so if its patterns
> aren't working we probably don't. (The manager just started doing it,
> so may have a similar problem?)
> I suppose you might take into account the paxos quorum timeouts and
> which monitor the MDS was connected to, so that it only marks an MDS
> down if you have positive belief the monitor it was pinging is alive?

Yeah, you're probably right that if there's not something else
thinking about the forwarding, then MDSMonitor does need to track who
forwarded and consider whether the forwarder is still considered
healthy.

John
