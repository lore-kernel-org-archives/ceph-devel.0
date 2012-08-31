From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: RBD performance - tuning hints / major slowdown effect(s)
Date: Fri, 31 Aug 2012 22:16:26 +1200
Message-ID: <50408EFA.3000403@catalyst.net.nz>
References: <503F91EF.7020807@inktank.com> <1ab6cbb8-de0c-4d24-953b-98eced2f4ae2@mailpro> <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com> <50407A62.1020208@catalyst.net.nz> <20120831094926.GA30653@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:58132 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2HaKRe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 06:17:34 -0400
In-Reply-To: <20120831094926.GA30653@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Alexandre DERUMIER <aderumier@odiso.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

Sorry Dieter,

Not trying to say "you are wrong" or anything like that - just trying to 
add to the problem solving body of knowledge that from what *I* have 
tried out the 'sync' issue does not look to be the bad guy here - altho 
more analysis is always welcome (usual story - my findings should be 
confirm-able by others doing similar tests)!

regards

Mark

On 31/08/12 21:49, Dieter Kasper wrote:
> Mark, Inktank,
>
> OK, it is very likely that 'sync_file_range' is not the major slowdown 'culprit'.
>
> But, which areas (design, current implementation, protocol, interconnect, tuning parameter, ...)
> would you rate as 'major slowdown effect(s)' ?
>

