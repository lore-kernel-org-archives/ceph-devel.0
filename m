From: Gregory Farnum <greg@gregs42.com>
Subject: Re: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 10:04:03 -0700
Message-ID: <CAC6JEv8BqBkispnR7xZmC66p8YO4ckHH2mQFy_vt6MB+U=u-ZA@mail.gmail.com>
References: <552BF349.50909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35316 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbbDMREE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 13:04:04 -0400
Received: by igbyr2 with SMTP id yr2so15723424igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 10:04:04 -0700 (PDT)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id rs3sm5867691igb.15.2015.04.13.10.04.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2015 10:04:03 -0700 (PDT)
Received: by igbqf9 with SMTP id qf9so49560415igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 10:04:03 -0700 (PDT)
In-Reply-To: <552BF349.50909@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 13, 2015 at 9:48 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> A while ago this came up in #ceph-devel and I wanted to bring it to a
> wider audience.
>
> Should we stop the convention of adding the "backport: " tags in Git?
>
> Loic brought up the point that this data is essentially immutable after
> we merge it, and it's better to point at a Redmine tracker where we can
> alter the "backport" field.
>
> This makes it easier to adjust the "backport" data after the code's been
> merged to master. It also makes it easier for whoever is corralling the
> backport efforts, because the person only have one place to look
> (Redmine) instead of two (Redmine + git commit logs).
>
> For what it's worth I agree with Loic on this.
>
> Any objections?

Why don't we just treat the backport commit tag as an expected value,
and any corresponding redmine data as the canonical one? I find the
backport tags to be useful when reviewing commits and I think the
authorial intention matters. For instance, it's not uncommon in some
parts of the codebase to discover and fix bugs as part of a feature
branch (because it's doing new things that weren't previously
exercised), tag the bug fix as a backport, and then generate tickets
later (assuming we're behaving).
-Greg
