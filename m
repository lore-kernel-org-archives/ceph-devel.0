From: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Wed, 22 Aug 2018 12:16:00 +0200
Message-ID: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

[sent both to ceph-devel and ceph-users lists, as it might be of
interest for both audiences]

Hi all,

This e-mail is just to announce the WIP on backporting dashboard_v2
(http://docs.ceph.com/docs/master/mgr/dashboard/) from master to
Luminous release.

The ultimate goal for this backport is to replace dashboard_v1 in
Luminous and provide, **as much as possible**, (see note below) a
level of functionality on a par with master's (i. e.: RBD and RGW
management, HTTPS support, User Management, Role Based Access Control,
Grafana integration, SSO, etc.).

NOTE: This will be mostly driven as a best-effort (currently one-army
man) task, as long as Luminous is N-2 and backports to Mimic (N-1)
have officially ceased. Besides, Luminous lacks some features that
Ceph Dashboard v2 exposes. Therefore, the policy to follow for this
backport will be:

1.- Backport by cherry-picking individual commits, except for merge
(PR) commits that comprise a large amount of commits (e.g.: PR #23271
with 163 commits).

2.A- Do not bring any new functionality from master to Luminous other
than dashboard_v2 (commit subject: {mgr,doc,test}/dashboard{,_v2},
paths: {src/pybind/mgr/dashboard, qa/suites/rados/mgr/tasks/dashboard}
+ building/testing {CMakeLists.txt, ceph.spec.in, vstart.sh,
debian/rules, etc.})

2.B- When dashboard_v2 exposes or relies on some master-only
functionality, modify dashboard code in the most minimal way to handle
that (e.g.: disable RBD OPERATIONS FEATURE,
https://github.com/ceph/ceph/commit/8479a91c4fa45b39ef5cf24a857751de3a5c630f)

3. Add the necessary 'glue' commits to ensure cherry-picked pieces of
code work smoothly (e.g.: due to different toolchain versions or
supported idioms, like the case of C++17, or other non-functional
deps).

The first chunk of this backporting is already in PR ready status
(https://ceph.com/planet/the-ceph-dashboard-v2-pull-request-is-ready-for-review/,
https://github.com/ceph/ceph/pull/23271,
http://tracker.ceph.com/issues/24788).

If anyone else wants to contribute either on the dev side, or as test
user (I may point you to the corresponding shaman builds), don't
hesitate to contact me (Github/IRC user: epuertat). For tracking the
progress of this activity or any further questions/suggestions, etc.,
you are welcome to show up at dashboard daily stand-ups or biweekly
sync meetings.

Kind Regards,

Ernesto
