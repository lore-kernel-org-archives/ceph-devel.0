From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 12:19:16 -0500 (EST)
Message-ID: <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com>
References: <54DA3A5B.5050509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:35433 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbBJRUT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:20:19 -0500
In-Reply-To: <54DA3A5B.5050509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


Loic,

The only difference between options if we run suits on merged dumpling =
vs dumpling-backports first - is time.
We will have to run suites on the final branch after the merge anyway.

Unless I hear otherwise, I will schedule suites to run on dumpling-back=
ports first (as you are suggesting, with higher priority) and then assu=
ming that we resolved all issues, we will run on the dumpling merged.=20

Sage, pls correct if this is not what has to be done.


Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Tuesday, February 10, 2015 9:05:31 AM
Subject: dumpling integration branch for v0.67.12 ready for QE

Hi Yuri,

The dumpling integration branch for v0.67.12 as found at https://github=
=2Ecom/ceph/ceph/commits/dumpling-backports has been approved by Yehuda=
, Josh and Sam and is ready for QE.=20

=46or the record, the head is https://github.com/ceph/ceph/commit/3944c=
77c404c4a05886fe8276d5d0dd7e4f20410

I think it would be best for the QE tests to use the dumpling-backports=
=2E The alternative would be to merge dumpling-backports into dumpling.=
 However, since testing may take a long time and require more patches, =
it probably is better to not do that iterative process on the dumpling =
branch itself. As it is now, there already are a number of commits in t=
he dumpling branch that should really be in the dumpling-backports: the=
y do not belong to v0.67.11 and are going to be released in v0.67.12. I=
n the future though, the dumpling branch will only receive commits that=
 have been carefully tested and all the integration work will be on the=
 dumpling-backports branch exclusively. So that third parties do not ha=
ve to worry that the dumpling branch contains commits that have not bee=
n tested yet.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
