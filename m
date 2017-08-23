From: John Spray <jspray@redhat.com>
Subject: Re: Are we ready for Luminous?
Date: Wed, 23 Aug 2017 14:46:12 +0100
Message-ID: <CALe9h7eUvhQYPtM=Sk2XKBrS7O2wBrG0Kv7q35D2p+nFJz6ZLA@mail.gmail.com>
References: <87shgir0cl.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36489 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbdHWNqd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 09:46:33 -0400
Received: by mail-oi0-f49.google.com with SMTP id g131so1441756oic.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 06:46:32 -0700 (PDT)
In-Reply-To: <87shgir0cl.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Matt Benjamin <mbenjami@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Jason Dillaman <jdillama@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 23, 2017 at 12:26 PM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
> Other than the existing PRs in https://github.com/ceph/ceph/milestone/10,
> do we have anything else that really needs to go in for Luminous? Any
> other blockers?

I would vote for calling http://tracker.ceph.com/issues/21078 a
blocker -- ceph-fuse's "df" broke between 12.1.2 and 12.1.3

John

>
> Thanks,
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
