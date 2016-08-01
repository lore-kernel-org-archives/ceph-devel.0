From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: handling qemu-guest logs in ceph-ansible
Date: Mon, 1 Aug 2016 13:18:05 -0700
Message-ID: <CAJ4mKGa6Mj7PJ8nnij+QcbgdCtCfzuH7POgeXBXyo51CtT91Qg@mail.gmail.com>
References: <CALqRxCzk4-u842fq5xBW2SrdYSY+9wD=zLEDtUrAgNZ-L4pggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35524 "EHLO
	mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcHAUZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2016 16:25:50 -0400
Received: by mail-ua0-f179.google.com with SMTP id l32so114626502ual.2
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2016 13:25:50 -0700 (PDT)
In-Reply-To: <CALqRxCzk4-u842fq5xBW2SrdYSY+9wD=zLEDtUrAgNZ-L4pggA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 1, 2016 at 12:25 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> With the new unprivileged user support in Jewel, I'm seeing some
> issues with logging and file permissions.
>
> ceph-ansible always configures client logging on every cluster node, like so:
>
>   [client]
>   log file = /var/log/ceph/qemu-guest-$pid.log
>
> As a result, every single client command (eg "ceph health") will
> create a new root-owned "qemu-guest-$pid" log file (which leads to
> issues with logrotate failing to rotate the root-owned files in the
> diretory...)
>
> It's clear we need to remove that bit from the ceph.conf files that
> ceph-ansible writes, but I'm wondering what it *should* be?
>
> Is there a more granular way to configure Ceph so that we only log
> qemu/librbd interactions to qemu-guest-$pid, rather than all client
> logs?

I don't know the full toolchain these all use (is this for teuthology
or a wider thing?), but generally:
* you can specify different config files on the command line when the
client starts
* you can specify override config values of any kind on the command
line when a client starts
* I believe that QEMU/KVM configs for CephFS let you specify config
values independently
* I think(?) you can specify config "sections" based on specific
client IDs, not just the [client] type

So I'd look into whichever of those options is most convenient. :)
-Greg
