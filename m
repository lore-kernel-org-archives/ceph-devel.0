From: kefu chai <tchaikov@gmail.com>
Subject: the teuthology "workunit" task now uses suite-repo:suite-sha1
Date: Sat, 25 Feb 2017 01:07:45 +0800
Message-ID: <CAJE9aOOxNJ_SAvnZRhtYzNLEMjTDT1GvJ9Z3Cb2bob+t8KgC9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33366 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdBXRHr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 12:07:47 -0500
Received: by mail-ua0-f179.google.com with SMTP id h65so16559509uah.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 09:07:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, dillaman@redhat.com, idryomov@gmail.com

hi cephers,

we just merged two pull requests that enable us to use the workunit in
the specified suite-repo and suite-branch when teuthology is
performing a workunit task.

1. with the first pull request[1], the tasks/workunit/sha1 in test's
yaml will be the suite's sha1. before that, we were using ceph's sha1
for the workunit.
2. with the second pull request[2], workunit task will be always
cloned from the suite-repo:workunit-sha1. before the change, we search
the both ceph/ceph and ceph/ceph-ci repos for given workunit sha1.

i know it's a little bit convoluted. so put in another way:

- if you rebase your change on ceph/ceph against the latest master,
but your teuthology installation is not updated, then teuthology will
use suite-repo:ceph-sha1 for the workunits.
- if you sync your teuthology with the latest git HEAD, then your
workunit will be cloned from ceph:suite-sha1, and use
ceph-ci:suite-sha1 as the fallback if suite-sha1 is not found in ceph
repo.
- if both of your teuthology and ceph branch being tested are updated,
then your workunit will be cloned from suite-repo:suite-sha1 by
default.

fwiw, suite-repo defaults to ceph-repo, if not specified. and
suite-sha1 defaults to ceph-sha1 if not specified.

regards,

---
[1] https://github.com/ceph/teuthology/pull/1030
[2] https://github.com/ceph/ceph/pull/13625

-- 
Regards
Kefu Chai
