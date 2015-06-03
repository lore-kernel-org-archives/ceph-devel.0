From: Owen Synge <osynge@suse.com>
Subject: packaging init systems in a more autoools style way.
Date: Wed, 03 Jun 2015 17:32:41 +0200
Message-ID: <556F1E19.6080704@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:40335 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbbFCPd5 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 3 Jun 2015 11:33:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear ceph-devel,

Linux has more than one init systems.

We in SUSE are in the process of up streaming our spec files, and all
our releases are systemd based.

Ceph seems more tested with sysVinit upstream.

We have 3 basic options for doing this in a packaged upstream system.

1) We dont install init scripts/config as part of "make install" and
"install all the init components via conditionals in the spec file.

2) We install all init scripts/config for all flavours of init using
make install and delete unwanted init systems via conditionals in the
spec file.

3) We add autotools an conditional for each init system, and only
install with make install enabled init systems scripts/config.

------

We are currently following policy (1)

I propose we follow policy (3) because (1) makes many distribution
specific conditionals and requires duplication for each platform for al=
l
files not installed with "make install".

-----

Their are many ways to follow policy 3 so I would propose that when no
init system is followed, policy (1) and policy (3) should appear identi=
cal.

-----

=46or a transition period between following policy (1) to policy (3)

phase (1)

I would expect we would add a conditional to ceph.spec for suse to add
to the configure step:

	--with-init-systemd

And when other distributions want to move to a full systemd flavour the=
y
also add a similar conditional.

phase (2)

We add a new configure level conditional:

	--with-init-sysv

All sysV init installs are removed from from the spec file and added to
the "make install" process.

phase (3)

Distributions with more than one init system, or init systems that can
emulate sysVinit, can build packages with either init system and so
migration can be tested.

-----

Does anyone object to this plan?
Does anyone agree with this plan?
Does anyone see difficulties with the plan?

Best regards

Owen


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
