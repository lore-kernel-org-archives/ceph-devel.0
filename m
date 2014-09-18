From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Thu, 18 Sep 2014 21:03:18 +0200
Message-ID: <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:59640 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaIRTDj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 15:03:39 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so1069775qgd.33
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 12:03:38 -0700 (PDT)
In-Reply-To: <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mango Thirtyfour <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Sep 18, 2014 at 8:56 PM, Mango Thirtyfour
<daniel.vanderster@cern.ch> wrote:
> Hi Florian,
>
> On Sep 18, 2014 7:03 PM, Florian Haas <florian@hastexo.com> wrote:
>>
>> Hi Dan,
>>
>> saw the pull request, and can confirm your observations, at least
>> partially. Comments inline.
>>
>> On Thu, Sep 18, 2014 at 2:50 PM, Dan Van Der Ster
>> <daniel.vanderster@cern.ch> wrote:
>> >>> Do I understand your issue report correctly in that you have fou=
nd
>> >>> setting osd_snap_trim_sleep to be ineffective, because it's bein=
g
>> >>> applied when iterating from PG to PG, rather than from snap to s=
nap?
>> >>> If so, then I'm guessing that that can hardly be intentional=E2=80=
=A6
>> >
>> >
>> > I=E2=80=99m beginning to agree with you on that guess. AFAICT, the=
 normal behavior of the snap trimmer is to trim one single snap, the on=
e which is in the snap_trimq but not yet in purged_snaps. So the only t=
ime the current sleep implementation could be useful is if we rm=E2=80=99=
d a snap across many PGs at once, e.g. rm a pool snap or an rbd snap. B=
ut those aren=E2=80=99t a huge problem anyway since you=E2=80=99d at mo=
st need to trim O(100) PGs.
>>
>> Hmm. I'm actually seeing this in a system where the problematic snap=
s
>> could *only* have been RBD snaps.
>>
>
> True, as am I. The current sleep is useful in this case, but since we=
'd normally only expect up to ~100 of these PGs per OSD, the trimming o=
f 1 snap across all of those PGs would finish rather quickly anyway. La=
tency would surely be increased momentarily, but I wouldn't expect 90s =
slow requests like I have with the 30000 snap_trimq single PG.
>
> Possibly the sleep is useful in both places.
>
>> > We could move the snap trim sleep into the SnapTrimmer state machi=
ne, for example in ReplicatedPG::NotTrimming::react. This should allow =
other IOs to get through to the OSD, but of course the trimming PG woul=
d remain locked. And it would be locked for even longer now due to the =
sleep.
>> >
>> > To solve that we could limit the number of trims per instance of t=
he SnapTrimmer, like I=E2=80=99ve done in this pull req: https://github=
=2Ecom/ceph/ceph/pull/2516
>> > Breaking out of the trimmer like that should allow IOs to the trim=
ming PG to get through.
>> >
>> > The second aspect of this issue is why are the purged_snaps being =
lost to begin with. I=E2=80=99ve managed to reproduce that on my test c=
luster. All you have to do is create many pool snaps (e.g. of a nearly =
empty pool), then rmsnap all those snapshots. Then use crush reweight t=
o move the PGs around. With debug_osd>=3D10, you will see "adding snap =
1 to purged_snaps=E2=80=9D, which is one signature of this lost purged_=
snaps issue. To reproduce slow requests the number of snaps purged need=
s to be O(10000).
>>
>> Hmmm, I'm not sure if I confirm that. I see "adding snap X to
>> purged_snaps", but only after the snap has been purged. See
>> https://gist.github.com/fghaas/88db3cd548983a92aa35. Of course, the
>> fact that the OSD tries to trim a snap only to get an ENOENT is
>> probably indicative of something being fishy with the snaptrimq and/=
or
>> the purged_snaps list as well.
>>
>
> With such a long snap_trimq there in your log, I suspect you're seein=
g the exact same behavior as I am. In my case the first snap trimmed is=
 snap 1, of course because that is the first rm'd snap, and the content=
s of your pool are surely different. I also see the ENOENT messages... =
again confirming those snaps were already trimmed. Anyway, what I've ob=
served is that a large snap_trimq like that will block the OSD until th=
ey are all re-trimmed.

That's... a mess.

So what is your workaround for recovery? My hunch would be to

- stop all access to the cluster;
- set nodown and noout so that other OSDs don't mark spinning OSDs
down (which would cause all sorts of primary and PG reassignments,
useless backfill/recovery when mon osd down out interval expires,
etc.);
- set osd_snap_trim_sleep to a ridiculously high value like 10 or 30
so that at least *between* PGs, the OSD has a chance to respond to
heartbeats and do whatever else it needs to do;
- let the snap trim play itself out over several hours (days?).

That sounds utterly awful, but if anyone has a better idea (other than
"wait until the patch is merged"), I'd be all ears.

Cheers
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
