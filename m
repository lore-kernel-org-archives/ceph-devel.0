From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Critical PRs needed for 12.2.3 Luminous
Date: Mon, 5 Feb 2018 12:22:26 +0200
Message-ID: <CABo9giRj4srxDTqAbHfBv-D-eUnUbbsmuyeBgDo4c8SHKjObvQ@mail.gmail.com>
References: <98c4c73b609b9278013e46213a79efdd@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:42268 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBEKW1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 05:22:27 -0500
Received: by mail-qt0-f170.google.com with SMTP id c2so38881031qtn.9
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 02:22:27 -0800 (PST)
In-Reply-To: <98c4c73b609b9278013e46213a79efdd@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, John Spray <jspray@redhat.com>

On Wed, Jan 31, 2018 at 10:05 PM, Abhishek <abhishek@suse.com> wrote:
> Are there any critical PRs we need for 12.2.3 that isn't already merged
> (anything with a luminous-batch-1/wip-yuri* labels are already ongoing qe
> runs), if so can you please reply in this thread so that we can prioritize
> this for QE and hopefully go for final approvals next week.
>

I hope it is not to late for the resharding fix:
https://github.com/ceph/ceph/pull/20038

Thanks,
Orit

> Thanks
> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
