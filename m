From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Thu, 19 Dec 2013 06:22:56 -0200
Message-ID: <orzjnx5jxb.fsf@livre.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
	<or7gb3ad3w.fsf@livre.home> <orwqj38u3w.fsf@livre.home>
	<orsitr8slc.fsf@livre.home>
	<CAPYLRzjfiXYbe=kCbz+VpucH=GLGkFu+n-t=5wLsFCohF5pcjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:51440 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab3LSIXZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 03:23:25 -0500
In-Reply-To: <CAPYLRzjfiXYbe=kCbz+VpucH=GLGkFu+n-t=5wLsFCohF5pcjQ@mail.gmail.com>
	(Gregory Farnum's message of "Wed, 18 Dec 2013 11:35:40 -0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Dec 18, 2013, Gregory Farnum <greg@inktank.com> wrote:

> (you've never been getting a real point-in-time
> snapshot, although as long as you didn't use external communication
> channels you could at least be sure it contained a causal cut).

I never expected more than a causal cut, really (my wife got a PhD in
consistent checkpointing of distributed systems, so my expectations may
be somewhat better informed than those a random user might have ;-),
although even now I've seldom got a snapshot in which the osd data
differs across replicas (I actually check for that; that's part of my
reason for taking the snapshots in the first place), even when I fail t=
o
explicitly make the cluster quiescent.  But that's probably just =E2=80=
=9Cluck=E2=80=9D,
as my cluster usually isn't busy when I take such snapshots ;-)

> And of course that's nothing compared to snapshotting the monitors, a=
s
> you've noticed

I've given it some more thought, and it occurred to me that, if we make
mons take the snapshot when the snapshot-taking request is committed to
the cluster history, we should have the snapshots taking at the right
time and without the need for rolling them back and taking them again.

The idea is that, if the snapshot-taking is committed, eventually we'll
have a quorum carrying that commit, and thus each of the quorum members
will have taken a snapshot as soon as they got that commit, even if the=
y
did so during recovery, or if they took so long to take the snapshot
that they got kicked out of the quorum for a while.  If they get
actually restarted, they will get the commit again and take the snapsho=
t
from the beginning.  If all mons in the quorum that accepted the commit
get restarted so that none of them actually records the commit request,
and it doesn't get propagated to other mons that attempt to rejoin,
well, it's as if the request had never been committed.  OTOH, if it did
get to other mons, or if any of them survives, the committed request
will make to a quorum and eventually to all monitors, each one taking
its snapshot at the time it gets the commit.

This should work as long as all mons get recovery info in the same
order, i.e., they won't get into their database history information tha=
t
happens-after the snapshot commit before the snapshot commit, nor will
they fail to get information that happened-before the snapshot commit
before getting the snapshot commit.  That said, having little idea of
the inner workings of the monitors, I can't tell whether they actually
meet this =E2=80=9Cas long as=E2=80=9D condition ;-(

> =E2=80=94 but making it actually be a cluster snapshot (instead
> of something you could basically do by taking a btrfs snapshot
> yourself)

Taking btrfs snapshots manually over several osds on several hosts is
hardly a way to get a causal cut (but you already knew that ;-)

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
