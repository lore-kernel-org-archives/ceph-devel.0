From: Sage Weil <sage@inktank.com>
Subject: crush changes via cli
Date: Fri, 22 Mar 2013 15:38:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51125 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423438Ab3CVWik (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 18:38:40 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9316D80455
	for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 15:38:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6C13E80455
	for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 15:38:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's a branch pending that lets you do the remainder of the most common 
crush map changes via teh cli.  The command set breaks down like so:

Updating leaves (devices):

  ceph osd crush set <osd-id> <weight> <loc1> [<loc2> ...]
  ceph osd crush add <osd-id> <weight> <loc1> [<loc2> ...]
  ceph osd crush create-or-move <osd-id> <initial-weight> <loc1> [<loc2> ...]

These let you create, add, and move devices in teh map.  The different 
between add and set is that add will create an additional instance of the 
osd (leaf), while set will move the old instance.  This is useful for some 
configurations.

The loc ... bits let you specify the 'where' part in teh form of key/value 
pairs, like 'host=foo rack=bar root=default'.  It will find the 
most-specific pair that matches an existing item, and create any 
intervening ancestors.  For example, if my map has only a root=default 
node (nothing else) and I do

 ceph osd crush set osd.0 1 host=foo rack=myrack row=first root=default

it will create teh row, rack, and host nodes, and then stick osd.0 inside 
host=foo.

Create-or-move is similar to set except that it won't ever change teh 
weight of the device; only set the initial weight if it has to create it.  
This is used by the upstart hook so that it doesn't inadvertantly clobber 
changes the admin has made.

The next set of commands adjust the map structure. Although people usually 
create a tree structure, in reality the crush map is a DAG (directed 
acyclic graph).


  ceph osd crush rm <name> [ancestor]

Will remove an osd or internal node from the, assuming there are no 
children.  With the optional ancestor arg, it will remove only instances 
under the given ancestor.  Otherwise, all instances are removed.  If it is 
a bucket and non-empty, it does nothing.  

  ceph osd crush unlink <bucketname> [ancestor]

Is similar, but will let you remove a (or all) link(s) to a bucket even if 
it is non-empty.  

  ceph osd crush move <bucketname> <loc1> [<loc2> ...]

will unlink the bucket from its existing location(s) and link it in a new 
position.

  ceph osd crush link <bucketname> <loc1> [<loc2> ...]

Doesn't touch existing links, only adds a new one.

Finally,

  ceph osd crush add-bucket <bucketname> <type>

is the one command that will create an internal node with no parent.  
Normally this is just used to create the root of the tree (e.g., 
root=default).  Once it is there, then devices can be added beneath with 
it set, add, link, etc. and loc... bit will add any intervening ancestors 
that are missing.

This maps cleanly on to the internal data model that CRUSH is using.  As 
long as it doesn't bend everyone's mind in uncomfortable ways, I'd like to 
stick with it (or something like it)... but if there is something here 
that seems wrong, let me know!

sage
