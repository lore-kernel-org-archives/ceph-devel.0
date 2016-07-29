From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [sepia] "This branch is out-of-date with the base branch"
Date: Fri, 29 Jul 2016 09:59:23 -0600
Message-ID: <CALqRxCyOjLXBYJg=Le3Sz6c-_mJoTG8o7oTXRVWqe5SFvziJuw@mail.gmail.com>
References: <CALe9h7fiBXcFVzo9k2+smVxWrewBw_dK8uMY6kJuts_MwA6mtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36438 "EHLO
	mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcG2P7Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 11:59:25 -0400
Received: by mail-ua0-f178.google.com with SMTP id j59so64817847uaj.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 08:59:25 -0700 (PDT)
In-Reply-To: <CALe9h7fiBXcFVzo9k2+smVxWrewBw_dK8uMY6kJuts_MwA6mtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, sepia@lists.ceph.com

Hi John,

Branch protection is a new GitHub feature, and recently it's enabled
for ceph-qa-suite. Administers of the "ceph" GitHub org can view the
current settings:
https://github.com/ceph/ceph-qa-suite/settings/branches

It looks like someone recently checked the boxes "Require status
checks to pass before merging" and "Require branches to be up to date
before merging".

This means that PRs cannot merge until both conditions are true:
1) the tests must pass
2) master must be in a state where the PR would be a fast-forward merge

Looking at the audit log,
https://github.com/organizations/ceph/settings/audit-log?utf8=3D%E2%9C%=
93&q=3Dprotected_branch

zmc =E2=80=93 protected_branch.update_required_status_checks_enforcemen=
t_level
Required status checks for master on ceph/ceph-qa-suite were activated
for non-admins
United States 2 days ago

zmc =E2=80=93 required_status_check.create
The status default was marked as required for the branch master on
ceph/ceph-qa-suite
United States 2 days ago

So you can ask Zack about this.

- Ken

On Fri, Jul 29, 2016 at 5:44 AM, John Spray <jspray@redhat.com> wrote:
> I've been noticing this status on ceph-qa-suite pull requests, where
> there are no merge conflicts but it was just opened a while ago.
>
> I'm guessing this is either a new github thing or something we
> enabled?  Can anyone shed any light on what makes a PR be considered
> out-of-date?
>
> John
> _______________________________________________
> Sepia mailing list
> Sepia@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
