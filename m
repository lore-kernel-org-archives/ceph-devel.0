From: Loic Dachary <loic@dachary.org>
Subject: GPG signing RPM packages : must not have subkeys
Date: Tue, 15 Mar 2016 18:28:21 +0100
Message-ID: <56E84635.8080109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34293 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934777AbcCOR20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 13:28:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Martin,

It turns out that the key created by=20

KEY=3D"$HOME/.ceph-workbench/release-team-key.asc"
if ! test -f $KEY ; then
  printf "Key-Type: 1\nKey-Length: 2048\nSubkey-Type: 1\nSubkey-Length:=
 2048\nName-Real: Release Team\nName-Email: contact@ceph.com\nExpire-Da=
te: 0" | GNUPGHOME=3D~/.ceph-workbench gpg --batch --gen-key
  GNUPGHOME=3D~/.ceph-workbench gpg --export --armor > $KEY
fi

cannot be used to verify RPM packages: rpm -K on the signed package cla=
ims the 69C8876E key is missing. It turns out to be related to the subk=
ey.=20

--------------------------------------------
pub   2048R/B8F1ACED 2016-03-11
      Key fingerprint =3D 7FEB E845 6F19 153B AAFC  2810 4597 2ACD B8F1=
 ACED
uid                  A Contributor <generous@ceph.com>
sub   2048R/69C8876E 2016-03-11

rpm -K complains that the 69C8876E key is not available. After removing=
 the subkey 69C8876E with gpg --edit-key and signing the RPM again, rpm=
 -K is happy. This does not make any sense to me and I suspect there is=
 an expert explanation that justify this behavior. The sensible way out=
 seems to create a passwordless key with no subkey to avoid that proble=
m. Do you happen to know how that can be done ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
