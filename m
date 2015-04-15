From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Request for static uid/gid for ceph
Date: Wed, 15 Apr 2015 19:10:16 +0200
Message-ID: <87egnl2u87.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:34893 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745AbbDORTU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 13:19:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: base-passwd@packages.debian.org
Cc: Sage Weil <sweil@redhat.com>, Tim Serong <tserong@suse.com>, ceph-devel@vger.kernel.org, Ken Dreyer <kdreyer@redhat.com>, ceph-maintainers@ceph.com, timm@fnal.gov

--=-=-=
Content-Type: text/plain


Hi

Ceph is currently developing unprivileged user support, and the upstream
developers are asking each of the distros to allocate a static numerical
UID for the "ceph" user and group.

The reason for the static number is to allow Ceph users to hot-swap hard
drives from one OSD server to another. Currently this practice works
because Ceph writes its files as "uid 0", but when Ceph starts writing
its files as an unprivileged user, it will be nice to allow
administrators to unplug a drive and plug it into another computer and
everything to just work.

For this I'm requesting an uid and gid from the reserved range
60000-64999 according to the process outlined in
https://anonscm.debian.org/cgit/users/cjwatson/base-passwd.git/tree/README.

Thanks,
Gaudenz


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVS6bec3PKyWkzVd5AQpK9A/9GGrLn//sfhrxeN2xNe1psxRuUFTNPZuJ
2d2pCXIPkBYirLLuoBUvcVdb3qd65XEzyByan6Kw7fI7HBiyZz/EDlN6EFwCVX+Y
GhcOXLsNxTdL0POAh1RHpUxFkTXQFaxAbIApEfB7I0sKqdm+x/6q4pEXfNW8Dy9F
7+THEjd+1T9cCyk2Yd1GQGtE97uwKrdzLsCEa8Ftfvrk0qtbex7k6TgJ5lOkRQXf
nyUKDlxBv8B3QIr6PQ1OG/9sefDAsAlp58J4kLMz/f+9aA9RFL/jLZjzngRRzJ/f
Ft3cSy8rZK8fw6LafUJf4nhRnaO4ayCf0DC4oifYtsiw4boZaAxo0wEVJJsaMkcM
8fp/JTb0YnT8Nx7zfm5n8qpkh0oUBciX04kB/uEhCB1+49as6M41glTNOa2zCcpf
dx3cY4l44KEyeeO904NDmrdsF2f4oxjc6PKTDpdvc276q+VShbUQDQcuqSCPRxJW
y9coC5A1UF4rvIoGhsunpRlsO0vbnWtg000P/UaJkgtMMGdsxzjA/HwvKwFCLYo4
kMMPpYgfYeNPnh6/0n91c5COOzCSddIZdMwGKmf0wfCsK6ImEAwSHFKTqRHDKuNP
U+6aW11HoCTzy+xkjG59g0M5Oqpn7mPiowXxLJE3U8vGaP/YvreaKJtUFNTT+aZC
w4p1j166ue4=
=lGI/
-----END PGP SIGNATURE-----
--=-=-=--
