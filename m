From: Gregory Farnum <greg@gregs42.com>
Subject: Re: pre_start command not executed with upstart
Date: Tue, 28 Jul 2015 09:52:07 +0100
Message-ID: <CAC6JEv-VudT5715ev9Liu2unWWNfozN6m5V0ZQAwCtGhcPkijQ@mail.gmail.com>
References: <55B73581.3040501@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34045 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbbG1IwI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 04:52:08 -0400
Received: by igk11 with SMTP id 11so97334689igk.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 01:52:08 -0700 (PDT)
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com. [209.85.213.170])
        by smtp.gmail.com with ESMTPSA id x3sm8108121igl.2.2015.07.28.01.52.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 01:52:07 -0700 (PDT)
Received: by igbpg9 with SMTP id pg9so127516198igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 01:52:07 -0700 (PDT)
In-Reply-To: <55B73581.3040501@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 8:55 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I was trying to inject a pre_start command on a bunch of OSDs under
> Ubuntu 14.04, but that didn't work.
>
> I found out that only the sysvinit script execute pre_start commands,
> but the upstart nor the systemd scripts do this.
>
> Is this a thing which will disappear or is this just a oversight?

Mmmm, I wasn't familiar with this mechanism. Judging by the git
history I think it was only added to deal with holes in sysvinit's
daemon management and probably won't be brought forward to the other
init systems, but maybe I'm missing something.

>
> I'm actually using "sleep 30" as a pre-start to prevent all OSDs from
> starting at the same time. Big boxes which die under the workload of all
> OSDs starting at the same time.
>
> I also try to prevent a lot of OSDMap changes by booting the OSDs slowly
> so I tried to fix this with "pre_start".
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
