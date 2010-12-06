From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: persistent background write activity
Date: Mon, 6 Dec 2010 10:20:49 -0800
Message-ID: <AANLkTinxwuB217ZuFr7yrtk2kOkqtK=gw3zeA8fcJiuX@mail.gmail.com>
References: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
	<AANLkTin3eD80Q5=uu3EdgwM=8PQOy3e_jnDWiY1sSmQe@mail.gmail.com>
	<AANLkTinTGVC3+pOFX33JMDp4YcbjAxvgPckKnd4T2+Ng@mail.gmail.com>
	<AANLkTin-suY5HC4HzbkD8fxhPwDOYqKWpJAvRZ5uVbut@mail.gmail.com>
	<AANLkTin-MdrFU7C6SgreEi21Kcj+LZpGhGHp18uo0DXG@mail.gmail.com>
	<AANLkTindP5JYg2ZGm61VkFFUiqUji701XhyaK2VN2dz-@mail.gmail.com>
	<AANLkTikbUCZndDUxB7MnMS143aekcemL7RDSOBwibscS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41562 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab0LFSUv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 13:20:51 -0500
Received: by eye27 with SMTP id 27so6413277eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Dec 2010 10:20:50 -0800 (PST)
In-Reply-To: <AANLkTikbUCZndDUxB7MnMS143aekcemL7RDSOBwibscS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 5, 2010 at 8:01 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
> Hi Greg,
>
> I've tried to isolate the problem, and gotten a log from just writing
> to a single file. The MDS was the only thing that produced any
> significant logs, even with --debug_{mon,mds,osd} = 20.
>
> http://p-static.net/mds.beta.log
>
> This is from waiting until all other activity on the cluster quiesces
> (by watching gkrellm and ceph -w), then adding logging using "ceph mds
> injectargs", then creating and deleting a few files (echo "data" >
> foo; rm foo - that sort of thing), then disabling logging. gkrellm
> reported several bursts of I/O totaling around 1MB (though this is a
> complete guess, since gkrellm doesn't count disk bandwidth over time,
> only immediate data), which seems high. (Again, this is with no other
> activity on the fs at all).
Okay, I don't see anything unusual from glancing through the logs. I
think what you're seeing is just the effect of Ceph's heavy journaling
and replication:
The metadata server has its own journal on the OSD cluster which
allows it to make metadata changes safe in a streaming write rather
than by modifying random data all over the cluster (it's lots faster
in general to do this), but it eventually needs to flush that back
into the filesystem proper. In general it'll do this continuously in
the background as the journal grows, but if there are no metadata ops
going on then it'll eventually just put them on-disk in their proper
locations. So that's two writes for every metadata op.
Besides the metadata journaling, the OSDs generally run a local
journal themselves, for similar reasons. That's four (2+2) writes.
Besides the journaling, by default everything is replicated twice. So
that's 8 ((2+2)*2) writes.

This is a fair bit of write amplification, but since they're small and
serve to dramatically reduce latency it's worth it! I'm pretty sure
this is what you're seeing as you watch your cluster.


> I have another issue, possibly related, with metadata operations being
> really laggy. While rsyncing into my cluster, large files saturate the
> (gigE) connection, but small files go really slowly (tens of kB/s).
> This is consistent with metadata ops having a high overhead.
Hmm. Metadata ops in Ceph (and distributed filesystems in general) are
more expensive than on a local FS, but I'd be surprised if it was
hitting an rsync. Have you checked that the performance is
significantly different than what you get running an rsync to normal
local FSes? I generally see startup time for the rsync (checking
metadata, computing hashes, etc) dominates transfer time on small
files so that they report <30KB/s transfers even though the actual
exchange of data is fast.
-Greg
