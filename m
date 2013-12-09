From: Sage Weil <sage@inktank.com>
Subject: Re: Forced push to master
Date: Mon, 9 Dec 2013 09:59:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312090959120.29875@cobra.newdream.net>
References: <52A4F9F7.8010007@dachary.org> <52A4FCC2.20902@dachary.org> <52A50689.4070904@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41835 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761243Ab3LIR7Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 12:59:16 -0500
In-Reply-To: <52A50689.4070904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Fixed this up last night!

s


On Mon, 9 Dec 2013, Loic Dachary wrote:

> 
> 
> On 09/12/2013 00:12, Loic Dachary wrote:
> > 
> > 
> > On 09/12/2013 00:00, Loic Dachary wrote:
> >> Hi,
> >>
> >> I accidentally forced push to ceph master at 11pm CEST 8 december 2013 the following:
> >>
> >> https://github.com/ceph/ceph/commit/17e0a7b2942899e3f4307bf3e9c41bcb4304619d
> >> https://github.com/ceph/ceph/commit/d5e44cf8b233e517d8f7f26cd556ad0ac15714c1
> >> https://github.com/ceph/ceph/commit/71f820503a96cafa9e99cca047c3183c375408a8
> >> https://github.com/ceph/ceph/commit/eefeb0e0ad54fe0179cbf71335a45ea17c0fa23b
> >> https://github.com/ceph/ceph/commit/8253ff1e0b3b3a1680293c75f015a5cf5f5e34c6
> >>
> >> and may have discarded commits done after:
> >>
> >> https://github.com/ceph/ceph/commit/94da2153d1e131205c0e5e32601d0b6a9f6a3cfd
> >>
> >> which is a merge dated
> >>
> >> Date:   Sat Dec 7 20:59:22 2013 -0800
> >>
> >> I apologize for the inconvenience and trying to figure out more.
> > 
> > http://gitbuilder.sepia.ceph.com/gitbuilder-quantal-amd64/#origin/master
> > 
> > shows:
> > 
> > BUILDING 	17e0a7b 	loic 	build log osd/OSDMap: add feature bit for TUNABLES3 (== CRUSH_V2)
> > 	(Pending) 	d5e44cf 	loic 	mon/OSDMonitor: allow setting 'firefly' tunables
> > 	...3... 		
> > Warn 	94da215 	sage 	Warnings(1) Merge pull request #869 from ceph/wip-crush 
> > 
> > since gitbuilder reacts to every commit to master and that it did not pick anything between 94da215 and the forced push, it is somewhat reassuring that no commit were lost. But I'm trying to find a way to be sure.
> > 
> 
> https://github.com/ceph/ceph/pulls?direction=desc&page=1&sort=updated&state=closed
> 
> shows the latest merges to master, most recent first. The most recent is again
> 
> https://github.com/ceph/ceph/pull/869 i.e. 94da215
> 
> If a commit was lost it was not done via the github interface.
> 
> >>
> >> Cheers
> >>
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
