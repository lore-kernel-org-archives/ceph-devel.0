From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] ceph: use kernel DNS resolver
Date: Fri, 23 Sep 2011 12:34:34 -0700
Message-ID: <4E7CDF4A.4070207@cs.ucsc.edu>
References: <CAB2gnbVw2_FSWVVmUA1OobE1Ti9Q1w3AP_67=Vo4zwZtQ=gHYg@mail.gmail.com> <Pine.LNX.4.64.1109221426310.19558@cobra.newdream.net> <CAB2gnbVaS=x9hurY0P8x4Ltqh11foOpsMBy2MNt662T2X9+BLQ@mail.gmail.com> <Pine.LNX.4.64.1109231213580.31698@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:36886 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1IWTlw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 15:41:52 -0400
In-Reply-To: <Pine.LNX.4.64.1109231213580.31698@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 09/23/2011 12:15 PM, Sage Weil wrote:

> So I was actually thinking we could just #ifdef off of 
> CONFIG_DNS_RESOLVER, but I think your approach might be better because 
> you'll see it in the config process and turn it on, vs having to dig 
> through to wherever DNS_RESOLVER lives in kconfig.


Yeh, that was my thinking too. Also, if we just use DNS_RESOLVER then a
Ceph user would have no way of turning off the feature if another
required feature had a dependency on DNS_RESOLVER.

> Maybe it should default y though?


It definitely doesn't hurt anything. I'll send v3 with default y.

-Noah
