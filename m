From: Loic Dachary <loic@dachary.org>
Subject: proposed ceph 10.1.0 release candidate & jenkins fix
Date: Tue, 22 Mar 2016 08:27:01 +0100
Message-ID: <56F0F3C5.9040803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39569 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbcCVH1G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 03:27:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Alfredo,

Now that ceph-disk and ceph-detect-init are proper python modules, buil=
ding Ceph uses pip and make check runs tox, which is great. When instal=
l-deps.sh runs, it prepares a directory (wheel) with dependencies, whic=
h allows pip install to run with no network access. And also seamlessly=
 enables the developer to get the latest dependencies when working onli=
ne.

Unfortunately it also created a problem when used in conjunction with j=
enkins. The long path used by jenkins overflows pip limitations. These =
long paths are a recurring annoyance but since there does not seem to b=
e a way to convince Jenkins to shorten them, I fixed Ceph to accommodat=
e jenkins[1].

In the meantime the packages for 10.1.0 have been built (off the curren=
t tip of the jewel branch) using the same process[2] as the previous de=
velopment release (10.0.5) and are available at:

http://ceph-releases.dachary.org/debian-testing/
http://ceph-releases.dachary.org/rpm-testing/

This is a drop-in replacement for http://download.ceph.com. The key use=
d to sign the packages is at http://ceph-releases.dachary.org/release-k=
ey.asc
We did not run into problems, primarily because we've been using the sa=
me build process when running jobs on a dynamically provisioned OpenSta=
ck teuthology cluster.

Cheers

[1] python: avoid long path https://github.com/ceph/ceph/pull/8250
[2] HOWTO publish a release http://tracker.ceph.com/projects/ceph-relea=
ses/wiki/HOWTO_publish_a_release

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
