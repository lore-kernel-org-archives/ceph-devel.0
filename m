From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Sun, 19 Jun 2016 23:28:12 +0200
Message-ID: <9a8eed32-29a8-7540-bb24-b1d36325feb9@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:28071 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbcFSVf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jun 2016 17:35:27 -0400
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 13A55153402
	for <ceph-devel@vger.kernel.org>; Sun, 19 Jun 2016 23:28:11 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I 've just rebased, but now I'm getting BUG warnings in del_event()
calls. And I suspect that it is because of the snippet below...

In STATE_CONNECTING EVENT_READABLE is set on sd, but we try a bit latter
to remove EVENT_WRITABLE. Which abort since asserts were added to the
kevent code.

Could it be that in STATE_CONNECTING_RE EVENT_READABLE needs to be removed?

--WjW


./msg/async/AsyncConnection.cc at line 1014
    case STATE_CONNECTING_RE:
      {
        r = net.reconnect(get_peer_addr(), sd);
        if (r < 0) {
          ldout(async_msgr->cct, 1) << __func__ << " reconnect failed "
<< dendl;
          goto fail;
        } else if (r > 0) {
          ldout(async_msgr->cct, 10) << __func__ << " nonblock connect
inprogress" << dendl;
          center->create_file_event(sd, EVENT_WRITABLE, read_handler);
          break;
        }

      lderr(async_msgr->cct) << __func__ << ":" <<__LINE__
        << " delete_file_event(" << sd << ", EVENT_WRITABLE)"
        << dendl;
        center->delete_file_event(sd, EVENT_WRITABLE);
        state = STATE_CONNECTING_WAIT_BANNER;
        break;
      }

