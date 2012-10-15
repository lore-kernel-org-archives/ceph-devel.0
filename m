From: Samuel Just <sam.just@inktank.com>
Subject: Re: Two questions about client writes update to Ceph
Date: Mon, 15 Oct 2012 12:49:10 -0700
Message-ID: <CA+4uBUbwseE2hiB1WicxnTO++i-8Qn7YkkgAqUy4J=+-+PwuuA@mail.gmail.com>
References: <CAGVY77cBnFzM9bA5hHkpO6hZycz=v9Jo4_ZDc0f6_w0yvazyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63297 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab2JOTtL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 15:49:11 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2215055vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 12:49:10 -0700 (PDT)
In-Reply-To: <CAGVY77cBnFzM9bA5hHkpO6hZycz=v9Jo4_ZDc0f6_w0yvazyVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Jiang <alex.jiang.zju@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex,

1) When a replica goes, down the write won't complete until the
replica is detected as down.  At that point, the write can complete
without the down replica.  Shortly thereafter, if the down replica
does not come back, a new replica will replace it bringing the
replication count to what it should be.  In the scenario you
described, the transaction will be re-replicated to the replicas when
they come back up (or to new replicas if they don't).

2) The clients don't have a local, durable journal.  The client side
state acts like the volatile cache on a spinning disk: flushing the
disk io will force the data to become durable on an OSD (either in the
journal or synced to the filesystem).

-Sam

On Mon, Oct 15, 2012 at 1:46 AM, Alex Jiang <alex.jiang.zju@gmail.com> wrote:
> Hi,all
>     I'm very interested in Ceph. Recently I deployed a Ceph cluster in
> lab environment, and it works very well. Now I am studying the
> principle of Ceph RBD. But I am confused about two questions.
>     1) When client writes update to Ceph RBD, it contacts with primary
> OSD directly. Then The primary OSD forwards the update to replicas. If
> the replicas are down and update is not committed to replicas disks,
> but the update has been committed to primary OSD disk, will Ceph
> rollbacks the transaction?
>     2) To ensure availability, do journals exist in client side to log
> I/O history? If true, are the journals durable in disks?
>
>   Regards,
>
>   Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
