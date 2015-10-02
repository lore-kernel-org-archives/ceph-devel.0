From: Tom Nakamura <tnakamura@eml.cc>
Subject: Re: advice on indexing sequential data?
Date: Fri, 02 Oct 2015 01:18:21 -0700
Message-ID: <1443773901.492378.399360481.506E1974@webmail.messagingengine.com>
References: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
 <alpine.DEB.2.00.1510010530120.5233@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60925 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbbJBISW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 04:18:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id C7B8120D47
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2015 04:18:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1510010530120.5233@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,
Thank you for the reply,

On Thu, Oct 1, 2015, at 05:33 AM, Sage Weil wrote:
> > - Each message is an object with some unique ID. Use omap to store all
> > its features in the same object.
> > - For each time period (which will have to be pre-specified to, say, an
> > hour), we have an object which contains a list of ID's, as a bytestring
> > of contatenated ID's. This should make expiring old messages trivial.
> 
> This seems reasonable.  There's a rados append operation so you can fire 
> off 2 IOs to write the message and do the append.  You may want to batch 
> the appends on the inject process to reduce load... or it might not 
> matter, depends on the data rate.
> 
> You could also use omap for this if you wan to query by time range
> (within the per-day or per-hour object).
> 

What do mean by this exactly? Is there a way to use timestamps as keys
and query them by range? That would be very useful, but I don't see
anything like that in the librados api. (I see rados_read_op_omap_cmp,
which seems to be for comparing values, and not keys?)

> > - For each feature, we have a timestamped index (like
> > 20150930-from-foo@bar.com or
> > 20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
> > list of ID's. 
> > - Hopefully use Rados classes to index/feature-extract on the OSD's. 
> >
> > How does this sound? One glaring omission is that I do not know how to
> > create indices which would support querying by inequality/ranges ('find
> > all messages between 1000 and 2000 bytes').
> 
> This I'm less sure about.  You could use a rados class to do teh feature 
> extraction and store in omap in the same object, but rados doesn't 
> give you a cross-object index.  If you are going to do any queries I 
> would put it in a database of some sort (maybe something like 
> cassandra or hbase?).

That seems like a very good idea-- using either of those would give us
the ability to connect Spark or similar tool. Only disadvantage would be
that there would be two components which would need to be synchronized,
though that in itself sounds like an interesting research topic. I will
report back when I've tried it. 

Thank you,
Tom
