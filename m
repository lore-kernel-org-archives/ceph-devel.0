From: kefu chai <tchaikov@gmail.com>
Subject: conditionalize build on branch using jenkins
Date: Wed, 6 Dec 2017 15:18:57 +0800
Message-ID: <CAJE9aOM-h17ErsTjqX-0RFKBqnZ4Lvkh4G5ajSGoUFaBaOf4LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:43205 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdLFHS7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Dec 2017 02:18:59 -0500
Received: by mail-qt0-f177.google.com with SMTP id w10so6737667qtb.10
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 23:18:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hey Alfredo and other Cephers,

i am trying to disable master,mimic-* and probably PRs targeting these
branches building on trusty. otherwise the binaries built on trusty
with the new GCC ABI will not be able to run on trusty installation
without the new libstdc++ installed due to missing libstdc++ ABI
symbols. for more context, please see the recent discussion thread in
this mailing list, search "C++11, std::list_size(), and trusty"  for
it.

for example, if a branch is pushed to ceph/ceph-ci, jenkins will build
it, and upload the built packages to chacra. even if all trusty
testnodes are reimaged with xenial. we still want to make sure that
people using trusty won't run into troubles if they want to use the
packages built using our build infrastructure. so, we need to use the
old toolchain to build jewel and luminous.

so the status quo is:

- jewel, luminous, mimic-dev* and master built on trusty are using GCC-7

and the goal is to

1. build jewel and luminous on trusty with the old GCC shipped with the distro
2. do not build master, mimic-dev* branches on trusty

the same applies to the branches targeting respective releases pushed
to ceph/ceph-ci .

but after digging around in ceph/ceph-build, i realized that probably we need:

1. a naming convention for branches targeting jewel/luminous, like
wip-fix-a-bug-luminous.

this helps with solving goal #1: so we can skip the steps preparing
the GCC-7 when setup pbuilder.

this also helps with solving gobal #2: we have no way to tell if a wip
branch is targeting which release without actually cloning it and
looking at the source files or using "git describe". but typically,
jenkins will not have access to the source files or the .git directory
of a PR or a ceph-ci repo before the "ceph-*-setup" job. and i'd like
to prevent jenkins from scheduling a job at the very beginning: so the
only metadata at that phase is the "$GIT_BRANCH". that's why i suggest
use a naming convention for these branches. so jenkins is able to
identify them.

2. we need to have a "combination-filter"[1] referencing the
$GIT_BRANCH, like "!(["master", "mimic-dev1"].contains(branch) &&
DIST=="trusty)". where "branch" is an axis, calculated using
$GIT_BRANCH.

i am not sure if #2 is a feasible approach. because i *think* the
supported axises are setup when the jenkins-job-builder populate the
yaml configuration files to jenkins. if that's the case, we cannot
parameterize the "combination-filter" at run-time.


any idea or comment would be appreciated!


cheers,

---
[1] https://docs.openstack.org/infra/jenkins-job-builder/project_matrix.html


-- 
Regards
Kefu Chai
