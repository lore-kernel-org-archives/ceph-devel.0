From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Disabling the "old" dashboard in the dashboard v2 pull request?
Date: Wed, 14 Feb 2018 12:44:54 +0100
Message-ID: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Zc1kIKKOTteAcu0LHY8AXCObRrpOXRDh5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967448AbeBNLo5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:44:57 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5813EAAF1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 11:44:55 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zc1kIKKOTteAcu0LHY8AXCObRrpOXRDh5
Content-Type: multipart/mixed; boundary="zdSBXENmSdrB7WWkB81h0uolaTO8Wik3c";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
Subject: Disabling the "old" dashboard in the dashboard v2 pull request?

--zdSBXENmSdrB7WWkB81h0uolaTO8Wik3c
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

this question came up during our dashboard v2 sync call yesterday. The
first milestone for dashboard v2 is reaching feature parity with the
existing dashboard that is currently included in Luminous and master.

Once this point has been reached, we would like to submit our initial PR
against master for inclusion into the Mimic release.

Should this PR also take care of removing the existing dashboard code
and introduce dashboard v2 as the replacement? Currently, we develop the
code in parallel to the existing dashboard, using "dashboard_v2" as the
directory name and namespace in several places.

It would be much easier for us if we could start using the "dashboard"
namespace right away, rather than replacing that string in many places
after the PR was merged and we decided to retire the original dashboard.

Are there any objections/concerns about aiming at replacing the original
dashboard with the initial v2 submission?

Thanks,

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--zdSBXENmSdrB7WWkB81h0uolaTO8Wik3c--

--Zc1kIKKOTteAcu0LHY8AXCObRrpOXRDh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWoQhNgAKCRBJUOEqsnKR
8t1xAJ9Wml5EtyQOpGHSDrWFY7f6eNXeBACeML7uL8fOJHQwDhNBRjLcLbgOMLs=
=2JFX
-----END PGP SIGNATURE-----

--Zc1kIKKOTteAcu0LHY8AXCObRrpOXRDh5--
