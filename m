From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: teuthology SELinux failures
Date: Tue, 6 Jun 2017 15:55:24 +0200
Message-ID: <CAOi1vP85EeftPsvq_Kz3e7yLKHJcZSev_+NOM9dZkH8mOsq=fA@mail.gmail.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
 <CALe9h7fuiqMFTsEPaLa1uSpBnVj2L8M=dacAVy0ZMiAE+Uzs9w@mail.gmail.com> <CALe9h7fpmcZ6BwEA8=gZAa-MGNm8COotvdPMrokLk0Ah__RDnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36297 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFNz0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 09:55:26 -0400
Received: by mail-vk0-f44.google.com with SMTP id p85so81469099vkd.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 06:55:25 -0700 (PDT)
In-Reply-To: <CALe9h7fpmcZ6BwEA8=gZAa-MGNm8COotvdPMrokLk0Ah__RDnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 6, 2017 at 3:26 PM, John Spray <jspray@redhat.com> wrote:
> Adding Ilya and Zheng -- do you guys happen to know what might have
> changed in the current testing kernel to start seeing all these
> selinux issues?  I'm still seeing it in my latest runs.
>
> Here's a recent example:
> http://qa-proxy.ceph.com/teuthology/jspray-2017-06-05_15:00:03-multimds-wip-jcsp-testing-20170604-testing-basic-smithi/1260536/teuthology.log

A quick grep points at

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a4c22426955d4fc04069811997b7390c0fb858e

and that commit is blamed in

https://bugzilla.redhat.com/show_bug.cgi?id=1449108

Thanks,

                Ilya
