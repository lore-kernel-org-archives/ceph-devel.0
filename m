From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: "Tags" for Ceph pools?
Date: Tue, 28 Jun 2016 13:50:16 -0700
Message-ID: <CAJ4mKGar17NMpMLksCCY+qOraQDh_6uR0UbT8gQ_OBukf3SRdg@mail.gmail.com>
References: <20160628195427.bu2idrr25apcundv@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33088 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbcF1UuR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 16:50:17 -0400
Received: by mail-vk0-f47.google.com with SMTP id j3so39223806vkb.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 13:50:17 -0700 (PDT)
In-Reply-To: <20160628195427.bu2idrr25apcundv@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 12:54 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> Hi all,
>
> silly question time. From a UX perspective, we sometimes need to know
> what a specific pool does. We can't always figure it out directly by
> looking at the pool - is this used for RBDs? A MDS metadata pool? RGW
> buckets?
>
> Right now, that is all bundled into the naming scheme. Is that the way
> to proceed? Is there a recommended/standard naming scheme that tools
> could attach to, then?
>
> We though of storing it in an object in the pool, but, uh, that
> obviously doesn't work so well for cache-tiered pools ;-)
>
> Or should we have metadata about our Ceph entities maintained outside
> Ceph, in a separate tooling database?
>
> Or would there be the chance to somehow store some description
> somewhere, like a few k/v, free-form? x-... parameters maybe?
>
> (Tool suppliers could then agree on common tags, hopefully.)

I don't think there's anything designed for this. There are pool
attributes that I don't think are available without programming, but
there's also the monitor's key-value store. That is available via the
CLI (or API) to anybody with sufficient permissions, and could include
info like that.
-Greg
