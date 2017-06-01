From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Question about multisite lost data when zone failed over
Date: Thu, 1 Jun 2017 08:21:30 -0700
Message-ID: <CADRKj5TFP-yNoenKvb1YVesoQxUez2Mqb3cQ5+M9ijV+DF4Pww@mail.gmail.com>
References: <2017060111255082526822@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36361 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdFAPVb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 11:21:31 -0400
Received: by mail-qk0-f174.google.com with SMTP id p66so22359628qkf.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 08:21:31 -0700 (PDT)
In-Reply-To: <2017060111255082526822@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "yfceph@gmail.com" <yfceph@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 31, 2017 at 8:25 PM, yfceph@gmail.com <yfceph@gmail.com> wrote:
>       I have a  puzzled about several days..First user continue to write
> data to master zone.Then i simulate master zone breakdown  and switch to
> slaver zong to master zone. Some file will lost during the process. Is it
> normal case in the big point of view and RPO >0,or developer prepare to
> improve it.I appreciate your reply,and i will participate it to do what i
> can.
>
What version are you using? Generally in multisite v2 (since jewel),
the master notion really only applies for metadata sync, so a master
switch should only affect metadata changes that happened during the
switch period (e.g., user creation, new buckets). If that's the case,
can you provide the exact scenario and steps you are doing?

Thanks,
Yehuda
