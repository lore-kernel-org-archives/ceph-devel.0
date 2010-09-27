From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH] block: rbd: fixed may leaks
Date: Mon, 27 Sep 2010 10:47:21 -0700
Message-ID: <AANLkTinN_o2O1amBvsM7nFp_ozp13zRPZm=RNH5cp+DV@mail.gmail.com>
References: <1285491578-32580-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49860 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759982Ab0I0SLg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Sep 2010 14:11:36 -0400
In-Reply-To: <1285491578-32580-1-git-send-email-segooon@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 26, 2010 at 1:59 AM, Vasiliy Kulikov <segooon@gmail.com> wrote:
> rbd_client_create() doesn't free rbdc, this leads to many leaks.
>
> seg_len in rbd_do_op() is unsigned, so (seg_len < 0) makes no sense.
> Also if fixed check fails then seg_name is leaked.
> ---

Pushed to our unstable tree. Added missing signed-off by.

Thanks,
Yehuda
