From: Sage Weil <sage@inktank.com>
Subject: blueprint: object redirects
Date: Mon, 29 Jul 2013 12:44:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307291239390.12830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53315 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3G2ToD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 15:44:03 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0864E8004F
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 12:44:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D641C8004F
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 12:44:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a draft blueprint up for supporting object redirects, a 
basic building block that will be used for tiering in RADOS.  The basic 
idea is that an object may have symlink-like semantics indicating that it 
is stored in another pool.. maybe something slower, or erasure-encoded, or 
whatever.  There will be basic librados functions to get redirect 
metadata, safely/atomically demote objects to another pool (turn them into 
a redirect), and promote objects back to the main pool.  Flags will let 
you control whether promotion happens automatically on write or possibly 
read.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_object_redirects

I'm not particularly happy with the complexity surrounding the tombstone 
state.  Hopefully we can come up with a simple way to make the client-side 
safely drive object deletion.

If you're interested in discussing this at CDS, please add your name to 
the blueprint so we can include you in the hangout!
