From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling & giant backports update
Date: Tue, 10 Feb 2015 11:19:40 -0500 (EST)
Message-ID: <190003157.14855539.1423585180297.JavaMail.zimbra@redhat.com>
References: <54DA2303.9070003@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:36260 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbBJQUo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 11:20:44 -0500
In-Reply-To: <54DA2303.9070003@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic

I was thinking that as soon as one of the branches is declared "ready" =
we will merge *-backports with the main branch and execute appropriate =
set of suites as we run them in the Octo lab for released branches.

=46or dumpling:
rados
rbd
rgw
fs
ceph-deploy
upgrade/dumpling

=46or giant:
rados
rbd
rgw
fs
krbd
kcephfs
knfs
haddop
samba
rest
multimds
multi-version
upgrade/giant
powecycle

Not sure if we need to run more tests, e.g. giant-x kind of suites for =
upgrades.

Do you agree with this plan?=20

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yuri.weinstein@inktank.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Tuesday, February 10, 2015 7:25:55 AM
Subject: dumpling & giant backports update

Hi Yuri,

The dumpling integration branch https://github.com/ceph/ceph/commits/du=
mpling-backports is ready for Josh and Sam and we are expecting approva=
l from Yehuda (the details are here http://tracker.ceph.com/issues/1056=
0).

The giant integration branch https://github.com/ceph/ceph/commits/giant=
-backports is ready for Sam and we are expecting approval from Josh and=
 Yehuda (the details are here http://tracker.ceph.com/issues/10501).

It is likely that we get approval for one branch or the other in the ne=
xt 48h. When we do, I assume you will be conducting your own round of t=
esting, using the dumpling-backports and/or giant-backports branch. Do =
you have a list of suites you plan to run already ? I'm also curious to=
 understand who will be analyzing the results and ultimately declare th=
at it is ready to be released.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
