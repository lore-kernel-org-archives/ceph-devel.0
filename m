From: Sage Weil <sage@newdream.net>
Subject: Re: Circular lock / deadlock in kernel client
Date: Wed, 30 Nov 2011 09:20:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111300919520.28417@cobra.newdream.net>
References: <201111301321.47514.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44068 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab1K3RU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2011 12:20:26 -0500
In-Reply-To: <201111301321.47514.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Wed, 30 Nov 2011, Amon Ott wrote:
> Hi!
> 
> With some kernel debug options for soft and hard lockup detection, I got some 
> fine traces. My kernel is a 3.1.4 to which I have ported from ceph-client 
> for-linus branch what is suitable for 3.1. If needed, I can make my exact 
> ceph code available.
> 
> Traces are attached. It seems that two depending locks can be acquired in 
> different order at different parts of the code, and thus lead to a deadlock. 
> Additionally, I am still trying to reproduce a partial lockup of single dirs 
> with this debugging. Those are likely to be related to mutex locking dirs 
> without unlocking properly.

Thanks, put these in the tracker at 
http://tracker.newdream.net/issues/1762.

sage

