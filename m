From: Sage Weil <sage@newdream.net>
Subject: Re: advice on indexing sequential data?
Date: Fri, 2 Oct 2015 05:20:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510020519520.5233@cobra.newdream.net>
References: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com> <alpine.DEB.2.00.1510010530120.5233@cobra.newdream.net> <1443773901.492378.399360481.506E1974@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39248 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbJBMUt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 08:20:49 -0400
In-Reply-To: <1443773901.492378.399360481.506E1974@webmail.messagingengine.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Nakamura <tnakamura@eml.cc>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2 Oct 2015, Tom Nakamura wrote:
> Hi Sage,
> Thank you for the reply,
> 
> On Thu, Oct 1, 2015, at 05:33 AM, Sage Weil wrote:
> > > - Each message is an object with some unique ID. Use omap to store all
> > > its features in the same object.
> > > - For each time period (which will have to be pre-specified to, say, an
> > > hour), we have an object which contains a list of ID's, as a bytestring
> > > of contatenated ID's. This should make expiring old messages trivial.
> > 
> > This seems reasonable.  There's a rados append operation so you can fire 
> > off 2 IOs to write the message and do the append.  You may want to batch 
> > the appends on the inject process to reduce load... or it might not 
> > matter, depends on the data rate.
> > 
> > You could also use omap for this if you wan to query by time range
> > (within the per-day or per-hour object).
> > 
> 
> What do mean by this exactly? Is there a way to use timestamps as keys
> and query them by range? That would be very useful, but I don't see
> anything like that in the librados api. (I see rados_read_op_omap_cmp,
> which seems to be for comparing values, and not keys?)

https://github.com/ceph/ceph/blob/master/src/include/rados/librados.hpp#L474

The omap enumeration APIs let you specify a starting point (key name).  
There's also a variant that lets you specify a prefix to match, and one 
that only returns keys (not k/v pairs).

> > > - For each feature, we have a timestamped index (like
> > > 20150930-from-foo@bar.com or
> > > 20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
> > > list of ID's. 
> > > - Hopefully use Rados classes to index/feature-extract on the OSD's. 
> > >
> > > How does this sound? One glaring omission is that I do not know how to
> > > create indices which would support querying by inequality/ranges ('find
> > > all messages between 1000 and 2000 bytes').
> > 
> > This I'm less sure about.  You could use a rados class to do teh feature 
> > extraction and store in omap in the same object, but rados doesn't 
> > give you a cross-object index.  If you are going to do any queries I 
> > would put it in a database of some sort (maybe something like 
> > cassandra or hbase?).
> 
> That seems like a very good idea-- using either of those would give us
> the ability to connect Spark or similar tool. Only disadvantage would be
> that there would be two components which would need to be synchronized,
> though that in itself sounds like an interesting research topic. I will
> report back when I've tried it. 

Good luck!
sage

