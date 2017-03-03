From: Sage Weil <sage@newdream.net>
Subject: RE: Document about ceph object class APIs
Date: Fri, 3 Mar 2017 14:50:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703031446020.651@piezo.novalocal>
References: <CY4PR10MB159188A69CC453D4D1337CEBE4280@CY4PR10MB1591.namprd10.prod.outlook.com> <alpine.DEB.2.11.1703021523380.651@piezo.novalocal> <CY4PR10MB1591EAE795A3091A2A4597D3E42B0@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54321 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdCCR4y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Mar 2017 12:56:54 -0500
In-Reply-To: <CY4PR10MB1591EAE795A3091A2A4597D3E42B0@CY4PR10MB1591.namprd10.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 3 Mar 2017, Wang, Zhiye wrote:
> Thank you Sage.
> 
> Yes, I am looking at the example code. " cls_register_cxx_method" seems 
> pretty clear. Especially, there is a good blog 
> (http://ceph.com/rados/dynamic-object-interfaces-with-lua/) which 
> explains it well.
> 
> I am interested in function "cls_register_cxx_filter". What is exactly 
> the function, and what is a PGLS filter? I will look into more code, but 
> I will appreciate if you can give it an introduction.

The filter is for PGLS, which lists objects.  It lets you define a 
selection function so that onyl certain objects are included in the 
result.  It's used for cephfs repair when it is searching for unlinked 
objects/files (roughly speaking).
 
> Actually, I am looking for something like this: (data comes from 
> CephFS), before OSD writes file data to underlying storage, my filter 
> code get a chance to modify the data content, and then write to the 
> current object in current pool, or write to another object in another 
> pool. I guess this somehow can be achieved using 
> "cls_register_cxx_method" related methods, but I don't want to change 
> anything on client side (because it's difficult to 
> modify/incorporate/distribute modify code to all clients).

Ah, this unfortunatey isn't possible with the cls mechanism.  The class 
methods are intended to work like methods on objects (in teh OOP sense) in 
that they only operate on a single object and must operate in isolation 
without blocking.  (This lets us bury it into a complex request processing 
and replication pipeline with transactional semantics.)  Also, since 
CephFS is issuing the requests, you'd have to change the client to issue a 
different type of op if you wanted to do something other than write.

I'm guessing you're trying to do some sort of tiering or dedup here?  That 
won't be something that cls ops can do... it needs to be built into RADOS.

HTH!
sage

> Is "cls_register_cxx_filter" what I am looking for?
> 
> 
> Thanks
> Mike
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net] 
> Sent: Thursday, March 2, 2017 11:28 PM
> To: Wang, Zhiye <Zhiye.Wang@Arcserve.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Document about ceph object class APIs
> 
> On Thu, 2 Mar 2017, Wang, Zhiye wrote:
> > Dear all,
> > 
> > Where can I find document about how to extend ceph?
> > 
> > The only doc I can see is here:
> > http://docs.ceph.com/docs/master/architecture/#extending-ceph
> > 
> > And some examples in https://github.com/ceph/ceph/tree/master/src/cls
> >
> > Where can I get document for those APIs? And are those APIs kept 
> > stable from release to release?
> 
> The example classes are the best documentation currently.  The APIs are quite stable, although in principle they could change.  The class plugins need to be compiled against a specific build of ceph anyway, so you would discover any future change at build time.  The storage calls (reads and
> writes) roughly correspond to the RADOS operations defined in include/rados.h (they map to the operations interpreted by do_osd_ops() in PrimaryLogPG.cc), and those rados operations maintain compatibility across many Ceph releases as they are normally originating from clients connecting to the system that could be running other versions.
> 
> Hope that helps!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
