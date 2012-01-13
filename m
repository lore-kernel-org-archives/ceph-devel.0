From: Sage Weil <sage@newdream.net>
Subject: simplifying compound operations
Date: Thu, 12 Jan 2012 16:40:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201121628360.18796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41019 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab2AMAkc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 19:40:32 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B2F02BCB0D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 16:40:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 88DB1BCB0D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 16:40:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the features of the Ceph OSDs is the ability to do complex compound 
operations atomically.  Things like "write object + set xattr" or "read 
xattr + read object data" or even "verify xattr foo = bar, and if so, 
write object data".

Compound operations are built as a vector<OSDOp>, where each OSDOp has the 
description of the operation and an input bufferlist.  For results, 
however, results accumulate in a single buffer and the caller is 
responsible for picking through the pile for the results of those 
operations.  That clearly sucks.

Enter wip-op-data-mux branch,
	https://github.com/NewDreamNetwork/ceph/commits/wip-op-data-mux

First, we rename OSDOp::data -> indata, and add an outdata.  We also add 
an rval so you can get the result code for individual operations.  The 
MOSDOpReply message encoding is updated to pass that over the wire to the 
client.  (This is upwards and downwards compatible change.)

	https://github.com/NewDreamNetwork/ceph/commit/a8558284db178cfaf07a20bc475e7366c7903ffd

The OSD is updated to actually put results in those OSDOp fields:

	https://github.com/NewDreamNetwork/ceph/commit/ff55d2f310312bb5390326dcc35961d39ccad416

Conveniently, that change doesn't actually affect the resulting encoding 
for old clients, except that the OSDOp::op::payload_len is now filled in 
properly--and nobody ever looked at that before.  Old (and new) clients 
will still see the haystack.

Then, we extend the Objecter (client-side) ObjectOperation methods for 
read operations (read(..), getxattr(..), etc.) to take pointer arguments 
for where the results go:

	https://github.com/NewDreamNetwork/ceph/commit/fe077832b915175b8ed7880c1fa285309c642563

and the Objecter will sift through the haystack and fill those guys in 
when the reply comes back.

Finally, the librados ObjectReadOperations are similarly updated:

	https://github.com/NewDreamNetwork/ceph/commit/920bd5685c195e0a3c1c3c43f124fe904a73c9b3

Currently the arguments are optional, but I'm updating the rgw callers now 
and it makes things _way_ cleaner.  It's probably best to make them 
required so that librados users don't need to have internal knowledge of 
how we encoding things over the wire, e.g. for things like stat().

I haven't finished testing this yet.  Mainly I want to know if the 
Objecter internal API and librados external API changes make sense.  
And/or if there are any alternative ideas about how this should be 
approached...

sage
