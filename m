From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Proporttions of each role in a cluster
Date: Mon, 7 Mar 2011 09:40:03 -0800
Message-ID: <AANLkTin+kZzp4Z9JokFgqBq=n89B6mDHymLpgBvOUajX@mail.gmail.com>
References: <1299506341.17468.2.camel@ceph>
	<1299509895.2433.87.camel@wido-desktop>
	<AANLkTinsKr9H5drfEBLfL0+Zd=4hVBOtQSfbtBDLWXW8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42741 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab1CGRkG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 12:40:06 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E1148C064
	for <ceph-devel@vger.kernel.org>; Mon,  7 Mar 2011 09:40:05 -0800 (PST)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8BC72C062
	for <ceph-devel@vger.kernel.org>; Mon,  7 Mar 2011 09:40:05 -0800 (PST)
Received: by eyx24 with SMTP id 24so1563643eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2011 09:40:04 -0800 (PST)
In-Reply-To: <AANLkTinsKr9H5drfEBLfL0+Zd=4hVBOtQSfbtBDLWXW8@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Monday, March 7, 2011 at 7:57 AM, Sylar Shen wrote:
Yes, an odd number is the best practice.
> What I concerned is that the numbers of monitors when the scalability
> gets bigger.
> For now, I think 3 is OK, too. But I will have more servers to be
> added in the future(more than 100 servers).

That's unlikely to be a problem for you. The monitors don't have too
handle too many messages; they handle the cluster state but generally
each OSD is going to send them (small) messages a couple times a
second -- or possibly much less often.

> And I would like to know the proportions of each role(MDS,OSD,MON) in a cluster. Because in the future, we will have more servers to build and test.

3 monitors should be sufficient for any cluster you are likely to
build (I don't know what he maximum is, but it's a lot).
Configurations with 1 MDS are a lot more stable than configurations
with multiple MDSes, so I'd start with that and if you find that you
need to handle more metadata ops, you can add more -- adding MDSes to
a running cluster is fairly simple. And put in all the OSDs you need
to handle your storage size and bandwidth needs! :)
-Greg
