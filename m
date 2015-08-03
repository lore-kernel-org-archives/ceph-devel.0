From: Owen Synge <osynge@suse.com>
Subject: Fedora 22 systemd and ceph-deploy
Date: Mon, 03 Aug 2015 21:01:45 +0200
Message-ID: <55BFBA99.4070205@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:42421 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932085AbbHCTDo (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 3 Aug 2015 15:03:44 -0400
In-Reply-To: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Dear all,

My plan is to make a fedora22-systemd branch. I will leave fedora 20 as
sysvinit.

Ok just done my first proper install of systemd ceph branch on fedora22=
=2E

I can confirm most of the issues.

I am giving up for the day, but so far applying SUSE/opensuse code to
=46edora ceph-deploy code in ceph-deploy has helped a lot.

    cp /usr/lib/python2.7/site-packages/ceph_deploy/hosts/suse/mon/* \
      /usr/lib/python2.7/site-packages/ceph_deploy/hosts/fedora/mon/

(Running on suse version patched release)

It can now set up the mon daemons correctly its self.

I will look into the udev rules, tomorrow morning, and remove some more
fedora hard coding to "sysvinit".

Best regards

Owen


On 07/28/2015 09:13 PM, Sage Weil wrote:
> Hey,
>=20
> I've finally had some time to play with the systemd integration branc=
h on=20
> fedora 22.  It's in wip-systemd and my current list of issues include=
s:
>=20
> - after mon creation ceph-create-keys isn't run automagically
>   - Personally I kind of hate how it was always run on mon startup an=
d not=20
> just during cluster creation so I wouldn't mind *so* much if this bec=
ame=20
> an explicit step, maybe triggered by ceph-deploy, after mon create.
>=20
> - udev's attempt to trigger ceph-disk isn't working for me.  the osd=20
> service gets started but the mount isn't present and it fails to star=
t. =20
> I'm a systemd noob and haven't sorted out how to get udev to log some=
thing=20
> meaningful to debug it.  Perhaps we should merge in the udev +=20
> systemd revamp patches here too...
>=20
> - ceph-detect-init is only recently unbroken in master for fedora 22.
>=20
> - ceph-deploy doesn't know that fedora should be systemd yet.
>=20
> - ceph-deploy has a wip-systemd branch with a few things so far:
>   - on mon create, we unconditionally systemctl enable ceph.target. =20
> i think osd create and mds create and rgw create should do the same t=
hing,=20
> since the ceph.target is a catch-all bucket for any ceph service, and=
 i=20
> don't think we want to enable it on install?
>   - rgw create and mds create don't work yet
>   - osd create doesn't enable ceph.target
>=20
> - I'm guessing my ceph.spec changes to install teh systemd unit files=
=20
> aren't quite right... please review!  The gitbuilder turnaround is so=
 slow=20
> it's hard to iterate and I don't really know what I'm doing here.
>=20
> Owen, I'd like to get this just a tad bit more functional and then me=
rge=20
> ASAP, then up any issues in the weeks leading up to infernalis.  What=
 say=20
> ye?
>=20
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer, HR=
B
21284 (AG
N=FCrnberg)

Maxfeldstra=DFe 5

90409 N=FCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
