From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Mon, 27 Aug 2012 23:20:37 -0300
Message-ID: <orzk5frc3u.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
	<ora9xsbm9w.fsf@livre.localdomain> <orzk5ra8m9.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208191415240.26858@cobra.newdream.net>
	<alpine.DEB.2.00.1208191422110.26858@cobra.newdream.net>
	<orehmss3ro.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208270943480.29719@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:42204 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751002Ab2H1CVD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 22:21:03 -0400
In-Reply-To: <alpine.DEB.2.00.1208270943480.29719@cobra.newdream.net> (Sage
	Weil's message of "Mon, 27 Aug 2012 09:44:42 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Aug 27, 2012, Sage Weil <sage@inktank.com> wrote:

>> +	  if (!in->old_inodes.empty()) {
>> +	    snapid_t newfirst = in->old_inodes.rbegin()->first + 1;
>> +	    if (newfirst > in->first)
>> +	      in->first = newfirst;

> Hmm, did you observe a case where in->first was already > the newest 
> old_inode?

No, that was just me doing defensive programming and forgetting to add a
warning for this case ;-)

IIRC I reasoned I didn't want an already-bugfixed or already-advanced
in->first in the MDS journal to be overwritten with a buggy/outdated
->first from the inode proper.  However, since I didn't put the warning,
I don't know whether it ever hit :-(

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
