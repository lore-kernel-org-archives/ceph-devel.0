From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Thu, 18 Sep 2014 19:03:59 +0200
Message-ID: <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:55313 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaIRREU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 13:04:20 -0400
Received: by mail-qc0-f177.google.com with SMTP id o8so1717081qcw.22
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 10:04:19 -0700 (PDT)
In-Reply-To: <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Dan,

saw the pull request, and can confirm your observations, at least
partially. Comments inline.

On Thu, Sep 18, 2014 at 2:50 PM, Dan Van Der Ster
<daniel.vanderster@cern.ch> wrote:
>>> Do I understand your issue report correctly in that you have found
>>> setting osd_snap_trim_sleep to be ineffective, because it's being
>>> applied when iterating from PG to PG, rather than from snap to snap=
?
>>> If so, then I'm guessing that that can hardly be intentional=E2=80=A6
>
>
> I=E2=80=99m beginning to agree with you on that guess. AFAICT, the no=
rmal behavior of the snap trimmer is to trim one single snap, the one w=
hich is in the snap_trimq but not yet in purged_snaps. So the only time=
 the current sleep implementation could be useful is if we rm=E2=80=99d=
 a snap across many PGs at once, e.g. rm a pool snap or an rbd snap. Bu=
t those aren=E2=80=99t a huge problem anyway since you=E2=80=99d at mos=
t need to trim O(100) PGs.

Hmm. I'm actually seeing this in a system where the problematic snaps
could *only* have been RBD snaps.

> We could move the snap trim sleep into the SnapTrimmer state machine,=
 for example in ReplicatedPG::NotTrimming::react. This should allow oth=
er IOs to get through to the OSD, but of course the trimming PG would r=
emain locked. And it would be locked for even longer now due to the sle=
ep.
>
> To solve that we could limit the number of trims per instance of the =
SnapTrimmer, like I=E2=80=99ve done in this pull req: https://github.co=
m/ceph/ceph/pull/2516
> Breaking out of the trimmer like that should allow IOs to the trimmin=
g PG to get through.
>
> The second aspect of this issue is why are the purged_snaps being los=
t to begin with. I=E2=80=99ve managed to reproduce that on my test clus=
ter. All you have to do is create many pool snaps (e.g. of a nearly emp=
ty pool), then rmsnap all those snapshots. Then use crush reweight to m=
ove the PGs around. With debug_osd>=3D10, you will see "adding snap 1 t=
o purged_snaps=E2=80=9D, which is one signature of this lost purged_sna=
ps issue. To reproduce slow requests the number of snaps purged needs t=
o be O(10000).

Hmmm, I'm not sure if I confirm that. I see "adding snap X to
purged_snaps", but only after the snap has been purged. See
https://gist.github.com/fghaas/88db3cd548983a92aa35. Of course, the
fact that the OSD tries to trim a snap only to get an ENOENT is
probably indicative of something being fishy with the snaptrimq and/or
the purged_snaps list as well.

> Looking forward to any ideas someone might have.

So am I. :)

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
