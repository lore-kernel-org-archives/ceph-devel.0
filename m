From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How will Ceph cope with a failed Journal device?
Date: Fri, 1 Jun 2012 14:56:29 -0700
Message-ID: <CADvuQRF51pSL2+pQFn3HO6A_BFqmic-NAXa8gyrwfHEWkTgY2g@mail.gmail.com>
References: <2465580.E9977TXsHv@pc10> <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
 <CADvuQREBg4GfouqSVTmBXaTRTfoDSuvZdhMK7MdperStT4Utqw@mail.gmail.com> <Pine.LNX.4.64.1206011326020.358@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39733 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759438Ab2FAV4u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 17:56:50 -0400
Received: by pbbrp8 with SMTP id rp8so3498186pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 14:56:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206011326020.358@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: ceph-devel@vger.kernel.org

[Whoops, resending as plain text to make vger happy.]

On Fri, Jun 1, 2012 at 4:35 AM, Jerker Nyberg <jerker@update.uu.se> wrote:
> Cool! No more SSDs (that might fail over being written to continuously
> after a couple of months depending in size, prize, write cycles etc) just
> add a lot of RAM, keep the journals on tmpfs and make sure to run Ceph on
> Btrfs? While keeping the replicas separated so not all fail at once.
>
> The contents of the storage node will not be corrupt or something (just a
> bit old) when losing the journal?

The problem with storing things in RAM is, what if your rack/row/data
center loses power, all at once. It's really hard to guard against
those kinds of massive failures. If you don't have a persistent
journal, you might as well not have a journal at all.

The memory-only systems you see out there are typically only used to
the kinds of applications where rolling back to last (on-disk)
snapshot is acceptable -- stuff like shopping carts. Ceph is built on
significantly stronger promises, so it's not the ideal match for an
architecture like that.

It's also unclear to me on what would happen to Ceph if all the
replicas lost their journals at the same time. That might cause bigger
problems, since there's no up to date replica to pull the lost data
from.
