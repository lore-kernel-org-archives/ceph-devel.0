From: Loic Dachary <loic@dachary.org>
Subject: Re: v10.0.4 released
Date: Wed, 16 Mar 2016 14:14:36 +0100
Message-ID: <56E95C3C.7080907@dachary.org>
References: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56492 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966055AbcCPNOl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 09:14:41 -0400
In-Reply-To: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi,

Because of a tiny mistake preventing deb packages to be built, v10.0.5 =
was released shortly after v10.0.4 and is now the current development r=
elease. The Stable release team[0] collectively decided to help by publ=
ishing development packages[1], starting with v10.0.5.

The packages for v10.0.5 are available at http://ceph-releases.dachary.=
org/ which can be used as a replacement for http://download.ceph.com/ f=
or both http://download.ceph.com/rpm-testing and http://download.ceph.c=
om/debian-testing . The only difference is the key used to sign the rel=
eases which can be imported with

    wget -q -O- 'http://ceph-releases.dachary.org/release-key.asc' | su=
do apt-key add -

or=20

    rpm --import http://ceph-releases.dachary.org/release-key.asc

The instructions to install development packages found at http://docs.c=
eph.com/docs/master/install/get-packages/ can otherwise be applied with=
 no change.

Cheers

[0] Stable release team http://tracker.ceph.com/projects/ceph-releases/=
wiki/HOWTO#Whos-who
[1] Publishing development releases http://comments.gmane.org/gmane.com=
p.file-systems.ceph.devel/30126

On 08/03/2016 22:35, Sage Weil wrote:
> This is the fourth and last development release before Jewel. The nex=
t=20
> release will be a release candidate with the final set of features. B=
ig=20
> items include RGW static website support, librbd journal framework, f=
ixed=20
> mon sync of config-key data, C++11 updates, and bluestore/kstore.
>=20
> Note that, due to general developer busyness, we aren=E2=80=99t build=
ing official=20
> release packages for this dev release. You can fetch autobuilt gitbui=
lder=20
> packages from the usual location (http://gitbuilder.ceph.com).
>=20
> Notable Changes
> ---------------
>=20
>         http://ceph.com/releases/v10-0-4-released/
>=20
> Getting Ceph
> ------------
>=20
> * Git at git://github.com/ceph/ceph.git
> * For packages, see http://ceph.com/docs/master/install/get-packages#=
add-ceph-development
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ce=
ph-deploy
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
