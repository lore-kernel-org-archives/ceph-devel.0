From: Sage Weil <sage@inktank.com>
Subject: thought on storing bloom (hit) info
Date: Wed, 2 Oct 2013 17:02:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310021654060.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34016 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3JCACl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 20:02:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com, ceph-devel@vger.kernel.org

If we make this a special internal object we need to complicate recovery 
and namespacing to keep is separate from user data.  We also need to 
implement a new API for retrieving, trimming, and so forth.

Instead, we could just store the in-progress and completed bloom filters 
(or even explicit hit list) as regular rados objects in a separate 
namespace.  The namespace could be '.ceph' or similar by default, but 
configurable in case the user wants something different for some reason.

Normal recovery should work unmodified.

The normal rados API could be used to fetch (or even delete) old info.

I think the main challenge is making an object_locator_t that maps cleanly 
into a specific PG so that a particular object is always stored exactly 
with the PG.  This should be a pretty easy change to object_locator_t.  
In the mapping process, all we're doing is hashing the key string and 
mixing in the pool hash; here we'd just be able to specify the resulting 
value explicitly.

Thoughts?
sage







