From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: RBD performance - tuning hints / major slowdown effect(s)
Date: Fri, 31 Aug 2012 11:49:26 +0200
Message-ID: <20120831094926.GA30653@oder.kd-bie.de>
References: <503F91EF.7020807@inktank.com>
 <1ab6cbb8-de0c-4d24-953b-98eced2f4ae2@mailpro>
 <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com>
 <50407A62.1020208@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:53329 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab2HaJtw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 05:49:52 -0400
Content-Disposition: inline
In-Reply-To: <50407A62.1020208@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Alexandre DERUMIER <aderumier@odiso.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

Mark, Inktank,

OK, it is very likely that 'sync_file_range' is not the major slowdown 'culprit'.

But, which areas (design, current implementation, protocol, interconnect, tuning parameter, ...)
would you rate as 'major slowdown effect(s)' ?

Best Regards,
-Dieter


On Fri, Aug 31, 2012 at 08:48:34PM +1200, Mark Kirkwood wrote:
> On 31/08/12 20:11, Dietmar Maurer wrote:
> >>>RBD waits for the data to be on disk on all replicas. It's pretty easy
> >>>to relax this to in memory on all replicas, but there's no option for
> >>>that right now.
> >I thought that is dangerous, because you can loose data?
> >N???????????????r??????y?????????b???X????????v???^???)??{.n???+?????????z???]z???{ay??????????,j??????f?????????h?????????z??????w??????????????????j:+v?????????w???j???m????????????????????????zZ+????????j"??????!tml=
> 
> And it is not immediately obvious that this is the bottleneck - from
> what I can see the 'sync' call being used (sync_file_range) is
> extremely fast and is *not* the major slowdown effect...
> 
> Regards
> 
> Mark
> 

