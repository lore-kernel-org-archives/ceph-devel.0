From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/5] libceph: support for replica reads
Date: Fri, 29 May 2020 19:25:57 +0200
Message-ID: <CAOi1vP_wTJ_WeqNU=X2tXCW=PopnFrdHTHv-i=eMeubSyu4jGg@mail.gmail.com>
References: <20200529151952.15184-1-idryomov@gmail.com> <CA+aFP1D_povJnBfH5pT8E7OVK_WHWa0TtBwRCxB=OmscTjGf8Q@mail.gmail.com>
 <CAOi1vP83RsnP7JB2VGfCZv+hwLTDuuzC1vwJpvbX84NKSTZ6jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgE2Rck (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2020 13:32:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF3CC03E969
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2020 10:25:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so201350ioa.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2020 10:25:52 -0700 (PDT)
In-Reply-To: <CAOi1vP83RsnP7JB2VGfCZv+hwLTDuuzC1vwJpvbX84NKSTZ6jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>

On Fri, May 29, 2020 at 7:21 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 6:57 PM Jason Dillaman <jdillama@redhat.com> wrote:
> >
> > lgtm -- couple questions:
> >
> > 1) the client adding the options will be responsible for determining if it's safe to enable read-from-replica/balanced reads (i.e. OSDs >= octopus)?
>
> Yes, we can't easily check require_osd_release or similar in the
> kernel.  This is opt-in, and I'll add a warning together with the
> description of the new options to the man page.
>
> > 2) is there a way to determine if the kernel supports the new options (or will older kernels just ignore the options w/o complaining)? i.e. can ceph-csi safely add the argument regardless?
>
> No, older kernels will error out.  I think ceph-csi would handle
> this the same way ceph quotas are handled (i.e. with the list of
> known "good" kernel versions) or alternatively just attempt to map
> with and then without crush_location and read_balance=localize
                                               ^^^
Typo, read_policy=localize.

Thanks,

                Ilya
