From: Loic Dachary <loic@dachary.org>
Subject: Stable releases preparation temporarily stalled
Date: Wed, 6 Jan 2016 15:30:46 +0100
Message-ID: <568D2516.2030706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39230 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbcAFOav (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jan 2016 09:30:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

The stable releases (hammer, infernalis) did not make progress in the p=
ast few weeks because we can't run tests.

Before xmas the following happened:

* the sepia lab was migrated and we discovered the OpenStack teuthology=
 backend can't run without it (that was a problem during a few days onl=
y)
* there are OpenStack specific failures in each teuthology suites and i=
t is non trivial to separate them from genuine backport errors
* the make check bot went down (it was partially running on my private =
hardware)

If we just wait, I'm not sure when we will be able to resume our work b=
ecause:

* the sepia lab is back but has less horsepower than it did
* not all of us have access to the sepia lab
* the make check bot is being worked on by the infrastructure team but =
it is low priority and it may take weeks before it's back online
* the ceph-qa-suite errors that are OpenStack specific are low priority=
 and it may never be fixed

I think we should rely on the sepia lab for testing for the foreseeable=
 future and wait for the make check bot to be back. Tests will take a l=
ong time to run, but we've been able to work with a one week delay befo=
re so it's not a blocker.

Although fixing OpenStack specific errors would allow us to use the teu=
thology OpenStack backend (I will fix the last error left in the rados =
suite), it is unrealistic to set that as a requirement to run tests: we=
 don't have the workforce nor the skills to do that. Hopefully, some ti=
me in the future, Ceph developers will  use ceph-qa-suite on OpenStack =
as part of the development workflow. But right now running ceph-qa-suit=
e on OpenStack suites is outside of the development workflow and in a s=
tate of continuous regression which is inconvenient for us because we n=
eed something stable to compare the runs from the integration branch.

=46ixing the make check bot is a two part problem. Each failed run must=
 be looked at to chase false negatives (continuous integration with fal=
se negatives is a plague), which I did in the past year on a daily basi=
s and I'm happy to keep doing. Before xmas break the bot running at jen=
kins.ceph.com sent over 90% false negative, primarily because it was tr=
ying to run on unsupported operating systems and it was stopped until t=
his is fixed. It also appears that the machine running the bot is not r=
e-imaged after each test, meaning a bugous run may taint all future tes=
ts and create a continuous flow of false negative. Addressing these two=
 issues require knowing or learning about the Ceph jenkins setup and sl=
ave provisioning. This probably is a few days of work, reason why the i=
nfrastructure team can't resolve that immediately.

If you have alternative creative ideas on how to improve the current si=
tuation, please speak up :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
