From: Loic Dachary <loic@dachary.org>
Subject: Ceph stable release team: call for participation
Date: Wed, 24 Feb 2016 12:19:47 +0700
Message-ID: <56CD3D73.1000204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33372 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcBXFT5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 00:19:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Ceph,

TL;DR: If you have one day a week to work on the next Ceph stable relea=
ses [1] your help would be most welcome.

The Ceph "Long Term Stable" (LTS) releases - currently hammer[2] - are =
used by individuals, non-profits, government agencies and companies for=
 their production Ceph clusters. They are also used when Ceph is integr=
ated into larger products, such as hardware appliances. Ceph packages f=
or a range of supported distribution are available at http://ceph.com/.=
 Before the packages for a new stable release are published, they are c=
arefully tested for potential regressions or upgrade problems. The Ceph=
 project makes every effort to ensure the packages published at http://=
ceph.com/ can be used and upgraded in production.

The Stable release team[3] plays an essential role in the making of eac=
h Ceph stable release. In addition to maintaining an inventory of bugfi=
xes that are in various stages of backporting[4], in most cases we do t=
he actual backporting ourselves[5]. We also run integration tests invol=
ving hundreds of machines[6] and analyze the test results when they fai=
l[7]. The developers of the bugfixes only hear from us when we're stuck=
 or to make the final decision whether to merge a backport into the sta=
ble branch. Our process is well documented[8] and participating is a re=
laxing experience (IMHO ;-). Every month or so we have the satisfaction=
 of seeing a new stable release published.

There are no pre-requistes to participate. Over time, it is an opportun=
ity to learn how the code base is organized. When trying to figure out =
which commit does not cherry-pick cleanly, you will learn some of the l=
ogic of the Ceph internals. Last but not least, running the integration=
 tests[6] and analyzing failures is a great way to know precisely what =
Ceph is capable of.

Nathan Cutler (SUSE) drives the next Hammer release[9] and Abhishek Var=
shney (Flipkart) drives the next Infernalis release[10]. Abhishek Leksh=
manan (SUSE) helps on all releases and M Ranga Swami Reddy (Reliance Ji=
o Infocomm Ltd.) learns the workflow by helping with Hammer. Loic Dacha=
ry (Red Hat), one of the Ceph core developers, oversees the process and=
 provides help and advice when necessary. After these two releases are =
published (which should happen in the next few weeks), the roles will c=
hange and we would like to invite you to participate. If you're employe=
d by a company using Ceph or doing business with it, maybe your manager=
 could agree to give back to the Ceph community in this way. You can jo=
in at any time and you will be mentored while the ongoing releases comp=
lete. When the time comes (and if you feel ready), you will be offered =
a seat to drive the next release.

Cheers

[1] Ceph Releases timeline http://ceph.com/docs/master/releases/
[2] Hammer v0.94.6 http://ceph.com/docs/master/release-notes/#v0-94-6-h=
ammer
[3] Stable release team http://tracker.ceph.com/projects/ceph-releases
[4] Hammer backports http://tracker.ceph.com/projects/ceph/issues?query=
_id=3D78
[5] Backporting commits http://tracker.ceph.com/projects/ceph-releases/=
wiki/HOWTO_backport_commits
[6] Integration tests http://tracker.ceph.com/projects/ceph-releases/wi=
ki/HOWTO_run_integration_and_upgrade_tests
[7] Forensic analysis of integration tests http://tracker.ceph.com/proj=
ects/ceph-releases/wiki/HOWTO_forensic_analysis_of_integration_and_upgr=
ade_tests
[8] Ceph Stable releases home page http://tracker.ceph.com/projects/cep=
h-releases/wiki/HOWTO
[9] Hammer v0.94.7 http://tracker.ceph.com/issues/14692
[10] Infernalis v9.2.1 http://tracker.ceph.com/issues/13750

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
