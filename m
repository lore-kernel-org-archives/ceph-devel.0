From: John Spray <jspray@redhat.com>
Subject: Re: Handling is_readable=0 periods in mon
Date: Wed, 24 May 2017 22:14:48 +0100
Message-ID: <CALe9h7efSpCVT9Ddk4tyvTKbCDN0_ZhYOL6_qttF3DGijHefVg@mail.gmail.com>
References: <CALe9h7cSEaLD90iDwjhi1GYogo7SV0mnc=8MjGQG_bnDVA0ygw@mail.gmail.com>
 <CAJ4mKGaARoBiG+A4PSLzBLNVuZqCBHi2VWTGmsfU8ofVTeEUkQ@mail.gmail.com>
 <CALe9h7dqh9mw=raWFF1gcn=DyKZTPVVswN8V14SMpPV+WaZPXw@mail.gmail.com> <CAJ4mKGaC0BuxsYPsZoqosAf2YXMKpte2WTpma=Q4TxpT+WbBVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f403045e291c53e9c705504b999d"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34252 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032657AbdEXVPK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 17:15:10 -0400
Received: by mail-wr0-f181.google.com with SMTP id j27so8276934wre.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 14:15:09 -0700 (PDT)
In-Reply-To: <CAJ4mKGaC0BuxsYPsZoqosAf2YXMKpte2WTpma=Q4TxpT+WbBVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>, Joao Eduardo Luis <joao@suse.de>

--f403045e291c53e9c705504b999d
Content-Type: text/plain; charset="UTF-8"

On Wed, May 24, 2017 at 9:45 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Wed, May 24, 2017 at 3:20 AM John Spray <jspray@redhat.com> wrote:
>>
>> On Wed, May 24, 2017 at 6:12 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> > On Tue, May 23, 2017 at 10:31 AM John Spray <jspray@redhat.com> wrote:
>> >>
>> >> Hi all,
>> >>
>> >> I could use some help from people who understand the mon better than I
>> >> do with this ticket: http://tracker.ceph.com/issues/19706
>> >>
>> >> The issue is that MDSMonitor is incorrectly killing MDSs because it
>> >> hasn't seen beacon messages, but the beacon messages are actually just
>> >> held up because is_readable = 0, like this:
>> >> 2017-05-23 13:34:20.054785 7f772f1c2700 10
>> >> mon.b@0(leader).paxosservice(mdsmap 1..11) dispatch 0x7f7742989740
>> >> mdsbeacon(4141/a up:active seq 96 v9) v7 from mds.0
>> >> 172.21.15.77:6809/2700711429 con 0x7f77428d8f00
>> >> 2017-05-23 13:34:20.054788 7f772f1c2700  5 mon.b@0(leader).paxos(paxos
>> >> recovering c 1..293) is_readable = 0 - now=2017-05-23 13:34:20.054789
>> >> lease_expire=0.000000 has v0 lc 293
>> >> 2017-05-23 13:34:20.054791 7f772f1c2700 10
>> >> mon.b@0(leader).paxosservice(mdsmap 1..11)  waiting for paxos ->
>> >> readable (v9)
>> >>
>> >> This appears to be happening when one or more mons are a bit laggy,
>> >> but it is happening before an election has happened.
>> >>
>> >> We have code for handling slow elections by checking how long it has
>> >> been since the last tick, and resetting our timeout information for
>> >> MDS beacons if it has been too long
>> >> (https://github.com/ceph/ceph/blob/master/src/mon/MDSMonitor.cc#L2070)
>> >>
>> >>
>> >> However, in this case the tick() function is getting called
>> >> throughout, we're just not seeing the beacons because they're held up
>> >> waiting for readable.
>> >
>> >
>> > This story doesn't seem quite right/complete This code is only invoked
>> > if the monitor is the leader, which certainly doesn't happen when the
>> > monitor is out of quorum. Is the beacon maybe going to a peon which
>> > isn't forwarding quickly enough?
>>
>> That was what I thought (the messages are indeed being forwarded and
>> getting held up a bit there), but then I looked at the leader's log
>> and they were getting held up there too.
>
>
> Okay, so it's not that one peon is laggy but that the monitors are
> knowingly not in a quorum, including the one who is leader on both
> sides of the election (but not while things are laggy!). And then when
> the election happens, the leader does a tick and notices it hasn't
> gotten a beacon from any MDSes in the past timeout interval.

That's what I thought too, until I noticed that the elections were
only happening *after* we've had our tick() and mistakenly killed an
MDS.  There's this period where the beacons are getting ignored, but
our tick() is still getting called.

I've snipped out the timeline in an attachment to this mail (easier to
read in a nice widescreen text editor than most mail clients).

John

> So that suggests you actually just need to take account of how long
> it's been since the monitor went active, not that you need a major
> rework of the tracking. Probably just modify it so the code won't mark
> down an MDS until at least beacon_timeout has passed since the mon
> went active? (I don't know off-hand how to query that state but I'm
> sure it's available somewhere.)
> -Greg
>
>>
>>
>> I was thinking/hoping that there would be an existing mechanism to
>> deal with laggy mons not forwarding messages, but perhaps not if they
>> only look laggy to the other mons and not to the client :-/
>>
>> >
>> >>
>> >>
>> >> I could hack around this by only doing timeouts if *any* daemon has
>> >> successfully got a beacon through in the last (mds_beacon_grace*2) or
>> >> something like that, but I wonder if there's a Right way to handle
>> >> this for PaxosService subclasses?
>> >
>> >
>> > The MDS is I think the only thing doing this, so if its patterns
>> > aren't working we probably don't. (The manager just started doing it,
>> > so may have a similar problem?)
>> > I suppose you might take into account the paxos quorum timeouts and
>> > which monitor the MDS was connected to, so that it only marks an MDS
>> > down if you have positive belief the monitor it was pinging is alive?
>>
>> Yeah, you're probably right that if there's not something else
>> thinking about the forwarding, then MDSMonitor does need to track who
>> forwarded and consider whether the forwarder is still considered
>> healthy.
>>
>> John

--f403045e291c53e9c705504b999d
Content-Type: text/plain; charset="US-ASCII"; name="19706.txt"
Content-Disposition: attachment; filename="19706.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j33hlrex0

CgpUaGUgbGFzdCBwcmVwcm9jZXNzX2JlYWNvbiBjYWxscyBiZWZvcmUgd2Uga2lsbGVkIHRoZSBh
Y3RpdmUgZGFlbW9uOgoyMDE3LTA1LTIzIDEzOjMzOjU2LjM3NTQ0MiA3Zjc3MmYxYzI3MDAgMTIg
bW9uLmJAMChsZWFkZXIpLm1kcyBlMTEgcHJlcHJvY2Vzc19iZWFjb24gbWRzYmVhY29uKDQxNDEv
YSB1cDphY3RpdmUgc2VxIDk0IHY5KS4uLgoyMDE3LTA1LTIzIDEzOjMzOjU3LjU4NjY4OCA3Zjc3
MmYxYzI3MDAgMTIgbW9uLmJAMChsZWFkZXIpLm1kcyBlMTEgcHJlcHJvY2Vzc19iZWFjb24gbWRz
YmVhY29uKDQxMzEvYS1zIHVwOnN0YW5kYnkgc2VxIDk0IHYxMSkuLi4KMjAxNy0wNS0yMyAxMzoz
NDowMS41ODY5NjggN2Y3NzJmMWMyNzAwIDEyIG1vbi5iQDAobGVhZGVyKS5tZHMgZTExIHByZXBy
b2Nlc3NfYmVhY29uIG1kc2JlYWNvbig0MTMxL2EtcyB1cDpzdGFuZGJ5IHNlcSA5NSB2MTEpLi4u
CgpBbiBpbnRlcnZlbmluZyBwZXJpb2QgaW4gd2hpY2ggYmVhY29uIG1lc3NhZ2VzIGFyZSByZWNl
aXZlZCBidXQgaWdub3JlZCBsaWtlIHRoaXM6CjIwMTctMDUtMjMgMTM6MzQ6MDkuNjI3NDUyIDdm
NzcyZjFjMjcwMCAxMCBtb24uYkAwKGxlYWRlcikucGF4b3NzZXJ2aWNlKG1kc21hcCAxLi4xMSkg
ZGlzcGF0Y2ggMHg3Zjc3NDI5ODdhMDAgbWRzYmVhY29uKDQxMzEvYS1zIHVwOnN0YW5kYnkgc2Vx
IDk2IHYxMSkgdjcgZnJvbSBtZHMuPyAxNzIuMjEuMTUuNzQ6NjgwOC8yMDU3MTk3ODU5IGNvbiAw
eDdmNzc0Mjg4YjgwMAoyMDE3LTA1LTIzIDEzOjM0OjA5LjYyNzQ1NSA3Zjc3MmYxYzI3MDAgIDUg
bW9uLmJAMChsZWFkZXIpLnBheG9zKHBheG9zIHVwZGF0aW5nIGMgMS4uMjkyKSBpc19yZWFkYWJs
ZSA9IDAgLSBub3c9MjAxNy0wNS0yMyAxMzozNDowOS42Mjc0NTYgbGVhc2VfZXhwaXJlPTIwMTct
MDUtMjMgMTM6MzQ6MDkuMjExMzMzIGhhcyB2MCBsYyAyOTIKMjAxNy0wNS0yMyAxMzozNDowOS42
Mjc0NTkgN2Y3NzJmMWMyNzAwIDEwIG1vbi5iQDAobGVhZGVyKS5wYXhvc3NlcnZpY2UobWRzbWFw
IDEuLjExKSAgd2FpdGluZyBmb3IgcGF4b3MgLT4gcmVhZGFibGUgKHYxMSkKClRoZSBhY3RpdmUg
ZGFlbW9uIGdldHMga2lsbGVkOgoyMDE3LTA1LTIzIDEzOjM0OjE0LjYyNzM5NiA3Zjc3MzE5Yzc3
MDAgMTAgbW9uLmJAMChsZWFkZXIpLm1kcyBlMTEgZTExOiAxLzEvMSB1cCB7MD1hPXVwOmFjdGl2
ZX0sIDEgdXA6c3RhbmRieQoyMDE3LTA1LTIzIDEzOjM0OjE0LjYyNzQxNCA3Zjc3MzE5Yzc3MDAg
MTAgbW9uLmJAMChsZWFkZXIpLm1kcyBlMTEgbm8gYmVhY29uIGZyb20gNDE0MSAxNzIuMjEuMTUu
Nzc6NjgwOS8yNzAwNzExNDI5IG1kcy4wLjcgdXA6YWN0aXZlIHNpbmNlIDIwMTctMDUtMjMgMTM6
MzM6NTYuMzc1NDUyCjIwMTctMDUtMjMgMTM6MzQ6MTQuNjI3NDI5IDdmNzczMTljNzcwMCAxMCBt
b24uYkAwKGxlYWRlcikubWRzIGUxMSAgcmVwbGFjaW5nIDQxNDEgMTcyLjIxLjE1Ljc3OjY4MDkv
MjcwMDcxMTQyOSBtZHMuMC43IHVwOmFjdGl2ZSB3aXRoIDQxMzEvYS1zIDE3Mi4yMS4xNS43NDo2
ODA4LzIwNTcxOTc4NTkKMjAxNy0wNS0yMyAxMzozNDoxNC42Mjc0MzYgN2Y3NzMxOWM3NzAwIDEw
IG1vbi5iQDAobGVhZGVyKS5tZHMgZTExIGZhaWxfbWRzX2dpZCA0MTQxIG1kcy5hIHJvbGUgMAoK
RXZlbnR1YWxseSBhbiBlbGVjdGlvbiBoYXBwZW5zOgoyMDE3LTA1LTIzIDEzOjM0OjE4LjQ1MjUx
OCA3Zjc3MmYxYzI3MDAgIDEgLS0gMTcyLjIxLjE1Ljc0OjY3ODkvMCBfc2VuZF9tZXNzYWdlLS0+
IG1vbi4xIDE3Mi4yMS4xNS43Nzo2Nzg5LzAgLS0gZWxlY3Rpb24oMDMyN2FjZTAtYmU3Ni00NTY3
LTgyODEtYTc2ZDE5MzMzNjZmIHByb3Bvc2UgNykgdjYgLS0gPyswIDB4N2Y3NzQyOWExODAwCjIw
MTctMDUtMjMgMTM6MzQ6MTguNDUyNTY3IDdmNzcyZjFjMjcwMCAgMSAtLSAxNzIuMjEuMTUuNzQ6
Njc4OS8wIF9zZW5kX21lc3NhZ2UtLT4gbW9uLjIgMTcyLjIxLjE1Ljc0OjY3OTAvMCAtLSBlbGVj
dGlvbigwMzI3YWNlMC1iZTc2LTQ1NjctODI4MS1hNzZkMTkzMzM2NmYgcHJvcG9zZSA3KSB2NiAt
LSA/KzAgMHg3Zjc3NDI5YTIxMDAKMjAxNy0wNS0yMyAxMzozNDoxOC40OTQzMzEgN2Y3NzJmMWMy
NzAwICAxIC0tIDE3Mi4yMS4xNS43NDo2Nzg5LzAgX3NlbmRfbWVzc2FnZS0tPiBtb24uMSAxNzIu
MjEuMTUuNzc6Njc4OS8wIC0tIGVsZWN0aW9uKDAzMjdhY2UwLWJlNzYtNDU2Ny04MjgxLWE3NmQx
OTMzMzY2ZiB2aWN0b3J5IDgpIHY2IC0tID8rMCAweDdmNzc0MjlhMjEwMAoyMDE3LTA1LTIzIDEz
OjM0OjE4LjQ5NDM1OSA3Zjc3MmYxYzI3MDAgIDEgLS0gMTcyLjIxLjE1Ljc0OjY3ODkvMCBfc2Vu
ZF9tZXNzYWdlLS0+IG1vbi4yIDE3Mi4yMS4xNS43NDo2NzkwLzAgLS0gZWxlY3Rpb24oMDMyN2Fj
ZTAtYmU3Ni00NTY3LTgyODEtYTc2ZDE5MzMzNjZmIHZpY3RvcnkgOCkgdjYgLS0gPyswIDB4N2Y3
NzQyOWEwNjAwCgo=
--f403045e291c53e9c705504b999d--
