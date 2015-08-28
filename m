From: Haomai Wang <haomaiwang@gmail.com>
Subject: =?UTF-8?Q?Re=3A_wakeup=28_=29_in_async_messenger=E2=80=98_event?=
Date: Fri, 28 Aug 2015 15:46:46 +0800
Message-ID: <CACJqLyZf0GZvNeSW3gA8mFxBfEqkj5U_hqC8AZuh_1QRH8CAiA@mail.gmail.com>
References: <CAEHhVAkSdYpgNRwtUa1WWu4sfNoO+sm-Yi6MeM1g5shXpaBb+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36681 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbH1Hqq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 03:46:46 -0400
Received: by ykfw73 with SMTP id w73so45896715ykf.3
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2015 00:46:46 -0700 (PDT)
In-Reply-To: <CAEHhVAkSdYpgNRwtUa1WWu4sfNoO+sm-Yi6MeM1g5shXpaBb+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianhui Yuan <zuiwanyuan@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 28, 2015 at 2:35 PM, Jianhui Yuan <zuiwanyuan@gmail.com> wrote:
> Hi Haomai,
>
> when we use async messenger, the client(as: ceph -s) always stuck in
> WorkerPool::barrier for 30 seconds. It seems the wakeup don't work.

What's the ceph version and os version? It should be a bug we already
fixed before.

>
> Then, I remove "already_wakeup" in wakeup. It seems to be working well. So,
> can we just remove "already_wakeup". And do read in C_handle_notify until it
> is not data to read.
>
> Jianhui Yuan



-- 
Best Regards,

Wheat
