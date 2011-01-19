From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: Ceph on just two nodes being clients - reasonable?
Date: Wed, 19 Jan 2011 13:14:43 +0100
Message-ID: <4D36D5B3.4040601@wpkg.org>
References: <4D36BDF9.4030404@wpkg.org> <1295437286.2255.25.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.virtall.com ([178.63.195.102]:53738 "EHLO mail.virtall.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab1ASMOs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jan 2011 07:14:48 -0500
In-Reply-To: <1295437286.2255.25.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On 19.01.2011 12:41, Wido den Hollander wrote:
> Hi Thomas,
>
> I think the answer is Yes and No on this question, the devs might have
> another approach for your situation.
>
> If you would do this, you would have a MON, MDS and OSD on every server,
> in theory that would work. Mounting would be done by connecting to on of
> the MON's (doesn't matter which one).
>
> But Ceph requires, well, advises a odd number of monitors (Source:
> http://ceph.newdream.net/wiki/Designing_a_cluster )
>
> So you would require a third node which is running your third monitor to
> keep track of both nodes.
>
> My advise, for two nodes, use something like DRBD in Primary<>  Primary
> and use a cluster filesystem like OCFS2.

Currently, I'm running glusterfs in such a scenario (two servers, each 
being also clients), but I wanted to give ceph a try (glusterfs has some 
performance issues with lots of small files), also because of its nice 
features (snapshots, rbd etc.).


-- 
Tomasz Chmielewski
http://wpkg.org
