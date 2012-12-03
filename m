From: Samuel Just <sam.just@inktank.com>
Subject: Re: wip-filestore
Date: Mon, 3 Dec 2012 11:31:36 -0800
Message-ID: <CA+4uBUZ2YsoCjwc6dJCC2RKTLEvOn0Qvnbq0X7Y7fCwJ8AVprA@mail.gmail.com>
References: <alpine.DEB.2.00.1212030336290.6180@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63822 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2LCTbh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:31:37 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1959942vby.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 11:31:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212030336290.6180@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I rejected it only because I didn't manage to measure a performance
increase.  The wip-filestore patches look fine though.
-Sam

On Mon, Dec 3, 2012 at 3:38 AM, Sage Weil <sage@inktank.com> wrote:
> While playing with recovery on the plane I saw big latency spikes caused
> by draining the filestore op queue.  This patch makes it only wait for
> dequeued ops (current handed to threads) and not anything else.  Passed
> the rados suite without problems, and some basic testing on my laptop with
> lots of filestore op threads.
>
> I remember you had a patch doing something similar a while back and
> rejected it... but I forget what the issue was?
>
> sage
>
