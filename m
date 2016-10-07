From: Zack Cerza <zack@redhat.com>
Subject: Selectively re-scheduling jobs in a teuthology run
Date: Fri, 7 Oct 2016 15:57:36 -0600
Message-ID: <CACk6Fjm5QNgb3kK6eY8Oi4XcQDm_s9i9KOqDk2GsbkPwr6E4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33651 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750809AbcJGV5j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2016 17:57:39 -0400
Received: by mail-lf0-f51.google.com with SMTP id x79so50731794lff.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Oct 2016 14:57:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>

Hey all,

Yesterday I (finally) got around to implementing an oft-requested
feature: re-scheduling failed jobs. What this means is that for
example, when you schedule a huge test run and just a few fail, you'll
be able to tell teuthology to schedule a new run containing only those
jobs whose description match those of the old run.

Note that, of all the flags and values you can pass to
teuthology-suite, the only one that is inherited is the --suite value.
The rest will need to be specified explicitly. While this may seem
like a pain, it also means that you can still use things like
--filter, --filter-out, --priority, and really everything else.

An example invocation:
teuthology-suite -v --rerun
teuthology-2016-10-06_05:00:03-smoke-master-testing-basic-vps -m vps
-n 10 -c master --dry-run

It will default to re-scheduling jobs in the 'fail' or 'dead' state -
but you can override that using --rerun-statuses (aka -R).

The PR is here:
https://github.com/ceph/teuthology/pull/963/
There's more background here:
http://tracker.ceph.com/issues/10945

Enjoy!
Zack
