From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: wip-crush
Date: Wed, 22 Aug 2012 11:54:25 -0400
Message-ID: <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
 <5034F0B4.3060107@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:22978 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab2HVPy2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 11:54:28 -0400
In-Reply-To: <5034F0B4.3060107@hastexo.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Aug 22, 2012, at 10:46 AM, Florian Haas wrote:

> On 08/22/2012 03:10 AM, Sage Weil wrote:
>> I pushed a branch that changes some of the crush terminology.  Instead of 
>> having a crush type called "pool" that requires you to say things like 
>> "pool=default" in the "ceph osd crush set ..." command, it uses "root" 
>> instead.  That hopefully reinforces that it is a tree/hierarchy.
>> 
>> There is also a patch that changes "bucket" to "node" throughout, since 
>> bucket is a term also used by radosgw.
>> 
>> Thoughts?  I think the main pain in making this transition is that old 
>> clusters have maps that have a type 'pool' and new ones won't, and the 
>> docs will need to walk people through both...
> 
> "pool" in a crushmap being completely unrelated to a RADOS pool is
> something that I've heard customers/users report as confusing, as well.
> So changing that is probably a good thing. Naming it "root" is probably
> a good choice as well, as it happens to match
> http://ceph.com/wiki/Custom_data_placement_with_CRUSH.
> 
> As for changing "bucket" to node... a "node" is normally simply a
> physical server (at least in HA terminology, which many potential Ceph
> users will be familiar with), and CRUSH uses "host" for that. So that's
> another recipe for confusion. How about using something super-generic,
> like "element" or "item"?
> 
> Cheers,
> Florian

My guess is that he is trying to use data structure tree nomenclature (root, node, leaf). I agree that node is an overloaded term (as is pool).

As for an alternative to bucket which indicates the item is a collection, what about subtree or branch?

Scott