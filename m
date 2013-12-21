From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Fri, 20 Dec 2013 22:50:32 -0200
Message-ID: <or8uvf3u3r.fsf@livre.home>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home> <52B2F44A.1050109@intel.com>
	<orbo0c5h4p.fsf@livre.home> <52B3F9DE.60301@intel.com>
	<ord2kr3vez.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:55494 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3LUAwl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Dec 2013 19:52:41 -0500
In-Reply-To: <ord2kr3vez.fsf@livre.home> (Alexandre Oliva's message of "Fri,
	20 Dec 2013 22:22:12 -0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Dec 20, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

> back many of the osds to recent snapshots thereof, from which I'd
> cleaned all traces of the user.ceph._parent.  I intended to roll back

Err, I meant user.ceph._path, of course ;-)

> So I think by now I'm happy to announce that it was an IO error (where
> IO stands for Incompetence of the Operator ;-)

> Sorry about this disturbance, and thanks for asking me to investigate it
> further and find a probable cause that involves no fault of Ceph's.

I guess after the successful --reset-journal, I get to clean up on my
own the journal files that are no longer used but that apparently won't
get cleaned up by the mds any more.  Right?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
