From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 1/2] qemu-kvm/rbd: use new librados callback for
	ack/complete
Date: Fri, 7 May 2010 14:34:02 -0700
Message-ID: <z2ja37615151005071434z746e8315i3afda0b21f0d063c@mail.gmail.com>
References: <20100506205411.GA57852@ncolin.muc.de>
	 <z2za37615151005061441zfd7e2e6en2474c796562756bd@mail.gmail.com>
	 <20100507212646.GA74145@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60079 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab0EGVeC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 May 2010 17:34:02 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so168368vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 May 2010 14:34:02 -0700 (PDT)
In-Reply-To: <20100507212646.GA74145@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Fri, May 7, 2010 at 2:26 PM, Christian Brunner <chb@muc.de> wrote:
> On Thu, May 06, 2010 at 09:41:55PM +0000, Yehuda Sadeh Weinraub wrote:
>> This one should fix and remove the nasty usleep that handles the acb
>> initialization race. I didn't verify that it actually works, so please
>> let me know if there are any issues with it.
>>
>> Thanks,
>> Yehuda
>
> Perfect! - I wonder why I didn't think of this... ;-)
>
> I think that you can commit the patches to git now.
Great, pushed.

Yehuda
