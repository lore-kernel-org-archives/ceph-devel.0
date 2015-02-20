From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: giant integration branch for v0.87.1 ready for QE
Date: Fri, 20 Feb 2015 16:49:32 -0500 (EST)
Message-ID: <1622340604.24695270.1424468972740.JavaMail.zimbra@redhat.com>
References: <54DA3DD6.7070108@dachary.org> <54DB757E.2000009@dachary.org> <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:45647 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbbBTVut convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 16:50:49 -0500
In-Reply-To: <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Team leads,

Please review QE validation results summary in http://tracker.ceph.com/=
issues/10501

Loic - this RC looks ready for release (in my opinion) !=20

Thx
YuriW

----- Original Message -----
=46rom: "Yuri Weinstein" <yweinste@redhat.com>
To: "Loic Dachary" <loic@dachary.org>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Monday, February 16, 2015 9:33:44 AM
Subject: Re: giant integration branch for v0.87.1 ready for QE

I have completed suites execution on giant branch (v0.87.1 RC)

All results are summarized in http://tracker.ceph.com/issues/10501 unde=
r "QE VALIDATION" section.
Some suites had to be run more then ones due to environment noise.

Two suites are being re-run now - upgrade:firefly-x and powecycle.

Next steps:
-  the team leads to review/confirm results
-  Loic - can you review and triage issues as needed.
-  two suites require results analysis:
   multimds
   rados (two known tickets, but need more checking) ## 10209, 9891
   krbd (two new tickets, but need more checking) ## 10889, 10890


Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Wednesday, February 11, 2015 7:30:06 AM
Subject: Re: giant integration branch for v0.87.1 ready for QE

Hi Yuri,

The giant-backports pull requests were merged into https://github.com/c=
eph/ceph/tree/giant which is not ready for testing.

=46or the record, the head is https://github.com/ceph/ceph/commit/78c71=
b9200da5e7d832ec58765478404d31ae6b5

Cheers

On 10/02/2015 18:20, Loic Dachary wrote:
> Hi Yuri,
>=20
> The giant integration branch for v0.87.1 as found at https://github.c=
om/ceph/ceph/commits/giant-backports has been approved by Yehuda, Josh =
and Sam and is ready for QE.=20
>=20
> For the record, the head is https://github.com/ceph/ceph/commit/6b08a=
729540c61f3c8b15c5a3ce9382634bf800c
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
