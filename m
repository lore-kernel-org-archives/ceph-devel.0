From: Martin Mailand <martin@tuxadero.com>
Subject: Re: ceph kernel bug
Date: Fri, 16 Sep 2011 22:17:15 +0200
Message-ID: <4E73AECB.7000905@tuxadero.com>
References: <4E6BD2B4.7050709@tuxadero.com> <Pine.LNX.4.64.1109101546370.19147@cobra.newdream.net> <4E6BF6C3.5010202@tuxadero.com> <4E7254D6.9020509@tuxadero.com> <Pine.LNX.4.64.1109151302160.17623@cobra.newdream.net> <4E7269D1.6010804@tuxadero.com> <Pine.LNX.4.64.1109151551250.27715@cobra.newdream.net> <4E731147.6010405@tuxadero.com> <Pine.LNX.4.64.1109161120480.11043@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:40862 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab1IPURY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 16:17:24 -0400
In-Reply-To: <Pine.LNX.4.64.1109161120480.11043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
yes it fixes things for me as well.

Best Regards,
  martin

Sage Weil schrieb:
> Hi Martin,
> 
> Thanks, this was enough to help me reproduce it, and I believe I have a 
> correct fix (it's working for me).  Can you try commit 935b639 'libceph: 
> fix linger request requeuing' (for-linus branch of 
> git://github.com/NewDreamNetwork/ceph-client.git) and confirm that it 
> fixes things for you as well?
> 
> Thanks!
> sage
> 
> 
