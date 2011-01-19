From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 12:41:26 +0100
Message-ID: <1295437286.2255.25.camel@wido-desktop>
References: <4D36BDF9.4030404@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48797 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab1ASLl2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 06:41:28 -0500
In-Reply-To: <4D36BDF9.4030404@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

I think the answer is Yes and No on this question, the devs might have
another approach for your situation.

If you would do this, you would have a MON, MDS and OSD on every server,
in theory that would work. Mounting would be done by connecting to on of
the MON's (doesn't matter which one).

But Ceph requires, well, advises a odd number of monitors (Source:
http://ceph.newdream.net/wiki/Designing_a_cluster )

So you would require a third node which is running your third monitor to
keep track of both nodes.

My advise, for two nodes, use something like DRBD in Primary <> Primary
and use a cluster filesystem like OCFS2.

Wido

On Wed, 2011-01-19 at 11:33 +0100, Tomasz Chmielewski wrote:
> Is it reasonable to set up Ceph on two nodes, which are Ceph clients at 
> the same time?
> 
> 
> Say, we have two machines:
> 
>    ceph1 -- ceph2
> 
> 
> On each of them, Ceph filesystem is mounted in /shared, which is used by 
> services like a webserver or a mailserver.
> 
> Is it a reasonable approach?
> 
> 

