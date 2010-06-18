From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Fri, 18 Jun 2010 12:09:31 +0200
Message-ID: <4C1B45DB.4000502@redhat.com>
References: <20100531193140.GA13993@chb-desktop> <4C1293B7.1060307@gmail.com> <AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab0FRKKG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jun 2010 06:10:06 -0400
In-Reply-To: <AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: Simone Gotti <simone.gotti@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

Am 17.06.2010 21:05, schrieb Christian Brunner:
> Hi Simone,
> 
> sorry for the late reply. I've been on vacation for a week.
> 
> Thanks for sending the patch. At first sight your patch looks good.
> I'll do some testing by the weekend.
> 
> Kevin also sent me a note about the missing aio support, but I didn't
> have the time to implement it yet. Now it seems, that I don't have to
> do it, since you where quicker... :)

Are you going to send a final version which includes Simone's patch or
should I apply them as two patches and just accept that rbd is broken
after the first one? Or were there any other problems that need to be
solved first?

Kevin
