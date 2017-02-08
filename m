From: Dan van der Ster <dan@vanderster.com>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 13:47:44 +0100
Message-ID: <CABZ+qq=R2auZ0Zbu=MuGdADE6ZDWssJgqx9BPKkK2-8gDo++cw@mail.gmail.com>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36207 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbdBHNQr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 08:16:47 -0500
Received: by mail-wr0-f175.google.com with SMTP id k90so60207241wrc.3
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 05:16:21 -0800 (PST)
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com. [74.125.82.45])
        by smtp.gmail.com with ESMTPSA id 186sm3164558wmw.24.2017.02.08.04.48.24
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 04:48:25 -0800 (PST)
Received: by mail-wm0-f45.google.com with SMTP id v186so46094495wmd.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 04:48:24 -0800 (PST)
In-Reply-To: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

I usually set nobackfill and norecover until all the OSDs are in their
final spots.
PGs get remapped but nothing moves.

-- Dan


On Wed, Feb 8, 2017 at 1:26 PM, John Spray <jspray@redhat.com> wrote:
> So I've just finished upgrading my home cluster OSDs to bluestore by
> killing them one by one and then letting backfill happen to "new" OSDs
> on the same drives.  Hooray!
>
> One slightly awkward thing I ran into was that even though I had noout
> set throughout, during the period between removing the old OSD and
> adding the "new" one, some PGs would of course get remapped (and start
> generating backfill IO to third party OSDs).  This does make sense
> when you think about it (noout doesn't make the cluster magically
> remember OSDs that have been removed), but is still an undesirable
> behaviour.
>
> A) Do we currently have a mechanism to tell the cluster "even though I
> removed this OSD, don't go moving PGs around just yet"?  Should we add
> one?
> B) Was there a way for me to avoid this by e.g. skipping the "osd rm
> X" and "osd crush rm osd.X" that I'm currently doing before adding the
> new OSD that will take the old OSD's ID?
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
