From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS First product release discussion
Date: Tue, 5 Mar 2013 11:48:03 -0700
Message-ID: <51363DE3.3060104@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42165 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab3CESs3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 13:48:29 -0500
In-Reply-To: <51363B30.7080006@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@inktank.com>, Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 03/05/2013 11:36 AM, Wido den Hollander wrote:
> 
> Now, I'm not talking about enforcing soft or hard quotas, I'm just
> talking about knowing how much space uid X and Y consume on the
> filesystem.

FWIW, we'd like this capability for our HPC systems - we need
to be able to disable scheduling of new jobs for users that
are consuming too much storage....

-- Jim

> 
> Wido


