From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph backports workflow update
Date: Wed, 11 Feb 2015 09:27:41 -0800
Message-ID: <CAC6JEv_yFPoYnio3_6DovFx7E_a7VoEn36z9x5umupsYo0wGXw@mail.gmail.com>
References: <54D0CDDB.1020102@dachary.org>
	<54DB866C.9020908@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34465 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbbBKR1n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 12:27:43 -0500
Received: by iery20 with SMTP id y20so5702482ier.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 09:27:42 -0800 (PST)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by mx.google.com with ESMTPSA id ig15sm1696994igb.10.2015.02.11.09.27.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 09:27:41 -0800 (PST)
Received: by iecrl12 with SMTP id rl12so3247597iec.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 09:27:41 -0800 (PST)
In-Reply-To: <54DB866C.9020908@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 11, 2015 at 8:42 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> Yesterday the dumpling & giant backport integration branches were app=
roved by Yehuda, Sam and Josh and were handed over to QE. An interestin=
g discussion followed and it revealed that my understanding of the inte=
nded workflow was significantly wrong. It took me a while to figure out=
 something that makes sense. There is a good chance that I'm wrong agai=
n, please speak up :-)
>
> The workflow proposed a month ago was the following:
>
> 0. Developer follows normal process to land PR to master. Once comple=
te and ticket is marked Pending Backport this process initiates.
> 1. I periodically polls Redmine to look for tickets in Pending Backpo=
rt state and focus on the ones that are left unattended for too long
> 1a. Under the supervision of the author of the original patch, I find=
 the commits associated with the Redmine ticket and Cherry Pick to the =
backport integration branch off of the desired maintenance branch (Dump=
ing, Firefly, etc).
> 1b. I resolve any merge conflicts with the cherry-picked commit
> 2. I merge all backports for a given branch in an integration branch
> 3. I ask the leads of each project to review the integration
> 4. Once satisfied with group of backported commits to integration bra=
nch, I notify QE.
> 5. QE tests backport integration branch against appropriate suites
> 6a. If QE is satisfied with test results, they merge backport integra=
tion branch.
> 6b. If QE is NOT satisfied with the test results, they indicate backp=
ort integration branch is NOT ready to merge and return to me to work w=
ith original Developer to resolve issue and return to steps 2/3
> 7. Ticket is moved to Resolved once backport integration branch conta=
ining cherry-picked backport is merged to the desired mainteance branch=
(es)--
>
> I think it should be modified to something like the following: (I hav=
e the role of "the backporter"):
>
> 0. Developer follows normal process to land PR to master. Once comple=
te and ticket is marked Pending Backport this process initiates.
> 1. A cron job updates an inventory of the backports for each branch (=
see http://workbench.dachary.org/ceph/ceph-backports/wikis/firefly for =
instance)

How's it updating that inventory?

> 1a. The PR does not require integration (e.g. it changes the qa direc=
tory), it is merged in the release branch (dumpling, firefly, etc.) by =
the reviewer

Who are you expecting to create backport PRs? Way back when I thought
that you were assembling branches and PRs based on tickets in the
"Pending Backport" state, but now that looks not to be the case.

> 1b. The PR requires integration and the label "needs-qa" is added to =
it by the reviewer.

I thought the needs-qa label was a flag that it should go into a
master integration branch (wip-sam-testing, wip-sage-testing, w/e);
aren't the milestone LTS labels sufficient to indicate they should be
tested in integration?

> 2. If the inventory page shows PR that are pending integration
> 2a. The backporter merges them in the dumpling-backports, etc. integr=
ation branch
> 2b. The backporter runs the rados, rgw, rbd etc. suites on the integr=
ation branch (if no rgw backports are present, rgw suite can be skipped=
 etc.)
> 2c. The backporter sorts and analyzes the test results, asking the de=
veloper if necessary
> 2d. If a problem is found on a PR, the backporter removes the "needs-=
qa" label from the PR and makes sure the developer is aware that integr=
ation failed and why
> 2e. The PR successfully integrated are merged into the dumpling, fire=
lfy, etc. branch
> 3. A cron job runs various suites on the dumpling, firefly, etc. bran=
ches (AKA "the nightlies")
> 3a. The nightlies send reports to the ceph-qa list when a suite compl=
etes
> 3b. The leads of each component are responsible for analyzing and upd=
ating tracker.ceph.com accordingly

Mmm. I'm happy to look at suites that get run this way but I'm
unlikely to notice them go by on the list if I'm not poked about them
=E2=80=94 I generally filter out anything that has a person's name in i=
t or
whatever.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
