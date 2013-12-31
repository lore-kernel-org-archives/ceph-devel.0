From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] Ceph fixes for 3.12.y
Date: Mon, 30 Dec 2013 21:15:51 -0800
Message-ID: <20131231051551.GA29973@kroah.com>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50947 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab3LaFPC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Dec 2013 00:15:02 -0500
Content-Disposition: inline
In-Reply-To: <1388448831-10324-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: stable@vger.kernel.org, ceph-devel@vger.kernel.org

On Mon, Dec 30, 2013 at 04:13:47PM -0800, Sage Weil wrote:
> Hi,
> 
> These patches are for 3.12.y stable.  All have been retested and
> reference the original commit.  They can also be pulled from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-stable-3.12.5
> 
> if that is preferred.

Now applied, and I also added patches 2 and 3 to the 3.10 and 3.4-stable
trees as well.  If that was incorrect, please let me know.

thanks,

greg k-h
