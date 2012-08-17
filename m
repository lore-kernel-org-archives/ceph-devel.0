From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Preserve dir default_file_layout in encoded inode
Date: Fri, 17 Aug 2012 02:51:45 -0300
Message-ID: <ord32qcbgu.fsf@livre.localdomain>
References: <orr4r7tn5q.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208161759460.16032@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:43593 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751867Ab2HQFwE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Aug 2012 01:52:04 -0400
In-Reply-To: <alpine.DEB.2.00.1208161759460.16032@cobra.newdream.net> (Sage
	Weil's message of "Thu, 16 Aug 2012 18:07:30 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Aug 16, 2012, Sage Weil <sage@inktank.com> wrote:

> I've dusted it off and repushed it.. can you take a look?  
> wip-mds-layout.

The patch looks good, but testing it is going to be a bit of a challenge
because of the on-disk format change and the current unavailability of
cluster snapshots.  I'll figure something out, once I'm done with an
ongoing cluster operation.

> We aren't allowed to write any "projected" (i.e., unjournaled) changes to 
> other objects until they've committed.

Aah, thanks.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
