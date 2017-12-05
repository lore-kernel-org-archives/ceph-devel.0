From: Alfredo Deza <adeza@redhat.com>
Subject: better doc (and build) validation
Date: Tue, 5 Dec 2017 08:31:09 -0500
Message-ID: <CAC-Np1xfCMOD6fCeSvDZ9Wo1dGvtL816oicvBs94YarMNNcZAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:39068 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdLENbK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 08:31:10 -0500
Received: by mail-qt0-f174.google.com with SMTP id k19so605765qtj.6
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 05:31:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

It seems like we keep hitting catastrophic build errors with minor doc
changes. The last one was introduced by a change I made to the
ceph-disk man page that updated the title:

https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1

That change builds correctly (!) and will render just fine, and it was
merged after the docs build reported as successful.

However, this also made all subsequent binary builds break. This
disconnect has caused similar issues in the past. At some point the
docs build was completely broken for days, because there was no
visibility from pull requests.

To mitigate that, we now have the docs job building for every pull
request, regardless if it is only editing rst files (because, yes, one
can break the docs build with C++).

This has helped a lot, but it still falls short because the binary
build process for Ceph is different from how we build docs (including
man pages). This is why a successful docs build in a PR can still
break a binary build.

There are a couple of things that could help:

1) I don't entirely follow how CMake is building the man/doc pages,
but a job that tries to replicate that path could catch these
inconsistencies in PRs.

2) Build binaries on every PR, and report them as status.

I don't know enough of CMake to attempt #1, and #2 would cause
contributors a lot of pain because it would involve having to push to
ceph-ci.git always.

I am open to any other ideas or suggestions here.
