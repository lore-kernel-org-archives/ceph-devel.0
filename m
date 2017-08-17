From: Alfredo Deza <adeza@redhat.com>
Subject: doc build check on every pull request
Date: Thu, 17 Aug 2017 08:19:20 -0400
Message-ID: <CAC-Np1wnVFhS_rqhnYcN50S0-gWQERZB=tsRx8usDjVG=s7=vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35070 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdHQMTW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 08:19:22 -0400
Received: by mail-wr0-f169.google.com with SMTP id 49so33394268wrw.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 05:19:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Yesterday the pull request that fixed all warnings and errors for the
docs build was merged [0]. The docs build was in such bad shape that
whole sections wouldn't even render, and several multiple links were
non-existent (references to the source of links were broken).

The docs build has been mostly hidden, only updating the contents of
docs.ceph.com when a branch changes. Since the build was not set to
refuse updating on errors or warnings, it appeared as if everything
was building fine.

To prevent this situation in the future, and to ensure docs are
building correctly, a "doc build check" has been added [1] that will
run on every pull request. This check just builds docs and complains
if it is unable to build because of an error or a warning (it doesn't
publish the html)

The check is triggered automatically and can be re-triggered by either
new commits to the PR, a rebase (followed by a force-push), or by
using the following comment in the PR:

    jenkins test docs

To actually get a build that will render html and publish them in a
publicly accessible place, the previous ad-hoc has changed, and it can
only be triggered by a comment on the PR:

    jenkins render docs

If successful, a comment with a link will be added to the PR.


TL;DR: Docs were severely broken, everything is fixed now, and every
PR now has a 'docs check' that prevents warnings and errors from
getting in.


[0] https://github.com/ceph/ceph/pull/17025
[1] https://github.com/ceph/ceph-build/pull/834
