From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: giant integration branch for v0.87.1 ready for QE
Date: Wed, 11 Feb 2015 17:33:43 -0500 (EST)
Message-ID: <790240725.15932502.1423694023165.JavaMail.zimbra@redhat.com>
References: <54DA3DD6.7070108@dachary.org> <54DB757E.2000009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:34104 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbBKWep convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 17:34:45 -0500
In-Reply-To: <54DB757E.2000009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


I am planning to run a complete set of tests for this release in Sepia.

Will temporarily disable all *giant* suites in crontab before 4 pm toda=
y and schedule all suites to run with high priority.

Pls let me know if you have concerns or have emergency need for resourc=
es in Sepia lab.


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
