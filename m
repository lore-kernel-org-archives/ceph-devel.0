From: Sage Weil <sage@inktank.com>
Subject: new ceph-osd key/value backend
Date: Sat, 9 Nov 2013 02:09:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311090201390.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59206 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3KIKJw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 05:09:52 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A3C5A80079
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 02:09:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A17C780079
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 02:09:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've written up a blueprint with a rough sketch of how to take advantage 
of alternative storage interfaces.  I am very happy to see that several f 
them have emerged over the past year or two:

 - fusionio's KVMKV is a key/value interface for their flash products
 - seagate's kinetic is a key/value interface for their new ethernet-based 
drive

Also, leveldb is pretty great for many workloads when run on a 
tranditional disk/fs.

The good news is a lot of the existing work that went into support omap 
looks to be reusable here.  Some new functionality and refactoring is 
needed, though, particularly when it comes to storing object data (the 
file-like bag of bytes portion) as key/value pairs.

The blueprint is here:

  http://wiki.ceph.com/01Planning/02Blueprints/Firefly/osd%3A_new_key%2F%2Fvalue_backend

Haomai Wang has done some prototyping work already to accomplish some of 
this.  I'm suggesting a few changes to his current approach: mainly, using 
DBObjectMap so that we can support clone.

Also, I think we need to go a step further and handle large objects by 
striping data over lots of key/value pairs, as most of the new key/value 
interfaces limit values to 1MB.

One of the big promises of this work is that we should be able to avoid 
the journal completely, which will mean avoiding the double write for more 
efficient backends.  It will also be usable on conventional hardware as 
leveldb will be the reference k/v backend.

If you're interested, pelase read it over, and add any detail or questions 
that should be included in the blueprint and/or discussed during the CDS 
session in a couple weeks!

sage
