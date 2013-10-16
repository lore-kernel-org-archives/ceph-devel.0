From: Sage Weil <sage@inktank.com>
Subject: Re: Efficiently scan all objects in a rados pool/namespace
Date: Wed, 16 Oct 2013 08:51:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310160849360.29488@cobra.newdream.net>
References: <loom.20131016T060803-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55061 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab3JPPvc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 11:51:32 -0400
In-Reply-To: <loom.20131016T060803-617@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit Tiwary <tiwaryamt@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 16 Oct 2013, Amit Tiwary wrote:
> We are using ceph version 0.56.6, librados C++ APIs and have more than 750 
> million objects in a single pool. Objects are named as "domain-name_file-
> name".
> 
> We are unable to ascertain in what order objects are listed with the command 
> "rados -p poolname ls". They are neither ordered on objectname, nor size or 
> mtime.
> 
> Q1) Is there any way we can control the way objects are scanned/listed in a 
> pool with the below librados c++ code? We are interested in getting list of 
> objects sorted or grouped by object name
>     librados::ObjectIterator it = ioctx.objects_begin();
>     for (; it != ioctx.objects_end(); ++it)
>         ...

They are ordered by hash(object name).

> Q2) In near future, if we upgrade and make use of namespaces (i.e make 
> domain-name as namespace and store all objects of a particular domain in that 
> namespace); would scanning of objects in a namespace be efficient than 
> current scenario where we have to scan the entire pool to fetch all objects?

The namespaces do not improve object listing efficiency; it is still 
O(size of the pool).
 
> Q3) Do you any other recommendations on top of your mind that can improve 
> time required to scan all objects of pool/namespace?

If you need efficient queries by name prefix (or whatever else) you need 
to maintain some sort of seperate index.  Radosgw does this for the S3 
interface by using key/value objects for each bucket.  The kvstore class 
implements a btree on top of such objects to provide improved scalability.

Hope that helps!
sage
