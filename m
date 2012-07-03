From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Tue, 03 Jul 2012 21:16:10 +0200
Message-ID: <4FF344FA.80708@profihost.ag>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro> <4FF13BEB.8080906@profihost.ag> <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com> <4FF1F4F6.4030403@profihost.ag> <4FF204DB.80709@inktank.com> <4FF2A3FE.7090205@profihost.ag> <Pine.LNX.4.64.1207030828240.27608@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41080 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569Ab2GCTQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 15:16:14 -0400
In-Reply-To: <Pine.LNX.4.64.1207030828240.27608@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Gregory Farnum <greg@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 03.07.2012 17:31, schrieb Sage Weil:
>> ~]# ceph -v
>> ceph version 0.48argonaut-2-gb576faa
>> (commit:b576faa6f24356f4d3ec7205e298d58659e29c68)
>
> Out of curiousity, what patches are you applying on top of the release?
just wip-filestore-min

Stefan
