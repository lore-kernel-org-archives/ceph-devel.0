From: Ning Yao <zay11022@gmail.com>
Subject: what is the main reason for bad crc in data
Date: Wed, 18 Mar 2015 11:08:00 +0800
Message-ID: <CALZt5jzOXwDgaeMfRH=_F3U_-vBFA9b8E1j4dpe8y-tS+3J+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36574 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbbCRDIA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 23:08:00 -0400
Received: by oigv203 with SMTP id v203so25822659oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 20:08:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

2015-03-16 15:55:11.124711 7fa0629da700  0 bad crc in data 2453778563
!= exp 2391663503
why we always got those error, probably consecutive several pieces for
every three or four days?
As is known for us, TCP layer uses its own crc verification to
guarantee the correctness of the receiving data in network. So we may
assume the main reasons coming from the memory error with non-ECC main
memory?
If so, we also cannot guarantee the data we write to the physical
storage is correct with non-ECC memory? Then it may cause the
data-inconsistency (and we may repair it during scrubing repair
process if the content is owned  by object data, or it may lead to osd
error, if the inconsistent data occurs in pg_log, pg_info or osdmap?)

Regards
Ning Yao
