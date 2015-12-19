From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: Best way to measure client and recovery I/O
Date: Fri, 18 Dec 2015 22:02:52 -0800
Message-ID: <CAFMfnwpn+0bYjpNOOzEu=3v8_j9m8c4Y84SR9MfGpfj4xfGpJA@mail.gmail.com>
References: <CAANLjFo83v8m_z3MoN+8MR8awShrfuGzWgSbDroyqbHRscNN_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35303 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbLSGCw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Dec 2015 01:02:52 -0500
Received: by mail-yk0-f170.google.com with SMTP id v6so82094975ykc.2
        for <ceph-devel@vger.kernel.org>; Fri, 18 Dec 2015 22:02:52 -0800 (PST)
In-Reply-To: <CAANLjFo83v8m_z3MoN+8MR8awShrfuGzWgSbDroyqbHRscNN_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

> I've been working with Sam Just today and we would like to get some
> performance data around client I/O and recovery I/O to test the new Op
> queue I've been working on. I know that we can just set and OSD out/in
> and such, but there seems like there could be a lot of variation in
> the results making it difficult to come to a good conclusion. We could
> just run the test many times, but I'd love to spend my time doing
> other things.

CBT [1] can do failure simulations while pushing load against the
cluster, here is a config to get you started:

https://gist.github.com/mmgaggle/471cd4227e961a243b22

The osds array in the recovery test portion is the list of osd ids
that you want to mark out during the test.

CBT requires a bit of setup, but there is a script that can do most of
it on a rpm based system. Make sure that your cbt head node has
keyless ssh to itself, the mons, clients, and osd hosts (including
accepting host keys). Let me know if you need help setting it up!

[1] https://github.com/ceph/cbt

-- 

Kyle Bader
