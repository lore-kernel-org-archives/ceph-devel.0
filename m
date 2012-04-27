From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] crush: include header for global symbols
Date: Fri, 27 Apr 2012 00:04:14 -0400 (EDT)
Message-ID: <20120427.000414.1200447282191234979.davem@davemloft.net>
References: <201204241738.38280.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:38176 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2D0EER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Apr 2012 00:04:17 -0400
In-Reply-To: <201204241738.38280.hartleys@visionengravers.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, sage@newdream.net

From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Tue, 24 Apr 2012 17:38:37 -0700

> Include the header to pickup the definitions of the global symbols.
> 
> Quiets the following sparse warnings:
> 
> warning: symbol 'crush_find_rule' was not declared. Should it be static?
> warning: symbol 'crush_do_rule' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied.
