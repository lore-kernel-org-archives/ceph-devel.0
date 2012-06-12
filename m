From: Sage Weil <sage@inktank.com>
Subject: Re: Handle unfound objects in v0.39
Date: Tue, 12 Jun 2012 09:15:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206120914090.6742@cobra.newdream.net>
References: <CANExM-N5Mg1U4wf6UuBfxsAZSFFt+3JbNe982mPGKn8KW2U=oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2FLQQI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 12:16:08 -0400
In-Reply-To: <CANExM-N5Mg1U4wf6UuBfxsAZSFFt+3JbNe982mPGKn8KW2U=oA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 12 Jun 2012, Henry C Chang wrote:
> Hi,
> 
> We have some unfound objects in the cluster of ceph v0.39. While
> recent ceph versions provide the command to mark unfound objects lost,
> is there any manual procedure to handle unfound objects in v0.39?
> 
> Assume I know the pgid and oid of the unfound object. I am wondering
> if the following procedure works:
> 
> 1. Based on the pgid and oid, find out the real path and file name of
> the object on the osd.
> 2. Put a fake 4M object to the path found in step 1.
> 3. Restart the osds.

It won't, because there is some object metadata in the xattrs that are 
tedious to fake...

> If there is no manual procedure to handle unfound objects, is it safe
> to upgrade ceph from v0.39 to the latest versions?

Yes.  There were several encoding and protocol changes since them (IIRC 
between 0.41 and 0.42), so you'll need to upgrade all nodes at once (no 
rolling upgrade).  (In general, rolling upgrades *will* be possible from 
here on out.)

sage
