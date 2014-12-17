From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS hangs when writing 10GB files in loop
Date: Wed, 17 Dec 2014 10:42:56 -0800
Message-ID: <CAC6JEv9JBUjKgVzFcribvxLSn+HGhXbpdaymVWYi1RoD+YCqeg@mail.gmail.com>
References: <5491B0E1.7050203@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36051 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaLQSm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Dec 2014 13:42:57 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so9245065igb.13
        for <ceph-devel@vger.kernel.org>; Wed, 17 Dec 2014 10:42:57 -0800 (PST)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id qc7sm8200586igb.5.2014.12.17.10.42.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:42:56 -0800 (PST)
Received: by mail-ig0-f174.google.com with SMTP id hn15so9264530igb.7
        for <ceph-devel@vger.kernel.org>; Wed, 17 Dec 2014 10:42:56 -0800 (PST)
In-Reply-To: <5491B0E1.7050203@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 17, 2014 at 8:35 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Today I've been playing with CephFS and the morning started great with
> CephFS playing along just fine.
>
> Some information first:
> - Ceph 0.89
> - Linux kernel 3.18
> - Ceph fuse 0.89
> - One Active MDS, one Standby
>
> This morning I could write a 10GB file like this using the kclient:
> $ dd if=/dev/zero of=10GB.bin bs=1M count=10240 conv=fsync
>
> That gave me 850MB/sec (all 10G network) and I could read the same file
> again with 610MB/sec.
>
> After writing to it multiple times it suddenly started to hang.
>
> No real evidence on the MDS (debug mds set to 20) or anything on the
> client. That specific operation just blocked, but I could still 'ls' the
> filesystem in a second terminal.
>
> The MDS was showing in it's log that it was checking active sessions of
> clients. It showed the active session of my single client.
>
> The client renewed it's caps and proceeded.

Can you clarify this? I'm not quite sure what you mean.

> I currently don't have any logs, but I'm just looking for a direction to
> be pointed towards.
>
> Any ideas?

Well, now that you're on v0.89 you should explore the admin
socket...there are commands on the MDS to dump ops in flight (and
maybe to look at session states? I don't remember when that merged).
-Greg
