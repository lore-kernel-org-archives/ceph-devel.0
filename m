From: Sage Weil <sweil@redhat.com>
Subject: Re: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 18:11:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612151810400.10615@piezo.novalocal>
References: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com> <7b337443-f6bc-d005-a17b-43bd11481f04@redhat.com> <3bd1c476-c00c-2783-1ac7-7eb98e0785b6@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753644AbcLOSLh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Dec 2016 13:11:37 -0500
In-Reply-To: <3bd1c476-c00c-2783-1ac7-7eb98e0785b6@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 15 Dec 2016, Igor Fedotov wrote:
> On 15.12.2016 20:34, Mark Nelson wrote:
> > 
> > 
> > On 12/15/2016 11:24 AM, Igor Fedotov wrote:
> > > Sage et al,
> > > 
> > > shouldn't we have bluestore_cache_metadata_ratio set to 1 by default? To
> > > concentrate on metadata caching..
> > 
> > I would contend that it should be high (we've already bumped it up, I'd go
> > higher still), but isn't 1 a little excessive? Ultimately this should all be
> > automatic based on heuristics imho.
> > 
> Well, Mark - what's the use case for user data caching? It means that user
> either retrieves just written data or reads them repeatedly or in an unaligned
> manner. Or there are multiple users working with the same object.
> Any of that is IMHO a corner case... That can be handled by using that ratio
> setting if needed.

The main one is RGW.  The gateways don't do their own caching, and even 
if they did you often have several of them.  CephFS multiclient 
scenarios can exercise the cache too.

I agree, though.  How about .8 or .9?

sage
