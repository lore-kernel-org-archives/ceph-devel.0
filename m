From: Roald van Loon <roaldvanloon@gmail.com>
Subject: RGW getting revoked tokens from keystone not working
Date: Tue, 6 Aug 2013 14:10:45 +0200
Message-ID: <CAN04cT6ZeAYVGPthhfS0CyV6XGQt27H3VcJHEFKusqpVvCR19g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:48241 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab3HFMKq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 08:10:46 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so605592obc.27
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 05:10:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph devs,

I was working with a RGW / keystone implementation, source tree from
github master. I stumbled against this error from the radosgw log;

2013-08-06 14:00:02.523331 7f929c011780 10 allocated request req=0x1c31640
2013-08-06 14:00:02.556052 7f923bfff700 10 request returned
2013-08-06 14:00:02.556238 7f923bfff700  0 ERROR: keystone revocation
processing returned error r=-22

That was weird (nothing after the "request returned"), because I
checked the request using curl and it actually returned data. Then I
found this;

https://github.com/ceph/ceph/blob/master/src/rgw/rgw_swift.cc#L307

Shouldn't read_data be receive_data, because the received_data is
called by the curl_easy_perform? Or else the bufferlist in
RGWSwift::check_revoked() will remain empty at all times.

I might be missing something, so that's why I'm mailing the question
instead of mailing the patch...

- Roald
