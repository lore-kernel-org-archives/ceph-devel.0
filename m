From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Tue, 26 May 2015 12:13:46 -0400 (EDT)
Message-ID: <1094270224.6326426.1432656826948.JavaMail.zimbra@redhat.com>
References: <5559DE24.4010601@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:59363 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbEZQOv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 12:14:51 -0400
In-Reply-To: <5559DE24.4010601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Loic

This hammer release QE validation is taking unusually long time and has=
 issues that has to be clarified.=20

All test results were summarized in http://tracker.ceph.com/issues/1149=
2

There are several reasons contributing to slowness of this validation, =
product related as well as infrastructure related, also high amount of =
tests make turn around time slower as well.

I think some suites, e.g. rados and upgrades for example will have to b=
e re-run after issues had been clarified/fixed.

rados, krbd, knfs, samba suite test results need reviews by the team le=
ads.

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <abhi=
shek.lekshmanan@gmail.com>
Sent: Monday, May 18, 2015 5:42:12 AM
Subject: hammer branch for v0.94.2 ready for QE

Hi Yuri,

The hammer branch for v0.94.2 as found at https://github.com/ceph/ceph/=
commits/hammer has been approved by Greg, Yehuda, Josh and Sam and is r=
eady for QE. For the record, the head is https://github.com/ceph/ceph/c=
ommit/63832d4039889b6b704b88b86eaba4aadcfceb2e and the details of the t=
ests run are at http://tracker.ceph.com/issues/11492

Note that it has two more commits compared to what you tested before:

https://github.com/ceph/ceph/commit/293affe992118ed6e04f685030b2d83a794=
ca624 fixing http://tracker.ceph.com/issues/11622
https://github.com/ceph/ceph/commit/a43d24861089a02f3b42061e482e05016a0=
021f6 fixing http://tracker.ceph.com/issues/11604

which address two blockers that you listed at http://tracker.ceph.com/i=
ssues/11492#QE-Validation

These two new commits only have influence, directly or indirectly, on r=
gw. They do not require or deserve a new run of the rados, fs or rbd su=
ite because none of them depend on rgw, directly or indirectly.

The other two issues listed as blockers are

http://tracker.ceph.com/issues/11613#note-4 do not need a backport to h=
ammer
http://tracker.ceph.com/issues/11591 is a teuthology related issue that=
 can be worked around and does not need to be a blocker for hammer

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre







--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
