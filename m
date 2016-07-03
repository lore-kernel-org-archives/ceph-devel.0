From: Wido den Hollander <wido@42on.com>
Subject: Re: "Tags" for Ceph pools?
Date: Sun, 3 Jul 2016 10:56:59 +0200 (CEST)
Message-ID: <1820571474.345.1467536219936@ox.pcextreme.nl>
References: <20160628195427.bu2idrr25apcundv@suse.de>
 <CALe9h7eLi7BQNVUUb7yM+pyiV=_QE7Cs4kw0SzZ9U1LkoOu7Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:37929 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcGCI5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jul 2016 04:57:07 -0400
In-Reply-To: <CALe9h7eLi7BQNVUUb7yM+pyiV=_QE7Cs4kw0SzZ9U1LkoOu7Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 28 juni 2016 om 23:20 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Tue, Jun 28, 2016 at 8:54 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> > Hi all,
> >
> > silly question time. From a UX perspective, we sometimes need to know
> > what a specific pool does. We can't always figure it out directly by
> > looking at the pool - is this used for RBDs? A MDS metadata pool? RGW
> > buckets?
> >
> > Right now, that is all bundled into the naming scheme. Is that the way
> > to proceed? Is there a recommended/standard naming scheme that tools
> > could attach to, then?
> >
> > We though of storing it in an object in the pool, but, uh, that
> > obviously doesn't work so well for cache-tiered pools ;-)
> >
> > Or should we have metadata about our Ceph entities maintained outside
> > Ceph, in a separate tooling database?
> >
> > Or would there be the chance to somehow store some description
> > somewhere, like a few k/v, free-form? x-... parameters maybe?
> >
> > (Tool suppliers could then agree on common tags, hopefully.)
> 
> I've had some thoughts along these lines -- I was thinking it would be
> nice to have tags on auth IDs so that one could for example save the
> mapping between the Ceph ID and something outside of ceph.  As Greg
> mentions, we have the "config-key" interface currently, but it would
> be kind of nice to be able to do it in a more structured way.
> 

That would be awesome. Being able to tag a OSD with for example:  bluestore,nvme,ssd,hdd

You could query these tags again and have automation to stuff around it. Or also start a OSD:

$ ceph-osd --id 0 --tags ssd,bluestore

The tags could then be used by additional tools to query stuff from there.

> Storing "extras" without bloating the cluster maps is definitely not a
> problem, we do this for the OSD metadata, the awkward part is just
> keeping it all in sync, making sure things get cleaned up when
> pools/osds/keys go away.  While there is clearly a limit somewhere to
> how much non-essential state we store via the mons, my feeling is that
> we should go at least a bit further than our current config-key
> interface.
> 
> What about something like namespacing those keys into a path-ish form
> like "[pool|osd|rule].<id>"? We could potentially do smart things with
> those well-formed keys down the line, like ensuring they correspond to
> things that really exist, including them in certain outputs, and
> enabling people to efficient scoped operations like "config-key list
> pool.3.*".
> 
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
