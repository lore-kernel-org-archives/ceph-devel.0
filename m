From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 12 Oct 2015 06:01:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510120557380.29929@cobra.newdream.net>
References: <561BABB5.2090209@aevoo.fr> <561BAC81.5030506@aevoo.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36642 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbJLNBJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 09:01:09 -0400
In-Reply-To: <561BAC81.5030506@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 12 Oct 2015, David Casier wrote:
> Hello everybody,
> fragment is stored in rocksdb before being written to "/fragments" ?
> I separed "/db" and "/fragments" but during the bench, everything is writing
> to "/db"
> I changed options "newstore_sync_*" without success.
> 
> Is there any way to write all metadata in "/db" and all data in "/fragments" ?

You can set newstore_overlay_max = 0 to avoid most data landing in db/.  
But if you are overwriting an existing object, doing write-ahead logging 
is usually unavoidable because we need to make the update atomic (and the 
underlying posix fs doesn't provide that).  The wip-newstore-frags branch 
mitigates this somewhat for larger writes by limiting fragment size, but 
for small IOs this is pretty much always going to be the case.  For small 
IOs, though, putting things in db/ is generally better since we can 
combine many small ios into a single (rocksdb) journal/wal write.  And 
often leave them there (via the 'overlay' behavior).

sage

