From: Sage Weil <sage@newdream.net>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Thu, 16 Feb 2017 16:20:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702161615510.7782@piezo.novalocal>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl> <alpine.DEB.2.11.1702151712530.7782@piezo.novalocal> <250864845.10165.1487258041091@ox.pcextreme.nl> <alpine.DEB.2.11.1702161524490.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42216 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbdBPQUv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 11:20:51 -0500
In-Reply-To: <alpine.DEB.2.11.1702161524490.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 16 Feb 2017, Sage Weil wrote:
> There is another step here (see my other email) where we should mark the 
> osd as lost before we allow it to be replaced.  So,
> 
> 0. 'ceph osd lost NNN' from a client.admin node
> 
> Assuming that is done, then I think the rest of the procedure would be
> 
> 2. Try to unmount the disk (fails if OSD is still running)
> 3. zap the disk
> 4. ceph-disk prepare --replace-osd-id NNN
> 
> This would do 'ceph osd replace <osd-id> <new-uuid>' instead of 'ceph 
> osd create <uuid>'.  The new mon command would verify that (1) the osd is 
> marked as lost (safety check that makes bootstraps ability to do this 
> reasonably secure) and (2) change the uuid to new-uuid.  It could also (3) 
> remove old cephx keys.  Note that we had a thread about making create do 
> this a month or two ago; this might be a good time to fix that too.  The 
> idea was that the boostrap permissions are super wonky because they have 
> to allow creating new cephx keys and so on.  Instead, we should make a 
> single command that does everything (including creating the cephx keys) 
> and returns the whole result to ceph-disk in a blob of json (new osd id + 
> cephx key).  The replace command could work the same way (including the 
> step of removing the old key), and then the allowed commands for 
> the bootstrap key would be just 'osd create' and 'osd replace', period.

Okay, I found the other thread:

	http://marc.info/?t=147913846400007&r=1&w=2

which is about the additional work of setting up the lockbox keys for 
dm-crypt as part of osd creation/bootstrap.  I think the way to do this 
properly is to just bite the bullet and make a new command, let's call it 
'osd bootstrap', and have it take all the various [optional] arguments for 
setting up a new osd, including the osd we want to replace (if any).  It 
can do all the right things as far as setting up (or replacing) cephx 
keys, and be a single atomic and idempotent operation so that ceph-disk is 
super simple and the osd-bootstrap key can actually be secure.

This has totally blown up in scope...are you up for it?  In the meantime, 
the zap fix is small and simple and unrelated to the rest.

sage


> 
> 5. Start the OSD
> 
> What do you think?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

