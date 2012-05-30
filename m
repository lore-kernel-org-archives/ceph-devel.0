From: Tommi Virtanen <tv@inktank.com>
Subject: Re: distributed cluster
Date: Wed, 30 May 2012 09:20:13 -0700
Message-ID: <CADvuQRHEXx7Y+VhAvD8Q0D+jEmZJcBaKjaNArVeZ7AGSTWtm_w@mail.gmail.com>
References: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
 <CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com> <Pine.LNX.4.64.1205300925290.358@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62239 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2E3QUe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 12:20:34 -0400
Received: by dady13 with SMTP id y13so7129553dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 09:20:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205300925290.358@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: ceph-devel@vger.kernel.org

On Wed, May 30, 2012 at 4:47 AM, Jerker Nyberg <jerker@update.uu.se> wrote:
> I am waiting as fast as I can for it to be production ready. :-)

I feel like starting a quote of the week collection ;)

One more thing I remember is worth mentioning: Ceph doesn't place
objects "near you", CRUSH is completely deterministic based on the
object name. Hence, your worst case may actually look like this:

sites: west, east
servers: a,b in west; c,d in east
client: x in west

Write from client, with bad luck, will go
x->d, replication: d->a, d->b

Now you've used 3x bandwidth on the WAN.


Currently, the only way to work around this is with pools, and there's
nothing automatic about that.
