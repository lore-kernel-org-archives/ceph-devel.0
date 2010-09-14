From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Questions about ceph
Date: Mon, 13 Sep 2010 17:08:39 -0700
Message-ID: <AANLkTintL8LwWdYDOk+ywmW=SHWWUfSZiLAhHB5UXNR0@mail.gmail.com>
References: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
	<4C8E458D.5030908@sanger.ac.uk>
	<AANLkTinWjbgm7AaDBAb=kud-=iw9ws1bRn7PMbRMpQzb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40149 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0INAIl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Sep 2010 20:08:41 -0400
Received: by qyk36 with SMTP id 36so2376307qyk.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Sep 2010 17:08:40 -0700 (PDT)
In-Reply-To: <AANLkTinWjbgm7AaDBAb=kud-=iw9ws1bRn7PMbRMpQzb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mag Gam <magawake@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 13, 2010 at 4:54 PM, Mag Gam <magawake@gmail.com> wrote:
> Well, currently we are running RHEL 5.2 and I would really like to try
> ceph without fuse. Is this still possible? Are there any instructions
> on how to do this?
RHEL 5.2 is running a *really* old kernel (looks like 2.6.18?); I
don't know of anybody who's tried to run the in-kernel client on
something that old. There's a backports tree at
http://git.kernel.org/?p=linux/kernel/git/sage/ceph-client-standalone.git,
but it's only good back to 2.6.28 or so.
-Greg
