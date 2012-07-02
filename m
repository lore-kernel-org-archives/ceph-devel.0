From: Florian Haas <florian.haas@hastexo.com>
Subject: Assertion failure when radosgw can't authenticate
Date: Mon, 2 Jul 2012 13:45:38 +0200
Message-ID: <CAPUexz-VFp0i8Q-MDH1TyEsEQRAuLx8JNfq6hxTms=U3zKnf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51286 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2GBLpj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 07:45:39 -0400
Received: by qaas11 with SMTP id s11so1807490qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 04:45:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

in cephx enabled clusters (0.47.x), authentication failures from
radosgw seem to lead to an uncaught assertion failure:

2012-07-02 11:26:46.559830 b69c5730  0 librados:
client.radosgw.charlie authentication error (1) Operation not
permitted
2012-07-02 11:26:46.560093 b69c5730 -1 Couldn't init storage provider (RADOS)
2012-07-02 11:26:46.560401 b69c5730 -1 common/Timer.cc: In function
'SafeTimer::~SafeTimer()' thread b69c5730 time 2012-07-02
11:26:46.5601
10
common/Timer.cc: 57: FAILED assert(thread == __null)

 ceph version 0.47.3 (commit:c467d9d1b2eac9d3d4706b8e044979aa63b009f8)
 1: (SafeTimer::~SafeTimer()+0x96) [0x80a5c76]
 2: (main()+0x56f) [0x809708f]
 3: (__libc_start_main()+0xe6) [0xb6cefca6]
 4: /usr/bin/radosgw() [0x807f4a1]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
    -2> 2012-07-02 11:26:46.559830 b69c5730  0 librados:
client.radosgw.charlie authentication error (1) Operation not
permitted
    -1> 2012-07-02 11:26:46.560093 b69c5730 -1 Couldn't init storage
provider (RADOS)
     0> 2012-07-02 11:26:46.560401 b69c5730 -1 common/Timer.cc: In
function 'SafeTimer::~SafeTimer()' thread b69c5730 time 2012-07-02
11:26
:46.560110
common/Timer.cc: 57: FAILED assert(thread == __null)

Kinda ugly. Maybe this could be fixed in the pending 0.48 release.

The issue obviously goes away immediately after correcting the auth credentials.

Cheers,
Florian
