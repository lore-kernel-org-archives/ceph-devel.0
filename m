From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Prevent rbd mapping/mounting on multiple hosts workaround
Date: Mon, 8 Feb 2016 07:41:40 -0800
Message-ID: <CAJ4mKGb4x3Wn=hK_qz_p-fkWxcjQSJnotX=mz4pfM-DyPCQxZw@mail.gmail.com>
References: <CAAVaRixeAPiyK2Xx1=nXAZBD=8ckctgFV=6Ag2EyTsAGhPrPUw@mail.gmail.com>
	<CAAVaRixPMWYibHFmmZmVgYB3RjPWaO2-gEhoyTnCHpBkkZjbgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36189 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbcBHPll (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 10:41:41 -0500
Received: by mail-wm0-f53.google.com with SMTP id p63so119416742wmp.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 07:41:40 -0800 (PST)
In-Reply-To: <CAAVaRixPMWYibHFmmZmVgYB3RjPWaO2-gEhoyTnCHpBkkZjbgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mauricio Garavaglia <mauricio@medallia.com>, Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 5, 2016 at 6:24 AM, Mauricio Garavaglia
<mauricio@medallia.com> wrote:
> Hello,
>
> In the January Tech Talk (PostgreSQL on Ceph under Mesos/Aurora with
> Docker [https://youtu.be/OqlC7S3cUKs]) we presented a challenge we are
> facing at Medallia when running databases on ceph under
> mesos/aurora/docker; which is related to prevent mapping/mounting the
> same rbd image in two hosts at the same time during network
> partitions.
>
> As a workaround it was mentioned that we are wrapping rbd in a shell
> script that executes extra logic around certain operations:
>
> - On Map; rbd lock add <image>
>         - If no success; then
>                 - "rbd status <image>": check for Watchers, 3 times each 15 secs
>                         - If found, ABORT the mapping. The image is
> still in use in a host that is healthy
>                 - "ceph osd blacklist add <previous lock holder>".
> Image locked without a watcher
>                 - steal the lock in <image>
>         - map the image
>
> - On Unmap;
>         - rbd lock remove
>
> - On reboot of server;
>         - "ceph osd blacklist rm <self>"
>
> I was wondering if this mechanism could be incorporated as part of the
> rbd CLI, of course controlled by an option during map. We'll be happy
> to work on it, but want to check the feasibility of having the patch
> accepted.

I actually thought we had a disable-by-default config option in later
releases that grab the locks before allowing a mount, but now I can't
find it. Jason?
-Greg
