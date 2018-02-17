From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: bi-directional cloud sync
Date: Sat, 17 Feb 2018 10:52:22 +0200
Message-ID: <CABo9giRvc7nooEkJVdhCUcm2SroY03duVbxqUA_FMt4LzfsrgA@mail.gmail.com>
References: <CADRKj5T2xOW3Lyb+vxtm6E09GtyCZPMQCdWHSDqph2Y9FwMmeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36187 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeBQIwX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Feb 2018 03:52:23 -0500
Received: by mail-qt0-f172.google.com with SMTP id q18so6690619qtl.3
        for <ceph-devel@vger.kernel.org>; Sat, 17 Feb 2018 00:52:23 -0800 (PST)
In-Reply-To: <CADRKj5T2xOW3Lyb+vxtm6E09GtyCZPMQCdWHSDqph2Y9FwMmeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, "Weil, Sage" <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Feb 17, 2018 at 3:16 AM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> Now that the sync-to-the-cloud work is almost complete, I was thinking
> a bit and did some research about bi-directional sync. The big
> difficulty I had with the syncing from the cloud process is the need
> to rework the whole data sync paths where we identify changes. These
> are quite complicated, and these kind of changes are quite a big
> project. I'm not quite sure now that this is needed.
> What I think we could do in a relatively easy (and less risky) way is
> that instead of embedding a new mechanism within the sync logic, we
> can create a module that turns upstream cloud changes into the
> existing rgw logs: that is, data log, and bucket index logs (no
> metadata log needed). In this way we break the problem into two
> separate issues, where one of the issues is already solved. The
> ingesting rgw could then do the same work it is doing with regular
> zones (fetching these logs, and pulling the data from a remote
> endpoint) -- albeit with various slight changes that are required
> since we can't have some of the special apis that we created to assist
> us.

Sounds like a good plan, it may increase the time we detect changes.
If we can give the user an estimation I think it will be acceptable.

> We'll need to see how these could be replaced and what will be the
> trade offs, but we'll need to do that anyway with any solution.
> The changes discovery module that will turn remote cloud changes into
> local logs could do it by either polling the remote endpoints, or (for
> S3 for example) could use buckets notifications mechanism. It will
> build its local changes logs by setting new entries on them according
> to the changes it identifies. The radosgw zone that will sync from the
> cloud will have two endpoints one that will be used to fetch the the
> logs, and another one that will be used to sync in the data.
> I'm a bit simplifying it, there are a few more issues there, but
> that's the gist of it.
>
> Any thoughts?

can this used for syncing indexless buckets?

Regards,
Orit

>
> Yehuda
