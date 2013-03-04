From: Gregory Farnum <greg@inktank.com>
Subject: Fwd: teuthology heads up
Date: Mon, 4 Mar 2013 14:15:50 -0800
Message-ID: <CAPYLRzh7rhqP6TncK-tJ-3TKL1Q4VKWP6Kf2kmnDfw=syhBcjg@mail.gmail.com>
References: <CAKMAVE90MStKRrY3wKrr66Ex07STEv3VObcrkjtcrUJUMrrijw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:50243 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab3CDWPv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 17:15:51 -0500
Received: by mail-qe0-f51.google.com with SMTP id nd7so4233113qeb.24
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 14:15:51 -0800 (PST)
In-Reply-To: <CAKMAVE90MStKRrY3wKrr66Ex07STEv3VObcrkjtcrUJUMrrijw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We probably should have sent this to ceph-devel in the first place =97 =
sorry guys!
-Greg


---------- Forwarded message ----------
=46rom: Sam Lang <sam.lang@inktank.com>
Date: Thu, Jan 31, 2013 at 7:40 AM
Subject: teuthology heads up
To: Dev <dev@inktank.com>


Hi All,

I just pushed a change to the way teuthology creates a test directory
on the plana nodes for each run.  Previously, everything went in
/tmp/cephtest.  Now it will place the test directory in
/home/ubuntu/cephtest/{testname}, where {testname} is the name given
to teuthology-schedule
(teuthology-2013-01-31_06:00:03-marginal-master-testing-basic).  Note
that each run now gets a separate test subdir, so if you go looking on
a node for the cause of a failure, it will be the subdir for that run
that has the test state.

If you run teuthology locally and don't specify a base test directory
in your .teuthology.yaml, the test directory will now be
/tmp/cephtest/{testname}, and if no name is specified for the run, it
will default to {user}@{host}-{date} (e.g.
slang@scout-2013-01-31_06:00:03).

If you want to put the test directory in /home/ubuntu/cephtest (like
scheduled runs do now), you need to add the following to your
=2Eteuthology.yaml:

base_test_dir: /home/ubuntu/cephtest

If you want the old behavior, you need to add the following to your
=2Eteuthology.yaml:

test_path: /tmp/cephtest

------

One more thing, a separate commit adds a dependency on the pyexpect
package, so you will need to rerun bootstrap to pick that up.

Thanks,
-sam
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
