From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 09:46:07 -0700
Message-ID: <AANLkTikpSN87aqPcMkKdweZ2qukKAR_zYoMrhsQ2qgJT@mail.gmail.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
	<Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
	<20101019222727.GA1737@enoki.dokukino.com>
	<AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
	<Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
	<AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
	<Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
	<AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65067 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab0JTQqI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 12:46:08 -0400
Received: by vws2 with SMTP id 2so2273202vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 09:46:07 -0700 (PDT)
In-Reply-To: <AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Takuya ASADA <syuu@dokukino.com>, ceph-devel@vger.kernel.org

On Wed, Oct 20, 2010 at 9:32 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> I wish we didn't have to have a callback just to get the buffer we're
> trying to write into. It feels like that should somehow be grouped
> with the rest of the transaction data. Why can't we add it to
> Objector::Op's constructor, for example. There must be some obvious
> reason but I don't see it yet.
That wouldn't work if we were sending a message that didn't go through
the Objecter, like any messages to the MDS. So getting buffers from
out of the Messenger is going to require a callback in some form, and
about all we can guarantee is that we'll have a tid, since that's part
of the Messenger interface.
We could conceivably add a function pointer to the Message class, and
use it to obtain buffers for responses to that Message. This actually
might work out better since it allows finer-grained decisions about
memory allocation?
-Greg
