From: John Spray <jspray@redhat.com>
Subject: Re: teuthology SELinux failures
Date: Wed, 31 May 2017 22:12:15 +0100
Message-ID: <CALe9h7fuiqMFTsEPaLa1uSpBnVj2L8M=dacAVy0ZMiAE+Uzs9w@mail.gmail.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36570 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaVMh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 17:12:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id 7so133839547wmo.1
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 14:12:36 -0700 (PDT)
In-Reply-To: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Boris Ranto <branto@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 31, 2017 at 9:23 PM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> We started seeing SELinux related failures in recent teuthology run, e.g.:
> http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdsearch---basic-smithi/
>
> It seems that it's unrelated to the runs themselves, possibly postfix
> that's running in the background is triggering these. Any idea what we
> should do there?

My assumption had been that the new failures were from a kernel
change, because I had two runs overnight, one with "-k distro" and one
with "-k testing", and it was only the testing one that had the masses
of selinux failure.

Possibly these rgw jobs did not have a -k flag and therefore ended up
with the testing kernel that had been installed with previous jobs.

I have no insight about the nature of the selinux breakage itself though!

John

>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
