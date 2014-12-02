From: Haomai Wang <haomaiwang@gmail.com>
Subject: Lock Constrains about Fast Dispatch for Messenger
Date: Tue, 2 Dec 2014 16:27:29 +0800
Message-ID: <CACJqLybxW2QN1YMM2ip0=D9PczZZ-bywQUqOnEPtyCqmZRQAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:58020 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaLBI1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 03:27:31 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so8045142wgh.22
        for <ceph-devel@vger.kernel.org>; Tue, 02 Dec 2014 00:27:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Gregoy and Sage,

I'm just writing Messenger's unit tests to ensure that SimpleMessenger
and AsyncMessenger behavior same and expected.

I think the most unclear thing is the lock rule of fast dispatch. When
introduced fast dispatch, there exists three methods
"ms_fast_connect", "ms_fast_accept", "ms_fast_dispatch" will be called
within Messenger's thread. Because without fast dispatcher all
messages are delivered from queue to queue, fast path will result in
potential dead lock I think.

"ms_fast_accept" and "ms_fast_connect" are called with
"pipe_lock"(Pipe) or "lock"(AsyncConnection). And
Connection::send_message will called outsider. So it may happen:

Other thread                   Messenger's thread
       lock()                          connection lock()
  send_message()                  connect
 try connection lock()         ms_fast_connect()

                          DEAD LOCK

So I'm not sure whether we have some lock rules whether on caller side
or ms_fast_connect/accept side. For example, ms_fast_connect/accept
can't acquire the same lock with send_message?

-- 

Best Regards,

Wheat
