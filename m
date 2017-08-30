From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Independent instances of rgw
Date: Wed, 30 Aug 2017 23:23:18 +0300
Message-ID: <CADRKj5SjTKR8AT9_cW-Kq8KxBf6_8nj93YZsXc-vaihpsr0F6Q@mail.gmail.com>
References: <D5CC636A.98182%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34835 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdH3UXU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 16:23:20 -0400
Received: by mail-oi0-f50.google.com with SMTP id k77so60334604oib.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 13:23:19 -0700 (PDT)
In-Reply-To: <D5CC636A.98182%travis.nielsen@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Nielsen <Travis.Nielsen@quantum.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:56 PM, Travis Nielsen
<Travis.Nielsen@quantum.com> wrote:
> I have a scenario where I'd like to create multiple independent object
> stores. Think of a multi-tenant system where you'd want independent sets
> of object store users.  Is there a way to do this inside a single Ceph
> cluster?
>
> For example, could multiple zones be hosted in the same cluster without
> actually hooking them up for replication? Each zone would have its
> independent set of pools, and be completely unaware of the other zones.
> Each rgw daemon started could be pointed at a different zone with the
> rgw_zone and related settings. This isn't how zones were designed to be
> used, but is this possible?
>
> The multi-site documentation indicates that "Each zone is backed by its
> own Ceph Storage Cluster." I'm wondering if that statement might be out of
> date since the pool names include the zone name in the name of the pool.
> In my prototyping efforts I have not been successful thus far starting
> multiple zones, however. Would be great to get your perspective on whether
> this is possible.
>

You can create separate realms and have a zone per realm. It is
possible to create multiple zones on a single cluster.

Yehuda
