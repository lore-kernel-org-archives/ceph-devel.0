From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 11:37:46 -0700
Message-ID: <1299868666.4750.396.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com>
 <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
 <1299867988.4750.394.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:55779 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab1CKShy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 13:37:54 -0500
In-Reply-To: <1299867988.4750.394.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-11 at 11:26 -0700, Jim Schutt wrote:
> 
> Seems like this pretty much rules out anything but the memory allocator,
> but maybe I'm still missing something?

Again with the typing instead of the thinking.

Off to look at the bufferlist destructor, and anything
else a Message holds.

-- Jim

> 
> -- Jim
> 


