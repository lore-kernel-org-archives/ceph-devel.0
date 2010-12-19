From: Sage Weil <sage@newdream.net>
Subject: Re: Controlling placement groups via RADOS
Date: Sun, 19 Dec 2010 11:10:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012191102170.10950@cobra.newdream.net>
References: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38016 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab0LSTFV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Dec 2010 14:05:21 -0500
In-Reply-To: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tatsuya Kawano <tatsuya6502@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Tatsuya,

On Sun, 19 Dec 2010, Tatsuya Kawano wrote:
> When I use RADOS, is there any way to store a group of objects into the 
> same placement group? What are the relationships between pool, object 
> and placement group?
>
> I'm a contributor of Apache HBase. HBase is a distributed, highly 
> scalable database built on top of Hadoop Distributed File System (HDFS). 
> I'd like to develop an adapter to store HBase's journals and data files 
> onto RADOS instead of HDFS. Since HBase worker nodes (called Region 
> Server) are collocated on the servers who are running OSDs, I'd like to 
> take advantage of data locality. A Region Server writes journals and 
> periodically flushes data files, and I want to store the primary copy of 
> all these objects to the local OSD, so that the Region Server can read 
> them from the OSD without wasting network bandwidth.

There are two different mechanisms you can use.  The first lets you 
specify which node will be the primary copy (assuming it is up).  This was 
added originally with hadoop in mind, although at the moment it's not 
used.  I have some reservations about the wisdom of using this approach.

The other lets you group objects on the same node.  Normally we hash the 
object name to determine which PG it belongs too.  The idea is to let the 
user specify a different string to hash; if the same string is specified 
for multiple objects, those objects will be stored together.

In both cases it's up the user to keep track of the placement input (the 
"locator").  Normally it's just the pool id, but may include either/both 
of the above.  Also, both mechanisms aren't currently exposed via the 
librados API, so depending on which route you prefer we'll need to do some 
(relatively minor) work there.

There are also a couple FileSystem implementations that replace HDFS with 
Ceph.  One uses the libceph userspace client, and one relies on the 
kernel's support and uses a few ioctls to control/expose file placement.  
I wonder if that would also meet your needs?  

We're very interested in making things work well for hadoop and hbase.  
I'm curious what approach you think would work best here!

sage



> 
> Thanks, 
> Tatsuya 
> 
> 
> --
> Tatsuya Kawano (Mr.)
> Tokyo, Japan
> 
> http://twitter.com/#!/tatsuya6502
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
