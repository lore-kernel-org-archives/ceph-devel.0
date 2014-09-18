From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Thu, 18 Sep 2014 19:31:08 +0000
Message-ID: <d82bee231af66a065db7da47339033ee@webmail.vanderster.com>
References: <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>  
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
 <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>  
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:2151 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbaIRTbL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 15:31:11 -0400
In-Reply-To: <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

-- Dan van der Ster || Data & Storage Services || CERN IT Department --

September 18 2014 9:12 PM, "Dan van der Ster" <daniel.vanderster@cern.c=
h> wrote:=20
> Hi,
>=20
> September 18 2014 9:03 PM, "Florian Haas" <florian@hastexo.com> wrote=
:
>=20
>> On Thu, Sep 18, 2014 at 8:56 PM, Dan van der Ster <daniel.vanderster=
@cern.ch> wrote:
>>=20
>>> Hi Florian,
>>>=20
>>> On Sep 18, 2014 7:03 PM, Florian Haas <florian@hastexo.com> wrote:=20
>>>> Hi Dan,
>>>>=20
>>>> saw the pull request, and can confirm your observations, at least
>>>> partially. Comments inline.
>>>>=20
>>>> On Thu, Sep 18, 2014 at 2:50 PM, Dan Van Der Ster
>>>> <daniel.vanderster@cern.ch> wrote:=20
>>>>>>> Do I understand your issue report correctly in that you have fo=
und
>>>>>>> setting osd_snap_trim_sleep to be ineffective, because it's bei=
ng
>>>>>>> applied when iterating from PG to PG, rather than from snap to =
snap?
>>>>>>> If so, then I'm guessing that that can hardly be intentional=E2=
=80=A6
>>>>>=20
>>>>> I=E2=80=99m beginning to agree with you on that guess. AFAICT, th=
e normal behavior of the snap trimmer
>>>=20
>>> is=20
>>>> to trim one single snap, the one which is in the snap_trimq but no=
t yet in purged_snaps. So the
>>>> only time the current sleep implementation could be useful is if w=
e rm=E2=80=99d a snap across many PGs
>>>=20
>>> at=20
>>>> once, e.g. rm a pool snap or an rbd snap. But those aren=E2=80=99t=
 a huge problem anyway since you=E2=80=99d at
>>>> most need to trim O(100) PGs.
>>>>=20
>>>> Hmm. I'm actually seeing this in a system where the problematic sn=
aps
>>>> could *only* have been RBD snaps.
>>>=20
>>> True, as am I. The current sleep is useful in this case, but since =
we'd normally only expect up
>>=20
>> to=20
>>> ~100 of these PGs per OSD, the trimming of 1 snap across all of tho=
se PGs would finish rather
>>> quickly anyway. Latency would surely be increased momentarily, but =
I wouldn't expect 90s slow
>>> requests like I have with the 30000 snap_trimq single PG.
>>>=20
>>> Possibly the sleep is useful in both places.
>>>=20
>>>>> We could move the snap trim sleep into the SnapTrimmer state mach=
ine, for example in
>>>>=20
>>>> ReplicatedPG::NotTrimming::react. This should allow other IOs to g=
et through to the OSD, but of
>>>> course the trimming PG would remain locked. And it would be locked=
 for even longer now due to
>>=20
>> the=20
>>>> sleep.=20
>>>>> To solve that we could limit the number of trims per instance of =
the SnapTrimmer, like I=E2=80=99ve
>>=20
>> done=20
>>>> in this pull req: https://github.com/ceph/ceph/pull/2516=20
>>>>> Breaking out of the trimmer like that should allow IOs to the tri=
mming PG to get through.
>>>>>=20
>>>>> The second aspect of this issue is why are the purged_snaps being=
 lost to begin with. I=E2=80=99ve
>>>>=20
>>>> managed to reproduce that on my test cluster. All you have to do i=
s create many pool snaps
> (e.g.
>>>=20
>>> of=20
>>>> a nearly empty pool), then rmsnap all those snapshots. Then use cr=
ush reweight to move the PGs
>>>> around. With debug_osd>=3D10, you will see "adding snap 1 to purge=
d_snaps=E2=80=9D, which is one
> signature
>>>=20
>>> of=20
>>>> this lost purged_snaps issue. To reproduce slow requests the numbe=
r of snaps purged needs to be
>>>> O(10000).
>>>>=20
>>>> Hmmm, I'm not sure if I confirm that. I see "adding snap X to
>>>> purged_snaps", but only after the snap has been purged. See
>>>> https://gist.github.com/fghaas/88db3cd548983a92aa35. Of course, th=
e
>>>> fact that the OSD tries to trim a snap only to get an ENOENT is
>>>> probably indicative of something being fishy with the snaptrimq an=
d/or
>>>> the purged_snaps list as well.
>>>=20
>>> With such a long snap_trimq there in your log, I suspect you're see=
ing the exact same behavior
> as
>>=20
>> I=20
>>> am. In my case the first snap trimmed is snap 1, of course because =
that is the first rm'd snap,
>>=20
>> and=20
>>> the contents of your pool are surely different. I also see the ENOE=
NT messages... again
>>=20
>> confirming=20
>>> those snaps were already trimmed. Anyway, what I've observed is tha=
t a large snap_trimq like
> that
>>> will block the OSD until they are all re-trimmed.
>>=20
>> That's... a mess.
>>=20
>> So what is your workaround for recovery? My hunch would be to
>>=20
>> - stop all access to the cluster;
>> - set nodown and noout so that other OSDs don't mark spinning OSDs
>> down (which would cause all sorts of primary and PG reassignments,
>> useless backfill/recovery when mon osd down out interval expires,
>> etc.);
>> - set osd_snap_trim_sleep to a ridiculously high value like 10 or 30
>> so that at least *between* PGs, the OSD has a chance to respond to
>> heartbeats and do whatever else it needs to do;
>> - let the snap trim play itself out over several hours (days?).
>=20
> What I've been doing is I just continue draining my OSDs, two at a ti=
me. Each time, 1-2 other OSDs
> become blocked for a couple minutes (out of the ~1 hour it takes to d=
rain) while a single PG
> re-trims, leading to ~100 slow requests. The OSD must still be respon=
ding to the peer pings, since
> other OSDs do not mark it down. Luckily this doesn't happen with ever=
y single movement of our pool
> 5 PGs, otherwise it would be a disaster like you said.

Two other more risky work-arounds that I didn't try yet are:

1. lower the osd_snap_trim_thread_timeout from 3600s to something like =
10 or 20s, so that these long trim operations are just killed. I have n=
o idea if this is safe.
2. pay close attention to the slow requests and manually mark the affec=
ted OSDs down when they become blocked. by marking the trimming OSD dow=
n the IOs should go elsewhere until the OSD can recover once again late=
r. But I don't know how the backfilling OSD will behave if it is manual=
ly marked down while trimming.

Cheers, Dan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
