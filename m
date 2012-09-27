From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Slow ceph fs performance
Date: Fri, 28 Sep 2012 11:49:50 +1200
Message-ID: <5064E61E.2070800@catalyst.net.nz>
References: <201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu> <5064E3D7.6080002@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:46683 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I0Xtw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 19:49:52 -0400
In-Reply-To: <5064E3D7.6080002@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Sorry Bryan - I should have read further down the thread and noted that 
you have this figured out... nothing to see here!

On 28/09/12 11:40, Mark Kirkwood wrote:
> Bryan -
>
> Note that the default block size for the rados bench is 4MB...and 
> performance decreases quite dramatically with smaller block sizes (-b 
> option to rados bench).
>

