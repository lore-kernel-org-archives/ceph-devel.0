From: Sage Weil <sage@inktank.com>
Subject: improving osd message memory layout
Date: Thu, 30 Oct 2014 13:59:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410301355260.16591@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47972 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193AbaJ3U7g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 16:59:36 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DE2B480068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:59:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AF41280068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:59:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

During this session we talked about the general issue of complex message 
layouts.  If you specifically look at the OSD messages important in the IO 
path, you get

MOSDOp
MOSDOpReply
MSubOSDOp
MSubOSDOpReply

The MOSDOp ones aren't too bad.  But the MOSDSubOp's are *terrible*.  Tons 
of fields, overloaded for lots of purposes, half of the fields totally 
unused.

The proposal is to create a new message type, MOSDClientSubOp (and Reply) 
and use that exclusively for replicated (not ec) client ops.  Use only the 
fields that are necessary and be careful about encoding.

The main caller to look at is:

  void ReplicatedBackend::issue_op() in ReplicatedPG.cc

and the receive code.  Captured this in ticket #9961.

Also opened

 9962 osd: kill 'category' in stats and public API

which I'm working on (mostly just cleanup).

sage
