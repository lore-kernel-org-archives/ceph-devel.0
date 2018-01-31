From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] Luminous 12.2.3 release date?
Date: Wed, 31 Jan 2018 12:12:33 +0000
Message-ID: <CALe9h7ciamCzNhJCfzNLbdvtPUEo4X6LQuMt_mCc+Yfj8M9S0w@mail.gmail.com>
References: <6016e4d0-5a52-466f-1573-ecd0844b3ec5@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35624 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeAaMMy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jan 2018 07:12:54 -0500
Received: by mail-wr0-f172.google.com with SMTP id w50so14715322wrc.2
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jan 2018 04:12:54 -0800 (PST)
In-Reply-To: <6016e4d0-5a52-466f-1573-ecd0844b3ec5@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

(taking to ceph-devel)

I've done a pass of the luminous backports for mgr and made sure the
ones I think are important are merged.  There were a few ugly bugs in
there, so I would quite like a 12.2.3 release soon too.

Anyone else have fixes they're waiting for?

John

On Tue, Jan 30, 2018 at 9:35 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Is there a ETA yet for 12.2.3? Looking at the tracker there aren't that many
> outstanding issues: http://tracker.ceph.com/projects/ceph/roadmap
>
> On Github we have more outstanding PRs though for the Luminous milestone:
> https://github.com/ceph/ceph/milestone/10
>
> Are we expecting 12.2.3 in Feb? I'm asking because there are some Mgr
> related fixes I'm backporting now for a few people which are in 12.2.3.
>
> Wido
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
