From: John Spray <jspray@redhat.com>
Subject: Re: proposal to run Ceph tests on pull requests
Date: Mon, 7 Dec 2015 11:29:06 +0000
Message-ID: <CALe9h7eZZb5dXgu6cH5BWjhRtU2_R6NkfpFXgNz-SVOmf3hOiQ@mail.gmail.com>
References: <5662CF55.3050702@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35965 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbbLGL32 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 06:29:28 -0500
Received: by lbblt2 with SMTP id lt2so59180754lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 03:29:26 -0800 (PST)
In-Reply-To: <5662CF55.3050702@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Dec 5, 2015 at 11:49 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> TL;DR: a ceph-qa-suite bot running on pull requests is sustainable an=
d is an incentive for contributors to use teuthology-openstack independ=
ently

A bot for scheduling a named suite on a named PR, and posting the
results back the PR is definitely a good thing.

Thinking further about using commit messages to toggle the testing, I
think that this could get awkward when it's coupled to the human side
of code review.  When someone pushes a "how about this?" modification
they don't necessarily want to re-run the test suite until the
reviewer has okayed it, but then that means that they have to push
again, and the final thing that's tested would be a different SHA1
(hopefully the same code) than what the human last reviewed.  We'll
also have e.g. rebases, where there tends to be some discretion about
whether a rebase requires a re-test.

When you were talking about having the suite selected in the qa: tag,
there was the motivation to put it in the commit message so that it
would be preserved in backports.  However, if the "Needs-qa:" flag is
just a boolean, then I think it makes more sense to control it with a
github label or by posting a command in a PR comment.

I'm not sure how this really helps with the resource issues; for
example with the fs suite we would probably not be able to make a
finer-grained choice about what tests to run based on the diff.  The
part about randomly dropping a subset of tests when resources are low
doesn't make sense to me -- I think the bot should either give up or
enqueue itself.

Cheers,
John

> When a pull request is submitted, it is compiled, some tests are run[=
1] and the result is added to the pull request to confirm that it does =
not introduce a trivial problem. Such tests are however limited because=
 they must:
>
> * run within a few minutes at most
> * not require multiple machines
> * not require root privileges
>
> More extensive tests (primarily integration tests) are needed before =
a contribution can be merged into Ceph [2], to verify it does not intro=
duce a subtle regression. It would be ideal to run these integration te=
sts on each pull request but there are two obstacles:
>
> * each test takes ~ 1.5 hour
> * each test cost ~ 0.30 euros
>
> On the current master, running all tests would require ~1000 jobs [3]=
=2E That would cost ~ 300 euros on each pull request and take ~10 hours=
 assuming 100 jobs can run in parallel. We could resolve that problem b=
y:
>
> * maintaining a ceph-qa-suite map to be used as a white list mapping =
a diff to a set of tests. For instance, if the diff modifies the src/ce=
ph-disk file, it outputs the ceph-disk suite[4]. This would effectively=
 trim the tests that are unrelated to the contribution and reduce the n=
umber of tests to a maximum of ~100 [4] and most likely a dozen.
> * tests are run if one of the commits of the pull request has the *Ne=
eds-qa: true* flag in the commit message[5]
> * limiting the number of tests to fit in the allocated budget. If the=
re was enough funding for 10,000 jobs during the previous period and th=
ere was a total of 1,000 test run required (a test run is a set of test=
s as produced by the ceph-qa-suite map), each run is trimmed to a maxim=
um of ten tests, regardless.
>
> Here is an example:
>
> Joe submits a pull request to fix a bug in the librados API
> The make check bot compiles and fails make check because it introduce=
s a bug
> Joe uses run-make-check.sh locally to repeat the failure, fixes it an=
d repush
> The make check bot compiles and passes make check
> Joe amends the commit message to add *Needs-qa: true* and repushes
> The ceph-qa-suite map script finds a change on the librados API and o=
utputs smoke/basic/tasks/rados_api_tests.yaml
> The ceph-qa-suite bot runs the test smoke/basic/tasks/rados_api_tests=
=2Eyaml which fails
> Joe examines the logs found at http://teuthology-logs.public.ceph.com=
/ and decides to debug by running the test himself
> Joe runs teuthology-openstack --suite smoke/basic/tasks/rados_api_tes=
ts.yaml against his own OpenStack tenant [6]
> Joe repush with a fix
> The ceph-qa-suite bot runs the test smoke/basic/tasks/rados_api_tests=
=2Eyaml which succeeds
> Kefu reviews the pull request and has a link to the successful test r=
uns in the comments
>
> This approach scales with the size of the Ceph developer community [7=
] because regular contributors benefit directly from funding the ceph-q=
a-suite bot. New contributors can focus on learning how to interpret th=
e ceph-qa-suite error logs for their contribution and learn about how t=
o debug it via teuthology-openstack if needed, which is a better user e=
xperience than trying to figure out which ceph-qa-suite job to run, lea=
rning about teuthology, schedule the test and interpret the results.
>
> The maintenance workload of a ceph-qa-suite bot probably requires one=
 work day a week, to handle funding, sysadmin of the server where the b=
ot runs but mostly to sort out the false negatives. I believe a pure se=
lf-service approach where each contributor would be asked to run teutho=
logy-openstack independently would actually require more work. The ceph=
-qa-suite bot provides a baseline on which everybody can agree to sort =
out the false negatives. When a contributor runs teuthology-openstack b=
y herself/himself, it is difficult for her/him to figure out if a failu=
re comes from something she/he did incorrectly because she/he is not fa=
miliar with teuthology-openstack or if it is related to her/his contrib=
ution. She/He will asks for assistance  in situations where comparing h=
er/his run with the output of the ceph-qa-suite bot would probably give=
 her/him enough hints to fix the problem herself/himself.
>
> If the ceph-qa-suite bot becomes unavailable, the contributors are no=
t blocked because they can run it by themselves on their own OpenStack =
tenant and link the results to the pull request in the same way the bot=
 would. Debugging a failed test is essentially the same thing as runnin=
g the ceph-qa-suite bot.
>
> Cheers
>
> [1] run-make-check.sh https://github.com/ceph/ceph/blob/master/run-ma=
ke-check.sh
> [2] Ceph test suites https://github.com/ceph/ceph-qa-suite/tree/maste=
r/suites
> [3] teuthology-suite --suite .  --subset 1/40000
> [4] minimal number of tests to run all tasks at least once: 130 for r=
ados, 76 for fs, 113 for upgrade, 18 for rgw, 45 for rbd.
> [5] a former proposal was to include the test suite to run in the com=
mit message, but this is more difficult to maintain that a boolean flag=
 that states a given commit needs to pass all the relevant tests
> [6] teuthology-openstack https://github.com/dachary/teuthology/tree/o=
penstack#openstack-backend
> [7] Scaling out the Ceph community lab http://dachary.org/?p=3D3852
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
