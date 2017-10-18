From: Ricardo Dias <rdias@suse.com>
Subject: Messenger V2
Date: Wed, 18 Oct 2017 15:50:18 +0100
Message-ID: <1508338218.21259.33.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39100 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdJROu3 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 18 Oct 2017 10:50:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

By reading the old "msgr2 protocol" thread, and according to this
particular response (https://marc.info/?l=ceph-devel&m=147361359132535&
w=2), I understood that the idea is to allow a daemon/client to
instantiate a V2 msgr instance in a new port, while still allowing a V1
msgr instance to exist.

I'm starting to make some changes to the msgr code, and I'm planning to
allow the specification of the protocol (V1 or V2) in the constructor.
This allows to create two messengers instances each one using a
different protocol and bonded to different ports.
Does this make sense?

Also, since we want to support multiple Ceph daemons (multiplexing) in
the same process, what would be the preferable API (messenger <-> Ceph
daemon) to be user:

a) Instantiate a single Messenger object and share the instance between
the multiple "sub-daemons"
b) Each "sub-daemon" instantiates a Messenger object, and the internal
Messenger code will take care of the magic of re-using/sharing the
connections to the same peers.

The current API for using the messenger exposes the "Connection"
abstraction. With the multiplexing feature, we will have "Stream"s
inside each "Connection".
My question is: should we keep the same API, hence the Connection
interface, and use it has actually a stream? (this has the benefit of
requiring almost no changes to the current code). 

Or, should we expose the Stream abstraction and rewrite the code that
uses the Messenger/Connection?

Thanks,
-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
