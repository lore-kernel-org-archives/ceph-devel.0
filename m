From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: persistent background write activity
Date: Sun, 21 Nov 2010 13:26:58 -0800
Message-ID: <AANLkTin3eD80Q5=uu3EdgwM=8PQOy3e_jnDWiY1sSmQe@mail.gmail.com>
References: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45161 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0KUV07 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Nov 2010 16:26:59 -0500
Received: by ewy5 with SMTP id 5so1350169ewy.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Nov 2010 13:26:58 -0800 (PST)
In-Reply-To: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Nov 21, 2010 at 1:14 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
> Watching my cluster nodes with gkrellm, it seems like there's some
> inexplicable background write activity going on at a rate of about 1-4
> MB/s. As far as I can tell, this starts any time there's disk activity
> (even if there's very little activity), and continues for a minute or
> so after. Does anybody know what this could be?
There's a few possibilities. It could just be the MDS flushing out its
journal. If you have any logging on that will also add to the amount
of data being moved around.
Although I'm not sure either of those would be generating 1-4MB/s for
60 seconds on just a few metadata ops or whatever.

> I'm actually starting
> to worry about the life of my disks, since they're constantly writing
> when they should otherwise be idling.
Hmm, the disk studies I've seen indicate that disk activity has very
little impact on longevity.
-Greg
