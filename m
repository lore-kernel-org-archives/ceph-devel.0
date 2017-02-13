From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Mon, 13 Feb 2017 13:48:03 -0800
Message-ID: <CAMMFjmGbCxdHtU5red8_VtOBd9KQE52b81RB-rwuab978yuysA@mail.gmail.com>
References: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34762 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdBMVsF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 16:48:05 -0500
Received: by mail-wr0-f173.google.com with SMTP id o16so159852420wra.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 13:48:05 -0800 (PST)
In-Reply-To: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Tamilarasi Muthamizhan <tmuthami@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

how do we identify make check tests  now?

I have no objection, just FYI it maybe more complicated for downstream
QE to easily separate make tests from "functional" tests.

Tamil?

Thx
YuriW

On Mon, Feb 13, 2017 at 1:43 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Now that ceph-qa-suite has been assimilated into ceph/ceph.git, shall we
> rename http://tracker.ceph.com/projects/ceph-qa-suite ?
>
> If nobody objects, I'd like to rename it to "tests" so it would cover both
> teuthology tests and make check tests.
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
