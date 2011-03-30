From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: rbd: null pointer dereferenced during osd_reset
Date: Wed, 30 Mar 2011 13:42:47 +0800
Message-ID: <AANLkTimCPu=_pfi8xXWnOZpHEhddt_oBCu2dhyNwuhk8@mail.gmail.com>
References: <AANLkTikr09GsB49N0dSOyvfY63CkTx9CBj4iSG460_BN@mail.gmail.com>
	<Pine.LNX.4.64.1103291103240.19819@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65379 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1C3Fms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2011 01:42:48 -0400
Received: by fxm17 with SMTP id 17so778832fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2011 22:42:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103291103240.19819@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> The patch below (also pushed to ceph-client.git master) should fix this.
> Can you give it a test?
>

The exception still occurred with this patch. From the log below, the
case seems to be:

===================
kernel: libceph: osd0 192.168.101.134:6800 socket closed
kernel: libceph:  fault ffff880002284830 state 69 to peer 192.168.101.134:6800
kernel: libceph:  fault on LOSSYTX channel
kernel: libceph:  osd_reset osd0
kernel: libceph:  __kick_osd_requests osd0
kernel: libceph:  __reset_osd ffff880002284800 osd0
kernel: libceph:  con_close ffff880002284830 peer 192.168.101.134:6800
kernel: libceph:  get_osd ffff880002284800 2 -> 3
kernel: libceph:  queue_con ffff880002284830 - already BUSY
kernel: libceph:  put_osd ffff880002284800 3 -> 2
kernel: libceph:  con_open ffff880002284830 192.168.101.134:6800
kernel: libceph:  get_osd ffff880002284800 2 -> 3
kernel: libceph:  queue_con ffff880002284830 - already BUSY
kernel: libceph:  put_osd ffff880002284800 3 -> 2
kernel: libceph:  __unregister_linger_request ffff880002511e00
kernel: libceph:  moving osd to ffff880002284800 lru
kernel: libceph:  __move_osd_to_lru ffff880002284800
===================

The linger request should had succeeded, so it was removed from osd0's
o_requests list and put on o_linger_requests during handle_reply().
Since it is not on o_requests any more, the req->r_osd is set to NULL
even with the patch.

===================
kernel: libceph:  register_request ffff880002511e00 tid 178
kernel: libceph:   first request, scheduling timeout
kernel: libceph:  requeued lingering ffff880002511e00 tid 178 osd0
kernel: libceph:  send_queued
kernel: BUG: unable to handle kernel NULL pointer dereference at
0000000000000010
kernel: IP: [<ffffffffa01494ac>] __send_request+0x27/0xd5 [libceph]
===================

I wonder if we should not requeue the succeeded linger request in
__kick_osd_requests as below.

@@ -576,15 +576,6 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
                if (!req->r_linger)
                        req->r_flags |= CEPH_OSD_FLAG_RETRY;
        }
-
-       list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
-                                r_linger_osd) {
-               __unregister_linger_request(osdc, req);
-               __register_request(osdc, req);
-               list_move(&req->r_req_lru_item, &osdc->req_unsent);
-               dout("requeued lingering %p tid %llu osd%d\n", req, req->r_tid,
-                    osd->o_osd);
-       }
 }

--
Henry
