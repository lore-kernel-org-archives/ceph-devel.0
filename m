From: Sage Weil <sage@newdream.net>
Subject: encoded object corpus
Date: Wed, 8 Feb 2012 13:27:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202081323170.24737@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49838 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757718Ab2BHV1n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 16:27:43 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 721B9BC89C
	for <ceph-devel@vger.kernel.org>; Wed,  8 Feb 2012 13:27:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 46E26BC89C
	for <ceph-devel@vger.kernel.org>; Wed,  8 Feb 2012 13:27:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Part of the data type encoding infrastructure we're putting together is 
testing different code versions against each other.  Some test object 
instances are built into each revision of the code.  There is also some 
simple infrastructure added to capture encoding objects and dump them to a 
directory somewhere, so that we can quickly build a large corpus 
consisting of a sample of objects from a running system.  For each 
version.  So we can test code against different versions of the encoding.

I don't want to pollute ceph.git with a pile of binary data.  The plan is 
to have a git submodule, ceph-object-corpus.git, and have the 'make check' 
do tests against that (if present).

The patches to do this are in wip-corpus.  

Any thoughts or nit picks before we go down this road?

sage

