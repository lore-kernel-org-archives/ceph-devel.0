From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Mon, 09 Feb 2015 21:36:16 +0000
Message-ID: <54D92850.5080409@cam.ac.uk>
References: <54D78939.4000708@cam.ac.uk> <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54746 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761379AbbBIVf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 16:35:56 -0500
In-Reply-To: <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On 09/02/15 15:31, Gregory Farnum wrote:

> So, memory usage of an OSD is usually linear in the number of PGs it
> hosts. However, that memory can also grow based on at least one other
> thing: the number of OSD Maps required to go through peering. It
> *looks* to me like this is what you're running in to, not growth on
> the number of state machines. In particular, those past_intervals you
> mentioned. ;)

Hi Greg,

Right, that sounds entirely plausible, and is very helpful.

In practice, that means I'll need to be careful to avoid this situation=
=20
occurring in production =E2=80=94 but given that's unlikely to occur ex=
cept in=20
the case of non-trivial neglect, I don't think I need be particularly=20
concerned.

(Happily, I'm in the situation that my existing cluster is purely for=20
testing purposes; the data is expendable.)

That said, for my own peace of mind, it would be valuable to have a=20
procedure that can be used to recover from this state, even if it's=20
unlikely to occur in practice.

I'm currently running an experiment where I augment the RAM of each OSD=
=20
node with 10GB swapfiles on each spinning OSD disk, so that there's a=20
big-enough backing-store to complete log reconstruction.

(You obviously wouldn't want to operate in this manner during normal=20
production operation =E2=80=94 the loss of a single drive would cause a=
 hard=20
machine-crash, and the performance will be fairly diabolical,=20
particularly if you allow client workloads to carry on in the backgroun=
d.)

I did try enabling zswap on the Utopic LTS kernel as supplied as an=20
option in Ubuntu 14.04; however, the kernel was not stable in such a=20
configuration and several machines crashed under memory pressure.

I do have OSDs committing suicide periodically, probably because they'r=
e=20
insufficiently responsive to heartbeats as they start to hit swap.  Thi=
s=20
is before experimenting with the various OSD tuning dials for timeouts,=
=20
so some improvement may be possible.

In the meantime, I've configured the ceph-osd Upstart jobs to apply a=20
post-exec command of `sleep 3600` to reduce the rate at which they're=20
respawned.

So far, the resulting configuration seems to be making progress, albeit=
=20
moderately slowly.

Cheers,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
