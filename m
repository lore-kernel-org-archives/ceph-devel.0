From: Loic Dachary <loic@dachary.org>
Subject: Re: v10.0.4 released
Date: Wed, 16 Mar 2016 17:04:23 +0100
Message-ID: <56E98407.2070902@dachary.org>
References: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
 <56E95C3C.7080907@dachary.org>
 <CADr68WZJiXKUp_0hD7Apd9zAifU1giAjrt9a+VJt_Knn0wNmLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55609 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbcCPQE2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 12:04:28 -0400
In-Reply-To: <CADr68WZJiXKUp_0hD7Apd9zAifU1giAjrt9a+VJt_Knn0wNmLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Rosenboom <j.rosenboom@x-ion.de>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 16/03/2016 16:10, Jens Rosenboom wrote:
> 2016-03-16 14:14 GMT+01:00 Loic Dachary <loic@dachary.org>:
>> Hi,
>>
>> Because of a tiny mistake preventing deb packages to be built, v10.0=
=2E5 was released shortly after v10.0.4 and is now the current developm=
ent release. The Stable release team[0] collectively decided to help by=
 publishing development packages[1], starting with v10.0.5.
>>
>> The packages for v10.0.5 are available at http://ceph-releases.dacha=
ry.org/ which can be used as a replacement for http://download.ceph.com=
/ for both http://download.ceph.com/rpm-testing and http://download.cep=
h.com/debian-testing . The only difference is the key used to sign the =
releases which can be imported with
>>
>>     wget -q -O- 'http://ceph-releases.dachary.org/release-key.asc' |=
 sudo apt-key add -
>>
>> or
>>
>>     rpm --import http://ceph-releases.dachary.org/release-key.asc
>>
>> The instructions to install development packages found at http://doc=
s.ceph.com/docs/master/install/get-packages/ can otherwise be applied w=
ith no change.
>=20
> Will there be tarballs for 10.0.5? Ubuntu has built native packages
> built for the upcoming Xenial LTS release, but IIUC they are still
> stuck at 10.0.2 because there are no tarball releases for the newer
> tags.

The tarbal (as created by make dist from sources) from which the debian=
 package was created is available at:

http://ceph-releases.dachary.org/debian-testing/pool/main/c/ceph/ceph_1=
0.0.5.orig.tar.gz

and is also linked at:

http://ceph-releases.dachary.org/tarballs/ceph-10.0.5.tar.gz
http://ceph-releases.dachary.org/tarballs/ceph-10.0.5.tar.gz.sha256

But the Ubuntu watch file do not point to this URL and won't find it.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
