From: Alfredo Deza <adeza@redhat.com>
Subject: increasingly large packages and longer build times
Date: Wed, 2 Aug 2017 09:39:15 -0400
Message-ID: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36493 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdHBNjR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 09:39:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so41825300wmt.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 06:39:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The ceph-debuginfo package has continued to increase in size on almost
every release, reaching 1.5GB for the latest luminous RC (12.1.2).

To contrast that, the latest ceph-debuginfo in Hammer was about 0.73GB.

Having packages that large is problematic on a few fronts:

* Building development packages take longer
* Building the repositories takes longer too
* Storage gets heavily impacted on machines that host packages
* Cutting releases continues to be a long, tedious process, even with
current automation

The current build for releases takes about 2 hours. The building of
repositories for the release added another hour, then these need to be
signed and synced again which takes another hour. That is a 4 hour
process that keeps getting longer because these packages keep getting
larger.

What are the guidelines to address what gets into a package like ceph-debuginfo?

Can a process be implemented to periodically review this in case there
are things in there that aren't really needed?

Every dependency, and every thing else that keeps getting added to the
source tree is also a concern (for all the same reasons). I am just
mentioning ceph-debuginfo because that is the easiest heavy weight to
point fingers at.

If for example, we decided that we wanted to have another dashboard
with 200K lines of CSS+JS+HTML and that it needs to live in ceph.git,
that doesn't help any of the current issues.

Here are some ideas that could help, I look forward to anything else
that can be done here too:

* Identify packages that don't change often and could easily live in a
separate repository (ceph-deploy is a good example here)
* Implement guidelines as to what goes into packages like
ceph-debuginfo, and what needs to be trimmed out
* Include package and release maintainers in discussions that mean
adding more packages to ceph.git (or even embedding them too from
forks or submodules)


Thanks!
