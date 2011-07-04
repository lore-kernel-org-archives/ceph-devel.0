From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Missing kernel client install instructions on wiki?
Date: Sun, 3 Jul 2011 23:01:51 -0700
Message-ID: <CA+qbEUM7HAMP2xPnKkjBim2dmgrzf9abT6MoopMrr_KChxjTsA@mail.gmail.com>
References: <CAG_bnfzsj6o6DOgfg9fryu7x4nDJ5ajmaER7_=k30ZdiVxrjLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:65409 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab1GDGBw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 02:01:52 -0400
Received: by fxd18 with SMTP id 18so4924265fxd.11
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jul 2011 23:01:51 -0700 (PDT)
In-Reply-To: <CAG_bnfzsj6o6DOgfg9fryu7x4nDJ5ajmaER7_=k30ZdiVxrjLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vineet Jain <vinjvinj@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 3, 2011 at 10:33 AM, Vineet Jain <vinjvinj@gmail.com> wrote:
> Also, I have several servers in my cluster. Is it ok to have the ceph
> kernel client and ceph store nodes running on the same machine. Since
> I have 4 cores on each box?

The problem isn't the number of cores. It's the feedback loop.

The classic feedback loop for NFS goes something like this:
1. Unused memory is low, so the system tries to flush the page cache
for the NFS-mounted filesystem
2. The NFS server needs memory to handle the traffic from localhost.
3. go to step 1

For Ceph, you can substitute "MDS server" for NFS server.

We have discussed this a lot on the list. The easiest solution is just
to put the kernel client on a different box than the servers. Second
easiest is to use the cfuse client, which doesn't use page cache in
the same way.

regards,
Colin
