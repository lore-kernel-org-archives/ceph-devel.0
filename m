From: Boris Ranto <branto@redhat.com>
Subject: Re: teuthology SELinux failures
Date: Thu, 01 Jun 2017 17:33:53 +0200
Message-ID: <1496331233.10067.1.camel@redhat.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35412 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAPd6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 11:33:58 -0400
Received: by mail-wm0-f46.google.com with SMTP id b84so163352872wmh.0
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 08:33:57 -0700 (PDT)
In-Reply-To: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I did not check all of the failed tests but those that I checked
complained about dac_read_search. The dac_* family of capabilities
complains that root is trying to access a file that the standard
permissions does not allow him (root) to access (i.e. having 600 and
ceph/ceph user/group).

However, there is a lot of dac_* failures all throughout the system and
the target contexts are different for these files (i.e. there would
have to be a lot of files like that) so I am inclined to say that this
is a kernel bug. Especially considering that this does not present in
older/stock kernels where there already is a dac_override support.

Anyway, it should be safe to ignore these (not our processes, not our
files...)

Regards,
Boris


On Wed, 2017-05-31 at 13:23 -0700, Yehuda Sadeh-Weinraub wrote:
> We started seeing SELinux related failures in recent teuthology run,
> e.g.:
> http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdse
> arch---basic-smithi/
> 
> It seems that it's unrelated to the runs themselves, possibly postfix
> that's running in the background is triggering these. Any idea what
> we
> should do there?
> 
> Yehuda
