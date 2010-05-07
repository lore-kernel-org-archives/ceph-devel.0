From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH 1/2] qemu-kvm/rbd: use new librados callback for
	ack/complete
Date: Fri, 7 May 2010 23:26:46 +0200
Message-ID: <20100507212646.GA74145@ncolin.muc.de>
References: <20100506205411.GA57852@ncolin.muc.de> <z2za37615151005061441zfd7e2e6en2474c796562756bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:60019 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758504Ab0EGV0t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 May 2010 17:26:49 -0400
Content-Disposition: inline
In-Reply-To: <z2za37615151005061441zfd7e2e6en2474c796562756bd@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 06, 2010 at 09:41:55PM +0000, Yehuda Sadeh Weinraub wrote:
> This one should fix and remove the nasty usleep that handles the acb
> initialization race. I didn't verify that it actually works, so please
> let me know if there are any issues with it.
> 
> Thanks,
> Yehuda

Perfect! - I wonder why I didn't think of this... ;-)

I think that you can commit the patches to git now.

Thanks,
Christian
