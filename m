From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: RBD performance is not good
Date: Mon, 9 Aug 2010 21:58:00 -0700
Message-ID: <AANLkTimOG-kj=Asxh8Pfri3r5RFJ-RWV1HjPTHg1r7du@mail.gmail.com>
References: <AANLkTi=+bAquZFutD=_uwQAgdC3CzcdNz=Mi+5__AVYW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48861 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0HJE6C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 00:58:02 -0400
Received: by wyb32 with SMTP id 32so340025wyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Aug 2010 21:58:00 -0700 (PDT)
In-Reply-To: <AANLkTi=+bAquZFutD=_uwQAgdC3CzcdNz=Mi+5__AVYW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 9, 2010 at 8:23 PM, Xiaoguang Liu <syslxg@gmail.com> wrote:
> on my 2-ods-node cluster, dd can only reach 13MB/s on rbd device. this
> is much lower than what I expected.
> I can get 30-60 MB/s on a ceph filesystem over the same cluster.
>
> any idea?
>

It is hard to really know without more info, just note that when you
write directly to the block device you bypass any caches, as you do a
raw write. So it is expected that you'd notice a performance drop. You
can try running 'iostat -x 1', it should give some idea about what's
going on.

Thanks,
Yehuda
