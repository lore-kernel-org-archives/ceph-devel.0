From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: support of non-block connect in async messenger?
Date: Thu, 27 Aug 2015 16:06:22 +0800
Message-ID: <CACJqLyY4B6OXaY3WyTsHJcp6HweEzj-CN22_ZJLwKUn1SNoDtw@mail.gmail.com>
References: <CAEHhVAmGoTxri_eifc-bd+rTnbmfp1i5u4aqU17zLg7W9PKpsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35309 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbH0IGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 04:06:23 -0400
Received: by ykbi184 with SMTP id i184so12026629ykb.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2015 01:06:22 -0700 (PDT)
In-Reply-To: <CAEHhVAmGoTxri_eifc-bd+rTnbmfp1i5u4aqU17zLg7W9PKpsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianhui Yuan <zuiwanyuan@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 27, 2015 at 3:47 PM, Jianhui Yuan <zuiwanyuan@gmail.com> wrote:
> Hi Haomai,
>
> In my environment, I suffer from long timeout when connect a breakdown node.
> So I write some code to support non-block connect in async . And It seems to
> be working well. So, I want to know if non-block connect in async may have
> some problem that can't be sloved now, or we may just support this feature?
>

Yep, async messenger should avoid all potential blocking point. In
msg/async/net_handler.cc, we already have
"NetHandler::nonblock_connect" impl. Long ago because nonblock connect
adds the difficulties to debug problem, I removed the caller codes.
Now it looks a good time to add nonconnect support again.

> Jianhui Yuan



-- 
Best Regards,

Wheat
