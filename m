From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Re: Controlling placement groups via RADOS
Date: Wed, 22 Dec 2010 00:47:38 +0900
Message-ID: <FB4248ED-E818-43C3-BF53-686B0E4830C2@gmail.com>
References: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com> <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47126 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0LUPrn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 10:47:43 -0500
Received: by pva4 with SMTP id 4so855189pva.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 07:47:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


Hi Sage, 

> There are two different mechanisms you can use.  The first lets you
> specify which node will be the primary copy (assuming it is up).  This was
> added originally with hadoop in mind, although at the moment it's not
> used.  I have some reservations about the wisdom of using this approach.

Oh great! I would prefer this approach because this is what HBase expects on the underlining distributed filesystem. 

> In both cases it's up the user to keep track of the placement input (the "locator"). 

OK. HBase has a perfect place to store this kind of information. It's called the meta table. It's a special HBase table to keep track of every shard. 

> There are also a couple FileSystem implementations that replace HDFS with
> Ceph.  One uses the libceph userspace client, and one relies on the
> kernel's support and uses a few ioctls to control/expose file placement.
> I wonder if that would also meet your needs?

I'll definitely take a look at them. I have feeling that RADOS would be more suitable for HBase because it has fewer failure points. MDS seems quite complex and HBase doesn't need POSIX style directory structure. All files are managed by HBase and uses will never have to interact with the filesystem. But, I also think Hadoop Map Reduce users would appreciate Ceph's rich features because they will directly interact with it.

Thanks, 
Tatsuya 


On 12/20/2010, at 4:10 AM, Sage Weil wrote:

> Hi Tatsuya,
> 
> On Sun, 19 Dec 2010, Tatsuya Kawano wrote:
>> When I use RADOS, is there any way to store a group of objects into the 
>> same placement group? What are the relationships between pool, object 
>> and placement group?
>> 
>> I'm a contributor of Apache HBase. HBase is a distributed, highly 
>> scalable database built on top of Hadoop Distributed File System (HDFS). 
>> I'd like to develop an adapter to store HBase's journals and data files 
>> onto RADOS instead of HDFS. Since HBase worker nodes (called Region 
>> Server) are collocated on the servers who are running OSDs, I'd like to 
>> take advantage of data locality. A Region Server writes journals and 
>> periodically flushes data files, and I want to store the primary copy of 
>> all these objects to the local OSD, so that the Region Server can read 
>> them from the OSD without wasting network bandwidth.
> 
> There are two different mechanisms you can use.  The first lets you 
> specify which node will be the primary copy (assuming it is up).  This was 
> added originally with hadoop in mind, although at the moment it's not 
> used.  I have some reservations about the wisdom of using this approach.
> 
> The other lets you group objects on the same node.  Normally we hash the 
> object name to determine which PG it belongs too.  The idea is to let the 
> user specify a different string to hash; if the same string is specified 
> for multiple objects, those objects will be stored together.
> 
> In both cases it's up the user to keep track of the placement input (the 
> "locator").  Normally it's just the pool id, but may include either/both 
> of the above.  Also, both mechanisms aren't currently exposed via the 
> librados API, so depending on which route you prefer we'll need to do some 
> (relatively minor) work there.
> 
> There are also a couple FileSystem implementations that replace HDFS with 
> Ceph.  One uses the libceph userspace client, and one relies on the 
> kernel's support and uses a few ioctls to control/expose file placement.  
> I wonder if that would also meet your needs?  
> 
> We're very interested in making things work well for hadoop and hbase.  
> I'm curious what approach you think would work best here!
> 
> sage
> 
> 
> 
>> 
>> Thanks, 
>> Tatsuya 
>> 
>> 
>> --
>> Tatsuya Kawano (Mr.)
>> Tokyo, Japan
>> 
>> http://twitter.com/#!/tatsuya6502
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 

--
Tatsuya Kawano (Mr.)
Tokyo, Japan

http://twitter.com/#!/tatsuya6502




