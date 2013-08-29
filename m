From: Sage Weil <sage@inktank.com>
Subject: better temp objects
Date: Thu, 29 Aug 2013 13:40:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308291331130.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47917 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3H2Uk7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 16:40:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: greg.farnum@inktank.com, ceph-devel@vger.kernel.org

Here's what I'm thinking:

Above the ObjectStore, we clear everything from temp on restart anyway.

We always write bits of a temp object in pieces, and then at the end 
copy/move it into the main collection.  

On replay, we should *only* do that final move/rename if the temp object 
was replayed in its entirety.

So:

- clear out temp collections in the filestore on startup.

- give temp objects unique names so that they don't collide with non-temp 
object fd caching (or whatever else).  for the DBObjectMap part there is 
probably some futzing though to make this work right.

- add a new 'move_from_temp' type operation that renames an object a temp 
(coll_t::is_temp()) collection to a non-temp one.  it will succeed iff the 
temp source exists.

- all operations that write to temp objects fail if the object doesn't 
already exist, except an explicit 'create' op

- all transactions the osds generate that write to temp object start with 
that explicit create.

The combination of these thigns means that we will only have a temp source 
for the move_from_temp op if it is complete.  Which I think means we can 
avoid any of the fsync guard stuff entirely.

The DBObjectMap I'm very fuzzy on, so I suspect that's where the tricky 
part will be.  Maybe the temp object name includes the intended hobject_t 
in it somewhere, or something, so that the rename can be reflected 
in leveldb at the end.

Thoughts?  Maybe we can do a quick hangout this afternoon to make sure 
this will work before I start putting it together...

sage
