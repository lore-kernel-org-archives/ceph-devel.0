From: John Spray <jspray@redhat.com>
Subject: Re: "Tags" for Ceph pools?
Date: Tue, 28 Jun 2016 22:20:41 +0100
Message-ID: <CALe9h7eLi7BQNVUUb7yM+pyiV=_QE7Cs4kw0SzZ9U1LkoOu7Pw@mail.gmail.com>
References: <20160628195427.bu2idrr25apcundv@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36689 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbcF1V3F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 17:29:05 -0400
Received: by mail-qk0-f169.google.com with SMTP id z142so30046059qkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 14:29:03 -0700 (PDT)
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
>
> (Tool suppliers could then agree on common tags, hopefully.)

I've had some thoughts along these lines -- I was thinking it would be
nice to have tags on auth IDs so that one could for example save the
mapping between the Ceph ID and something outside of ceph.  As Greg
mentions, we have the "config-key" interface currently, but it would
be kind of nice to be able to do it in a more structured way.

Storing "extras" without bloating the cluster maps is definitely not a
problem, we do this for the OSD metadata, the awkward part is just
keeping it all in sync, making sure things get cleaned up when
pools/osds/keys go away.  While there is clearly a limit somewhere to
how much non-essential state we store via the mons, my feeling is that
we should go at least a bit further than our current config-key
interface.

What about something like namespacing those keys into a path-ish form
like "[pool|osd|rule].<id>"? We could potentially do smart things with
those well-formed keys down the line, like ensuring they correspond to
things that really exist, including them in certain outputs, and
enabling people to efficient scoped operations like "config-key list
pool.3.*".

John
