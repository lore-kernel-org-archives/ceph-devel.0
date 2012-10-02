From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 13:21:59 -0700
Message-ID: <20121002202159.GD8206@splice>
References: <20121002194858.GC8206@splice>
 <CAPYLRzgU+DxNFepUY3s1PvAG-zeBxsrDrgcGUxbwTswpy6zFgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38225 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2JBUWD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:22:03 -0400
Received: by padhz1 with SMTP id hz1so5583604pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:22:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPYLRzgU+DxNFepUY3s1PvAG-zeBxsrDrgcGUxbwTswpy6zFgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 02, 2012 at 01:02:06PM -0700, Gregory Farnum wrote:
> Remote and local reservations come out of a different pool?

Yes. This simplifies deadlock prevention.

> I think I know what you're talking about here, but can you provide a
> bit more background on the reservations and stuff?

This is an attempt to limit the amount of recovery operations occurring
at the same time.

Each OSD has a finite number of reservation slots. Reservation requests
are made by PGs to the OSD. A reservation request succeeds immedately if
there are slots available. If none are available, it will succeed after
a reservation is released (freeing a slot).

Before a recovery op may proceed, the primary collects reservations from
itself and all its replicas. If one of the OSDs is busy, the reservation
process will wait until a reservation is available before continuing.
