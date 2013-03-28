From: Martin Mailand <martin@tuxadero.com>
Subject: Re: [ceph-users] Mon crash
Date: Thu, 28 Mar 2013 20:15:34 +0100
Message-ID: <515496D6.1080703@tuxadero.com>
References: <515396F3.3030106@tuxadero.com> <51549412.4020707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51291 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3C1TPj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Mar 2013 15:15:39 -0400
In-Reply-To: <51549412.4020707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-users@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Joao,

thanks for catching that up.

-martin

On 28.03.2013 20:03, Joao Eduardo Luis wrote:
> 
> Hi Martin,
> 
> As John said in his reply, these should be reported to ceph-devel (CC'ing).
> 
> Anyway, this is bug #4519 [1].  It was introduced after 0.58, released
> under 0.59 and is already fixed in master.  As far as we can tell, only
> when using auth none will anyone using 0.59 stumble upon it.
> 
>   -Joao
