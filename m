From: John Spray <jspray@redhat.com>
Subject: Re: "Tags" for Ceph pools?
Date: Sun, 5 Mar 2017 23:54:56 +0000
Message-ID: <CALe9h7cQZz=oaQfTfoXYmdqWHdr76bWHs0HjxYiEJk2E-qjonQ@mail.gmail.com>
References: <20160628195427.bu2idrr25apcundv@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35971 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbdCEXzS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Mar 2017 18:55:18 -0500
Received: by mail-wr0-f177.google.com with SMTP id u108so105602205wrb.3
        for <ceph-devel@vger.kernel.org>; Sun, 05 Mar 2017 15:55:17 -0800 (PST)
In-Reply-To: <20160628195427.bu2idrr25apcundv@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 8:54 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
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

(/me perfoms arcane ritual to bring this thread back from the grave)

I'm wondering if Lars or anyone else went further with the pool
metadata topic at all?

Aside from the integration with external tools, I'm finding that I
would also use this for sanity-checking pool selection within Ceph
itself.  e.g. I would like rbd pools to be marked as such, so that if
I'm offering the user a list of pools to use with cephfs then I can
exclude the rbd ones, and the same for rgw.

John



> (Tool suppliers could then agree on common tags, hopefully.)
>
>
>
> Regards
>     Lars
>
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
