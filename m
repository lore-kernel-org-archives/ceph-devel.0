From: Janne Grunau <j@jannau.net>
Subject: Re: jerasure buffer misaligned
Date: Fri, 12 Sep 2014 11:17:05 +0200
Message-ID: <20140912091705.GQ2591@jannau.net>
References: <54120E60.3030704@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:41184 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaILJRI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 05:17:08 -0400
Content-Disposition: inline
In-Reply-To: <54120E60.3030704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

On 2014-09-11 23:04:32 +0200, Loic Dachary wrote:
> 
> In the context of jerasure buffers you found to be misaligned, ( 
> http://tracker.ceph.com/issues/9408 ) it would help fix it if you had 
> a simple way to reproduce it.

I've updated the issues with a way to reproduce it. You don't need work 
on it since I've already removed the offending code in my effort to 
reduce memory management overhead for small sizes.

Janne
