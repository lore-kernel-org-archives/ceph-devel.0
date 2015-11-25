From: Gregory Farnum <gfarnum@redhat.com>
Subject: Scaling Ceph reviews and testing
Date: Wed, 25 Nov 2015 17:14:20 -0500
Message-ID: <CAJ4mKGbW56LFJy+_Swc=EF8AxbutBvCw5fei0kv_HUBnkhxLsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33268 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbKYWOW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Nov 2015 17:14:22 -0500
Received: by wmec201 with SMTP id c201so6176461wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Nov 2015 14:14:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Everybody,
Ceph is popular! The global community of developers is growing
quickly, and that=E2=80=99s leading to some challenges for our leads an=
d core
development team as we try to absorb incoming pull requests. Over the
past few weeks our leads have discussed (internally and with a few
external contributors) how to improve things, and we wanted to share
some conclusions.

It has been a long-standing requirement that all code be tested by
teuthology before being merged to master. In the past leads have
shouldered a lot of this burden through integration and testing
branches, but it=E2=80=99s become unsustainable in present form: some P=
Rs
which are intended as RFCs are being mistakenly identified as final;
some PRs are submitted which pass cursory sniff tests but fail under
recovery conditions that the teuthology suites cover. To prevent that,
please comment on exactly what testing you=E2=80=99ve performed when
submitting a PR and a justification why that is sufficient to promote
it to integration testing. Be prepared for us to request more specific
testing before doing a careful review if we think it=E2=80=99s warrante=
d: in
general, a run through the applicable regression suite (with new tests
added in a branch if applicable) will be required. Individual teams
and leads will develop specific regression testing requirements in the
near future.
=46or our most frequent and prolific contributors, we are going to star=
t
expecting that you perform the above testing on your own before we
move on to a serious review or our own integration tests =E2=80=94 this=
 should
be much easier thanks to Loic=E2=80=99s work on teuthology-openstack!

It has also been policy that new features and bug fixes are
accompanied by tests which 1) demonstrate functionality and 2) check
failure cases. In this arena some of us have been lax, but nightly
stability has suffered. Some of us have also written tests for
external contributions, but this simply doesn=E2=80=99t scale and we ar=
e
cutting back. If you believe that a patch you=E2=80=99ve submitted is a=
lready
covered by tests, please point them out. If it=E2=80=99s not covered by
existing testing, write new ones! Specifically, the new feature (or
bug) should be covered by the area=E2=80=99s regression suite.  In most=
 cases,
this will involve an addition to the ceph-qa-suite.  You should link
the branch with the change in the main ceph PR.  Your PR=E2=80=99s test=
ing
should be performed with that ceph-qa-suite branch (since the existing
ceph-qa-suite coverage is presumably insufficient). If you need
guidance on how best to automate testing, ask! If you submit a PR
without these, it will just get bounced back to you and slow everybody
down.

We believe that these adjustments to our merge habits and the workload
distribution will increase code quality, increase throughput, allow
faster merges, and prevent the frequent =E2=80=9Clost=E2=80=9D PRs requ=
iring rebases
that have been appearing over the last year. That will make Ceph
better for all of us.

Thanks!
-Greg
-Sam
-Yehuda
-Sage
-Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
