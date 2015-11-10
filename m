From: Ken Dreyer <kdreyer@redhat.com>
Subject: non-fast-forward merges prevented for some branches in GitHub
Date: Tue, 10 Nov 2015 13:26:18 -0700
Message-ID: <CALqRxCz64UTtQriuCH62LgsZjbXvcH+UX534DRoK0y5Tt+Ufyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35288 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbbKJU0T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 15:26:19 -0500
Received: by wmdw130 with SMTP id w130so87254062wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 12:26:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

GitHub.com now has an option in its UI for users to "protect" certain branches.

I've enabled the "Disable force-pushes to this branch and prevent it
from being deleted" setting for the following repos and branches:

ceph.git and ceph-qa-suite.git:
- "master"
- "jewel"
- "infernalis"
- "hammer"
- "firefly"

ceph-deploy.git and teuthology.git:
- "master"

If we ever have to force-push in an emergency we can disable this in
GitHub's UI, eg https://github.com/ceph/ceph/settings/branches .
Otherwise, in normal operation this will prevent certain branches from
going backwards in time by accident.

- Ken
