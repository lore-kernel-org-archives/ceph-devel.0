From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: jewel 10.2.8 status - blocked
Date: Tue, 20 Jun 2017 10:44:12 -0700
Message-ID: <CAJ4mKGZ2NjRans3Goj6yb65+2kzkmro3sCA+uRXv8q6xANV=bw@mail.gmail.com>
References: <5b7336d6-e7ee-d36d-5272-e807cb17a4b1@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36087 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdFTRoT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 13:44:19 -0400
Received: by mail-it0-f51.google.com with SMTP id m47so18537667iti.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 10:44:19 -0700 (PDT)
In-Reply-To: <5b7336d6-e7ee-d36d-5272-e807cb17a4b1@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 20, 2017 at 4:36 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Here's the latest jewel 10.2.8 status update.
>
> I prepared an integration branch containing the following PRs that the leads
> indicated they would like to see merged before the release:
>
> https://github.com/ceph/ceph/pull/14392
> https://github.com/ceph/ceph/pull/14930
> https://github.com/ceph/ceph/pull/15000
> https://github.com/ceph/ceph/pull/15383
> https://github.com/ceph/ceph/pull/15438
> https://github.com/ceph/ceph/pull/15468
> https://github.com/ceph/ceph/pull/15472
> https://github.com/ceph/ceph/pull/15529
>
> However, as the last jewel rados nightly [1] shows, integration testing will
> not be possible until we implement a fix for
> http://tracker.ceph.com/issues/20171
>
> Kefu and I looked at that one today - it appears to be a Debian packaging
> issue which doesn't apply to kraken or master because ceph-create-keys was
> ripped out in infernalis.

I'm pretty confused when I look through the ticket. This is apparently
a new issue; do we have any idea what changed? There seems to be some
kind of dependency on a running ceph-mds for ceph-create-keys, but the
cause isn't identified in any way I understand.

So, uh, what's happening exactly? :)
-Greg

>
> As soon as we have a PR open with a fix, I'll add it to the integration
> branch and start the last round of testing.
>
> Nathan
>
> [1]
> http://pulpito.ceph.com/teuthology-2017-06-19_02:00:02-rados-jewel-distro-basic-smithi/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
