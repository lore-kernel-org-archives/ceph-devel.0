From: Sage Weil <sage@newdream.net>
Subject: long object names
Date: Wed, 20 Apr 2011 21:42:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45172 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1DUEmt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 00:42:49 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 39450BC7EF
	for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 21:42:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 05558BC7EF
	for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 21:42:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda and I talked about the lfn branch today and we're not on the same 
page yet about the best way to proceed.  The current code keeps the long 
file name translating independent of the other naming/mangling that 
FileStore does (collection/ prefix, escaping, and sobject_t -> 
<object>_<snapid|head>).  I see that it's nice to do one thing at once, 
but I'm also not sure the long files are useful anywhere else.

Other thoughts:

The escaping may make more sense in the same layer as the long name stuff?

Eventually we'll be prehashing the pg dir contents into subdirs, and that 
translation will have to be done somewhere too.  That will mean possibily 
looking in two locations during the rehashing process, similar to how the 
lfn stuff has to peek at xattrs.  One thing to keep in mind is that the 
hash value will need to be passed down and stored with the file... it's 
usually hash(object name), but not always when the object_locator_t::key 
is set.  Where will this fit in?

We may eventually want to adjust the ObjectStore interface to include 
collection/dir handles so that the full path isn't traversed in kernel for 
every operation (the OSD could maintain an open handle/fd for each pg it 
has open).

I think the lfn_open/_get type interface below all of the operation 
methods will allow all of those things.  I think it'll be simpler to push 
as much of the filename rendering into that layer as possible, though 
(possibly including the sobject_t mangling).  Having all the 
mangling/rendering done in one place will also make it easy to extend 
without making multiple passes in different layers...

Unfortunately I'm out tomorrow.  Any other opinions?

One other thing: the xattr names are mangled too (user.ceph. prefix).  As 
long as the long name xattr has a different prefix we don't have to worry 
about those getting mixed up.

sage
