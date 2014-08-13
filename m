From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: [PATCH 0/3] WIP-8112 radosgw usage & man update
Date: Wed, 13 Aug 2014 16:25:54 +0530
Message-ID: <87fvh0bq54.fsf@gmail.com>
References: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com> <CABBk=J8ceLh4i_DiGRS4yq1rhdNr5ssookFu8__c5ohxyTjqpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43407 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaHMLMi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 07:12:38 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so8401892pdi.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Aug 2014 04:12:38 -0700 (PDT)
In-reply-to: <CABBk=J8ceLh4i_DiGRS4yq1rhdNr5ssookFu8__c5ohxyTjqpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hi 

Actually there was a minor error in the above patchset, the help options
should have come before `generic_server_usage()` as the function exits
after that. I have updated this as a PR at https://github.com/ceph/ceph/pull/2248

This should hopefully close the issues http://tracker.ceph.com/issues/8112 
and related http://tracker.ceph.com/issues/8864. However as mentioned in #8112
teuthology shows some apache conf file location options being passed for
apache conf & rgw ops log etc. I'm not sure whether those (and a few
others options related to rgw seen in common/config_opts.h) should be
displayed in help. Let me know if any other options are to be documented
we can close this.


--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

=2D-=20
Abhishek

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJT60foAAoJEPnwZB8bZe1fAa4H/1hCPP4k516I4ZPNZO+HzTpU
QzIjlGQvTFKjg66Q6emxcLNTQK8fwUKxIAqL4TQlIZ5O7E2DVMrXYnXzd49AHJQE
+UJpLAEJv2HJGsHP7LOlSQUvEwzDT5txxFT8AqhQl8SlJoQJAws7/REsVDSlH/f2
4BLeR/bE/jzIilhivwamyYmMa8OTr+BTlP63QC6lqpv5H8i5rPWFkcLZHy1lW8MS
D3YqjQjtc3eLcuNVvB6JrP/oQoyRCiY0Kbm6bpTrfHf8JT+tJUk9f0n5gkel9fvm
WMTlsGC/58aTC4Pwl8micXAoehzRjLDpA/7Ovc/Nm3P167i+aINrGEtp2tAVcjg=
=X1KZ
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
