From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Proposal for a Backport tracker
Date: Thu, 21 May 2015 19:08:36 +0530
Message-ID: <87r3qa6of7.fsf@gmail.com>
References: <555DC080.8050508@dachary.org> <555DD285.3050204@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35923 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015AbbEUNlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:41:03 -0400
Received: by pabts4 with SMTP id ts4so105762362pab.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 06:41:02 -0700 (PDT)
In-reply-to: <555DD285.3050204@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Nathan Cutler writes:

>> * a backport issue is created in the "Backport" tracker and is=20
>> "Related" to the original issue
>
> Hi Loic:
>
> I like the idea of having backport tickets in a separate Redmine
> subproject/issue tracker. In fact, I would go even a step further and
> have separate subprojects for each target version (hammer backports,
> firefly backports).

Agree with the idea of seperate subproject. Though I'm not having a
strong opinion on whether subprojects are needed for each version;
probably for issues which have multiple backports ie. backports to both
firefly & hammer for instance it might be a little bit more bookkeeping,
though from a maintainer standpoint; it is easier having a seperate
subproject, so either way is okay.=20

> Having all, e.g. hammer, backports in one place is advantageous in
> pretty much every way I can think of: easier to see what has been
> done, what needs to be done, easier to search, easier to automate,
> less risk of munging something not related to backports...
>

Agree, from a scripting standpoint, we could develop some tools to ease
out the process better, which should it make it easier in backports down
the line.

> It also has the effect of removing all the backport-related tickets
> from the bug tracker(s).




>
> Nathan

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVXd/nAAoJEPnwZB8bZe1fKeIH/2XwRbVh64AI+AisyaBskSIF
uVf4DetocqgEOXmzYas235Bql0Sx6QSkGWpOFSiOAJyhdW3pArIuQKMTjkFWT/CJ
rK3YCdsMGlytPdhtsSxKJQL1EdcICdHDNiEhlgXrCESMZB5LUIifCgGfALMmpnpR
AOd4FQ17IC9OlRn4714jaxTFUWA1SSk+HCnIXqEf+ZP2AiuP+W5gKIr9HycRkAJo
eHIgby3XjutJyy40kLCHbh8oVET/aJNeWt1dn051cM1BjyWgnqltcJrAnh6fGD3o
5je/gc6iTpi2sE0pboHKOFkRCFRwakmFHz4uUh9TPfFMJOfOFiMV80LOO0l1DFs=
=sX5/
-----END PGP SIGNATURE-----
--=-=-=--
