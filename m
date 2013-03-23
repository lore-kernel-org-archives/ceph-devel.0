From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Sat, 23 Mar 2013 06:48:38 -0300
Message-ID: <or1ub6a1l5.fsf@livre.home>
References: <20130319120940.29898.80124@localhost.localdomain>
	<ora9pzdwdw.fsf@livre.home> <or1ubaesrx.fsf@livre.home>
	<ord2utb4xx.fsf@livre.home>
	<20130321180614.30044.29961@localhost.localdomain>
	<20130321230621.30044.80640@localhost.localdomain>
	<orzjxw9f75.fsf@livre.home>
	<20130322120754.27874.14389@localhost.localdomain>
	<orobeba58l.fsf@livre.home>
	<20130322142659.27874.81283@localhost.localdomain>
	<20130322170859.GO31559@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:40381 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab3CWJtk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Mar 2013 05:49:40 -0400
In-Reply-To: <20130322170859.GO31559@twin.jikos.cz> (David Sterba's message of
	"Fri, 22 Mar 2013 18:08:59 +0100")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dsterba@suse.cz
Cc: Chris Mason <clmason@fusionio.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mar 22, 2013, David Sterba <dsterba@suse.cz> wrote:

> I've reproduced this without compression, with autodefrag on.

I don't have autodefrag on, unless it's enabled by default on 3.8.3 or
on the for-linus tree.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
