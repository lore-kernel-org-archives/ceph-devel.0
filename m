From: Haomai Wang <haomai@xsky.com>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Mon, 20 Jun 2016 10:40:05 +0800
Message-ID: <CACJqLybigDaq4qbjMQKxw9n=jUMK-7-BtBjhwaNJ7PQoEFS32A@mail.gmail.com>
References: <9a8eed32-29a8-7540-bb24-b1d36325feb9@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0095.outbound.protection.outlook.com ([104.47.125.95]:42816
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751936AbcFTCzn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 19 Jun 2016 22:55:43 -0400
Received: by mail-yw0-f169.google.com with SMTP id v77so6890285ywg.0
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jun 2016 19:40:13 -0700 (PDT)
In-Reply-To: <9a8eed32-29a8-7540-bb24-b1d36325feb9@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 20, 2016 at 5:28 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I 've just rebased, but now I'm getting BUG warnings in del_event()
> calls. And I suspect that it is because of the snippet below...
>
> In STATE_CONNECTING EVENT_READABLE is set on sd, but we try a bit latter
> to remove EVENT_WRITABLE. Which abort since asserts were added to the
> kevent code.
>
> Could it be that in STATE_CONNECTING_RE EVENT_READABLE needs to be removed?

https://github.com/ceph/ceph/pull/9086/commits/a74ce419133881ff8618733a0501c4a47e1368e3


>
> --WjW
>
>
> ./msg/async/AsyncConnection.cc at line 1014
>     case STATE_CONNECTING_RE:
>       {
>         r = net.reconnect(get_peer_addr(), sd);
>         if (r < 0) {
>           ldout(async_msgr->cct, 1) << __func__ << " reconnect failed "
> << dendl;
>           goto fail;
>         } else if (r > 0) {
>           ldout(async_msgr->cct, 10) << __func__ << " nonblock connect
> inprogress" << dendl;
>           center->create_file_event(sd, EVENT_WRITABLE, read_handler);
>           break;
>         }
>
>       lderr(async_msgr->cct) << __func__ << ":" <<__LINE__
>         << " delete_file_event(" << sd << ", EVENT_WRITABLE)"
>         << dendl;
>         center->delete_file_event(sd, EVENT_WRITABLE);
>         state = STATE_CONNECTING_WAIT_BANNER;
>         break;
>       }
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
