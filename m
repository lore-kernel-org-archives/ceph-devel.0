From: Sage Weil <sage@inktank.com>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Wed, 24 Jul 2013 08:29:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307240829080.15546@cobra.newdream.net>
References: <51EF7CC8.9070507@profihost.ag> <51EF843D.1070107@profihost.ag> <51EFB650.6050506@inktank.com> <51EFC061.6090802@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50975 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3GXP34 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 11:29:56 -0400
In-Reply-To: <51EFC061.6090802@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 24 Jul 2013, Stefan Priebe - Profihost AG wrote:
> What i don't understand is WHY the hell the OSDs haven't used the 2nd or
> 3rd monitor which wasn't restarted?

Double check the ceph.conf's on the OSD machines and make sure all mons 
are listed?  If the remaining mons have a quorum and the OSDs (or any 
client) are able to reach any one of them they will discover the others.

sage
