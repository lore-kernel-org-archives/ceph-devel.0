From: Sage Weil <sage@newdream.net>
Subject: Re: OSD crashed due to filestore EIO
Date: Wed, 29 Oct 2014 08:11:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410290806580.13498@cobra.newdream.net>
References: <BLU175-W31E452BBB4E24DD455DA07DF9C0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36628 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933090AbaJ2PLB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 11:11:01 -0400
In-Reply-To: <BLU175-W31E452BBB4E24DD455DA07DF9C0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 29 Oct 2014, GuangYang wrote:
> Recently we observed an OSD crash due to file corruption in filesystem, 
> which leads to an assertion failure at FileStore::read as EIO is not 
> tolerated. As file corruption is normal in large deployment, I am 
> thinking if that behavior is too aggressive, especially for EC pool.
> 
> After searching, I found this flag might help : filestore_fail_eio, 
> which can make the OSD survive an EIO failure, it is true by default 
> though. I haven't tested it yet.

That will reove the immediate assert.  Currently, for an object being read 
by a client, it will just pass EIO back to the client, though, which is 
clearly not what we want.
 
> Does it make sense to adjust the behavior a little bit, if the filestore 
> read fail due to file corruption, return back the failure and at the 
> same time mark the PG as inconsistent, due the redundancy (replication 
> or EC), the request can still be served, and at the same time, we can 
> get alert saying there is inconsistency and manually trigger a PG 
> repair?

That would be ideal, yeah.  I think that initially it makes sense to doing 
*just that read* via a replica but letting the admin trigger the repair.  
This most closely mirrors what scrub currently does on EIO (mark 
inconsistent but let admin repair).  Later, when we support automatic 
repair, that option can affect both scrub and client-triggered EIOs?

We just need to be careful that any EIO on *metadata* still triggers a 
failure as we need to be especially careful about handling that.  IIRC 
there is a flag passed to read indicating whether EIO is okay; we should 
probably use that so that EIO-ok vs EIO-notok cases are still clearly 
annotated.

sage

