From: Sage Weil <sage@newdream.net>
Subject: Re: A way to reduce compression overhead
Date: Tue, 15 Nov 2016 14:31:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611151431080.29579@piezo.us.to>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com> <alpine.DEB.2.11.1611082019530.29278@piezo.us.to> <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com> <alpine.DEB.2.11.1611112330530.29579@piezo.us.to>
 <a3f50c37-dfb1-a516-f768-2074204227d1@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43151 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935217AbcKOObj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 09:31:39 -0500
In-Reply-To: <a3f50c37-dfb1-a516-f768-2074204227d1@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 15 Nov 2016, Igor Fedotov wrote:
> > > > I'm curious what you have in mind!  The blob_depth as currently
> > > > implemented is not terribly reliable...
> > > General idea is to estimate allocated vs stored ratio for the blob(s)
> > > under
> > > the extent being written.
> > > Where stored and allocated are measured in allocation units. And can be
> > > calculated using blobs ref_map.
> > > If that ratio is greater than 1 (+-some correction) - we need to perform
> > > GC
> > > for these blobs. Given the fact we do that after compression preprocessing
> > > it's expensive to merge the compressed extent being written and old
> > > shards.
> > > Hence that shards are written as standalone extents as opposed to current
> > > implementation when we try to merge both new and existing extents into  a
> > > single entity. Not a big drawback IMHO. Evidently this is valid for new
> > > compressed extents (that are AU aligned) only. Uncompressed ones can be
> > > merged
> > > in any fashion.
> > > This is just a draft hence comments are highly appreciated.
> > Yeah, I think this is a more sensible approach (focusing on allocated vs
> > referenced).  It seems like the most straightforward thing to do is
> > actually look at the old_extents in the wctx--since those are the ref_maps
> > that will become less referenced than before--in order to identify which
> > blobs might need rewriting.  Avoiding the merge case vastly simplifies it.
> > That also isn't any persistent metadata that we have to maintain (that
> > might become incorrect or inconsistent).
> > 
> > We'd probably do the _do_write_data (which will do the various
> > punch_hole's), then check for any gc work, then do the final
> > _do_alloc_write and _wctx_finish?
> > 
> Sounds good. Still need a detailed consistent algorithm though - working on
> that.

In the meantime, perhaps we should remove the blob_depth code for now so 
it doesn't end up in the on-disk format.

sage
