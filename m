From: Owen Synge <osynge@suse.com>
Subject: Re: systemd support
Date: Wed, 08 Jul 2015 17:28:55 +0200
Message-ID: <559D41B7.5020705@suse.com>
References: <55970AFF.3020603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59281 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbbGHPaa (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 8 Jul 2015 11:30:30 -0400
In-Reply-To: <55970AFF.3020603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Dear All,

We have working SUSE systemd support using the master systemd files.

The only things that prove tricky is merging it to master.

You can find it working here

https://github.com/SUSE/ceph/tree/distro/suse-0-80-9

We also have a release for hammer.

The problem is that nearly every change also requires a synchronised
change with the spec file.

Since I cant test on the same platform as upstream, (Due to silly side
effects of using EPEL) and quiet reasonable upstream insist that no
change breaks their current system moving this upstream had to be
blocked until master could build suse for my tests.

I have some 3 pull requests this in particular that contains a nearly
working system:

https://github.com/ceph/ceph/pull/5029

BUt the (quiet reasonable) demands of the spec file reviewers caused th=
e
delay, and level of changes to be too geate for me to get this task don=
e
in the desired window of time.

At this moment I need to work on ceph-deploy and will be at least a wee=
k
before I can get back to tidying the pull requests for master.

Best regards

Owen

On 07/04/2015 12:21 AM, Loic Dachary wrote:
> [cc'ing ceph-devel in case someone else has the answer]
>=20
> Hi Ken,
>=20
> I know very little about systemd and I'd like to learn more. My under=
standing is that we have some support in the current master branch, but=
 it is incomplete. Are there differences with what I would find in the =
Red Hat Storage 1.3 packages ? If I'm not mistaken RHEL7 uses systemd, =
therefore I guess there may be a better support there. Unless it's usin=
g the legacy sysvinit files ?
>=20
> Cheers
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
