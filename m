From: chb@muc.de
Subject: AW: qemu-kvm/rbd: aio patch in git
Date: Wed, 5 May 2010 22:29:58 +0200
Message-ID: <vmime.4be1d546.527.f32ec785842ba48@lvps80-237-162-219.dedicated.hosteurope.de>
References: <v2ra37615151005051048ya839625ejbbe44c5fc2202785@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.brunner-muc.de ([80.237.162.219]:47395 "EHLO
	mail.brunner-muc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab0EEUaG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 16:30:06 -0400
Received: from lvps80-237-162-219.dedicated.hosteurope.de (localhost [127.0.0.1])
	by mail.brunner-muc.de (Postfix) with ESMTP id 7B587C048079
	for <ceph-devel@vger.kernel.org>; Wed,  5 May 2010 22:29:58 +0200 (CEST)
In-Reply-To: <y2ga37615151005051141i2912e0dftc76eb9c0ade806f7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> We're currently working on rbd snapshots and there were a few header
> changes. Currently snapshot creation is being done via the rbd kernel
> driver, but we're planning in adding that capability to the rbdtool.
> Once this works, it'll be easy to implement the kvm-rbd snapshots.
> Note that at this point snapshots are read-only. Adding a writable
> snapshots, as well as snapshots branching would be awesome, however,
> it looks like it's not going to be easy to integrate it easily into
> the current system. So probably the easiest at this point would be to
> have some revert-to-snapshot capability.

This is great news.

> The next thing would be making it safer for multiple clients to
> collaborate on a single rbd image., e.g., adding atomic header
> modification operations and such. This requires some changes in the
> osd (new ops), and will probably require adding some new librados api
> functions.

Another thing that would be interesting is support for releasing sectors 
(aka TRIM support). However I think this would require some kind of
sector map, where we store information about allocated and released 
sectors. At the moment I'm not sure if it is worth the effort and the
performance impact.

Maybe we should add a flag to the header, that indicates the existence
of a sector map. This way we could decide about this feature
later without changing the header again.

Christian





