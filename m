From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Luminous v12.2.3 approvals
Date: Tue, 6 Feb 2018 10:10:59 -0800
Message-ID: <CA+2bHPbrdPrmFqbg_c_tUO-arf7fa91bpDCxtnw7y7D72CAMtA@mail.gmail.com>
References: <87vafa2frf.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41726 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBFSLa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 13:11:30 -0500
Received: by mail-qt0-f194.google.com with SMTP id r13so3473821qtm.8
        for <ceph-devel@vger.kernel.org>; Tue, 06 Feb 2018 10:11:30 -0800 (PST)
In-Reply-To: <87vafa2frf.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, John Spray <jspray@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Sage Weil <sage@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

On Tue, Feb 6, 2018 at 9:24 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
> These are the current list of PRs currently undergoing/waiting QE for Luminous v12.2.3
> https://github.com/ceph/ceph/labels/luminous-batch-1
>
> Assuming teuthology is happy with these, leads, are we ready to cut
> 12.2.3 or are there more PRs that we need to wait for?

For CephFS:

https://github.com/ceph/ceph/pull/20339
https://github.com/ceph/ceph/pull/20340
https://github.com/ceph/ceph/pull/20341
https://github.com/ceph/ceph/pull/20342
https://github.com/ceph/ceph/pull/20300
https://github.com/ceph/ceph/pull/20249
https://github.com/ceph/ceph/pull/20256
https://github.com/ceph/ceph/pull/20299

-- 
Patrick Donnelly
