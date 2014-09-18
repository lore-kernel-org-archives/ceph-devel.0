From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Thu, 18 Sep 2014 23:19:34 +0200
Message-ID: <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
	<D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
	<CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
	<541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
	<07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:61172 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaIRVUr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 17:20:47 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so1567661wes.8
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 14:20:46 -0700 (PDT)
Received: from [172.29.90.108] (mx-b.hotelavanti.cz. [81.19.13.62])
        by mx.google.com with ESMTPSA id t1sm2730wiy.8.2014.09.18.14.20.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:20:45 -0700 (PDT)
In-Reply-To: <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>

On Thu, Sep 18, 2014 at 9:12 PM, Dan van der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi,
>
> September 18 2014 9:03 PM, "Florian Haas" <florian@hastexo.com> wrote=
:
>> On Thu, Sep 18, 2014 at 8:56 PM, Dan van der Ster <daniel.vanderster=
@cern.ch> wrote:
>>
>>> Hi Florian,
>>>
>>> On Sep 18, 2014 7:03 PM, Florian Haas <florian@hastexo.com> wrote:
>>>> Hi Dan,
>>>>
>>>> saw the pull request, and can confirm your observations, at least
>>>> partially. Comments inline.
>>>>
>>>> On Thu, Sep 18, 2014 at 2:50 PM, Dan Van Der Ster
>>>> <daniel.vanderster@cern.ch> wrote:
>>>>>>> Do I understand your issue report correctly in that you have fo=
und
>>>>>>> setting osd_snap_trim_sleep to be ineffective, because it's bei=
ng
>>>>>>> applied when iterating from PG to PG, rather than from snap to =
snap?
>>>>>>> If so, then I'm guessing that that can hardly be intentional=E2=
=80=A6
>>>>>
>>>>>
>>>>> I=E2=80=99m beginning to agree with you on that guess. AFAICT, th=
e normal behavior of the snap trimmer
>>> is
>>>> to trim one single snap, the one which is in the snap_trimq but no=
t yet in purged_snaps. So the
>>>> only time the current sleep implementation could be useful is if w=
e rm=E2=80=99d a snap across many PGs
>>> at
>>>> once, e.g. rm a pool snap or an rbd snap. But those aren=E2=80=99t=
 a huge problem anyway since you=E2=80=99d at
>>>> most need to trim O(100) PGs.
>>>>
>>>> Hmm. I'm actually seeing this in a system where the problematic sn=
aps
>>>> could *only* have been RBD snaps.
>>>
>>> True, as am I. The current sleep is useful in this case, but since =
we'd normally only expect up
>> to
>>> ~100 of these PGs per OSD, the trimming of 1 snap across all of tho=
se PGs would finish rather
>>> quickly anyway. Latency would surely be increased momentarily, but =
I wouldn't expect 90s slow
>>> requests like I have with the 30000 snap_trimq single PG.
>>>
>>> Possibly the sleep is useful in both places.
>>>
>>>>> We could move the snap trim sleep into the SnapTrimmer state mach=
ine, for example in
>>>> ReplicatedPG::NotTrimming::react. This should allow other IOs to g=
et through to the OSD, but of
>>>> course the trimming PG would remain locked. And it would be locked=
 for even longer now due to
>> the
>>>> sleep.
>>>>>
>>>>> To solve that we could limit the number of trims per instance of =
the SnapTrimmer, like I=E2=80=99ve
>> done
>>>> in this pull req: https://github.com/ceph/ceph/pull/2516
>>>>> Breaking out of the trimmer like that should allow IOs to the tri=
mming PG to get through.
>>>>>
>>>>> The second aspect of this issue is why are the purged_snaps being=
 lost to begin with. I=E2=80=99ve
>>>> managed to reproduce that on my test cluster. All you have to do i=
s create many pool snaps (e.g.
>>> of
>>>> a nearly empty pool), then rmsnap all those snapshots. Then use cr=
ush reweight to move the PGs
>>>> around. With debug_osd>=3D10, you will see "adding snap 1 to purge=
d_snaps=E2=80=9D, which is one signature
>>> of
>>>> this lost purged_snaps issue. To reproduce slow requests the numbe=
r of snaps purged needs to be
>>>> O(10000).
>>>>
>>>> Hmmm, I'm not sure if I confirm that. I see "adding snap X to
>>>> purged_snaps", but only after the snap has been purged. See
>>>> https://gist.github.com/fghaas/88db3cd548983a92aa35. Of course, th=
e
>>>> fact that the OSD tries to trim a snap only to get an ENOENT is
>>>> probably indicative of something being fishy with the snaptrimq an=
d/or
>>>> the purged_snaps list as well.
>>>
>>> With such a long snap_trimq there in your log, I suspect you're see=
ing the exact same behavior as
>> I
>>> am. In my case the first snap trimmed is snap 1, of course because =
that is the first rm'd snap,
>> and
>>> the contents of your pool are surely different. I also see the ENOE=
NT messages... again
>> confirming
>>> those snaps were already trimmed. Anyway, what I've observed is tha=
t a large snap_trimq like that
>>> will block the OSD until they are all re-trimmed.
>>
>> That's... a mess.
>>
>> So what is your workaround for recovery? My hunch would be to
>>
>> - stop all access to the cluster;
>> - set nodown and noout so that other OSDs don't mark spinning OSDs
>> down (which would cause all sorts of primary and PG reassignments,
>> useless backfill/recovery when mon osd down out interval expires,
>> etc.);
>> - set osd_snap_trim_sleep to a ridiculously high value like 10 or 30
>> so that at least *between* PGs, the OSD has a chance to respond to
>> heartbeats and do whatever else it needs to do;
>> - let the snap trim play itself out over several hours (days?).
>>
>
> What I've been doing is I just continue draining my OSDs, two at a ti=
me. Each time, 1-2 other OSDs become blocked for a couple minutes (out =
of the ~1 hour it takes to drain) while a single PG re-trims, leading t=
o ~100 slow requests. The OSD must still be responding to the peer ping=
s, since other OSDs do not mark it down. Luckily this doesn't happen wi=
th every single movement of our pool 5 PGs, otherwise it would be a dis=
aster like you said.

So just to clarify, what you're doing is out of the OSDs that are
spinning, you mark 2 out and wait for them to go empty?

What I'm seeing i my environment is that the OSDs *do* go down.
Marking them out seems not to help much as the problem then promptly
pops up elsewhere.

So, disaster is a pretty good description. Would anyone from the core
team like to suggest another course of action or workaround, or are
Dan and I generally on the right track to make the best out of a
pretty bad situation?

It would be helpful for others that bought into the "snapshots are
awesome, cheap and you can have as many as you want" mantra, so as to
perhaps not have their cluster blow up in their faces at some point.
Because right now, to me it seems that as you go past maybe a few
thousand snapshots and then at some point want to remove lots of them
at the same time, you'd better be scared. Happy to stand corrected,
though. :)

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
