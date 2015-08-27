From: Sage Weil <sage@newdream.net>
Subject: Re: Proposal: data-at-rest encryption
Date: Wed, 26 Aug 2015 17:49:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net>
References: <55DAE0F7.1070905@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53043 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbH0AtN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 20:49:13 -0400
In-Reply-To: <55DAE0F7.1070905@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>
Cc: ceph-devel@vger.kernel.org

Hi Joshua!

On Mon, 24 Aug 2015, Joshua Schmid wrote:
> Hi all,
> 
> 
> just as a quick preface:
> 
> I'm fairly new to ceph, so forgive me any blunders :) But back to the topic.
> 
> after following several discussions on how to implement data-at-rest
> encryption in ceph i want to add my two cents.
> 
> 
> What is used:
> 
> a dedicated FTPS server for key-handling
> 
> 
> How it will work:
> 
> Specify your key-server in ceph.conf.
> Preparing and activating an OSD as usual via --dmcrypt. The newly
> created key will be uploaded and deleted locally. On the initial unlock
> it will already be retrieved via network.
> 
> 
> Why is this a good way:
> 
> Taking in consideration that MONs are not the best place to put the keys
> imho, a dedicated machine is a good place to put them since you are able
> to take care of additional security arrangements.
> 
> 
> What needs attention:
> 
> - The dedicated server is a single point of failure.
> - If you add more servers, is rsync enough?
> - Prevent swapping on key retrieval. (mlockall)
> 
> 
> 
> This is what i did so far:
> 
> https://github.com/jschmid1/ceph/commit/fee26890c24bd3a7b8865295546297e3f144e6d0?diff=unified
> 
> 
> ANY feedback is welcome :)

Overall the ceph-disk changes look pretty good, and it looks like Andrew 
and David have both reviewed.  My only real concern/request is that the 
key server be as pluggable as possible.  You're using ftps here, but we'd 
also like to allow deo[1], or even the mon config-key service.

With the original mon proposal, we also wanted an additional layer of 
security (beyond simply access to the storage network) by 
storing some key-fetching-key on the disk.  It looks like the ftps 
access is unauthenticated... is that right?  I would assume (I'm not hte 
expert!) that most key management systems require some credentials to 
store/fetch keys?

sage
