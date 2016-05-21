From: Sage Weil <sweil@redhat.com>
Subject: RE: Min alloc size according to media type
Date: Sat, 21 May 2016 14:11:27 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605211407250.6221@cpach.fuggernut.com>
References: <CY1PR0201MB182075171B6FCA64CF104097854A0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605191515090.6221@cpach.fuggernut.com> <BLUPR0201MB1524D22BDBA93E7F438D4382E84A0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CY1PR0201MB1820EC5C25417E8F1EA1CF1E854B0@CY1PR0201MB1820.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605200604440.6221@cpach.fuggernut.com> <4047211f-426c-69eb-2028-893d5197511a@redhat.com> <BLUPR0201MB152483D22FC798F752C78BBEE84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605201502280.6221@cpach.fuggernut.com> <BLUPR0201MB1524C282653376B0DA7CAF06E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1605201626590.6221@cpach.fuggernut.com>
 <BLUPR0201MB1524C2695F40E7E78DEAABD4E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbcEUSLK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 May 2016 14:11:10 -0400
In-Reply-To: <BLUPR0201MB1524C2695F40E7E78DEAABD4E84B0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 20 May 2016, Allen Samuels wrote:
> > > > The osd options are still useful for testing purposes, I think. 
> > > > Maybe a simple policy that the per-pool options will just override 
> > > > the config option if they are specified is sufficient?  If we can 
> > > > keep the pool and config options 1:1 (modulo the bluestore_ 
> > > > prefix, perhaps) that would keep things understandable.
> > >
> > > +1
> > 
> > If we do this, we need to make a nice way to plumb hte pool properties 
> > down to teh ObjectStore collections, but the nice thing is that if we 
> > map 1:1 to config options we can focus on the bluestore functionality 
> > now without that blocking us.
> 
> Yes, hopefully when we do that we do it in a way that preserves the 
> flexibility of the existing pool property mechanism, but avoids the cost 
> of looking up in the pool_ops_t structure on each R/W traversal. In 5 
> minutes of looking at the pool_ops_t code, it wasn't apparent where the 
> structure is loaded. In other words, if the current mechanism requires a 
> re-start of the OSD after a parameter change then we might want to 
> rethink it. Perhaps the properties can be augmented with a flag that 
> indicates whether dynamic reloading of those particular parameters is 
> supported (i.e., some properties take affect only on restart, others 
> take effect *immediately*)

We should be able to push everything down without too much trouble.  
Something like

 OSD sees new osdmap
 -> PG state update()
 -> PGPool::update()
 -> (new) ObjectStore::collection_set_params(...)
 -> store local copy of values in BlueStore::Collection (in memory)

with a similar path in load_pgs() on startup to get them initialized.

Then the read/write path would either check in Collection field, then at 
global value, or the global config update could iterate over collections 
and update all of the collection-local fields.  Probably the former, for 
simplicity...

sage
