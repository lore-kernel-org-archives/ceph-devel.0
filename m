From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Wed, 27 May 2015 17:12:56 -0400 (EDT)
Message-ID: <694044148.7711595.1432761176105.JavaMail.zimbra@redhat.com>
References: <5559DE24.4010601@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:57884 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbE0VOC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 17:14:02 -0400
In-Reply-To: <5559DE24.4010601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

QE validation status.

All detailed information is summarized in http://tracker.ceph.com/issue=
s/11492

Team leads pls review for do "go"-"no-go" decision.

Issues to be considered:

rados - passed ~2.8K jobs, listed issues (#11660, #11661) are not block=
ers=20
(NOTE: we also agreed to use the "0/7th" rule for future point releases=
, e.g. passing "--subset 0/7" will be sufficient for release)

knfs - #11789, #11790 - per Sage - not blockers; Greg, John - agreed?

samba - I assumed that failured in http://pulpito.ceph.com/teuthology-2=
015-05-18_13:46:55-samba-hammer-testing-basic-multi/ due to #6613, Greg=
 pls confirm.

upgrade/client-upgrade - blocked by #11546 (3 jobs passed)
upgrade/firefly-x - blocked by #11546
upgrade/dumpling-firefly-x - blocked by #11546

Sage, Loic are you willing to push this release out without upgrade sui=
tes run due to packaging issues (NOTE: upgrade/giant-x -> hammer passed=
 on all distros)?

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
