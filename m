From: Dong Yuan <yuandong@unitedstack.com>
Subject: Question about Transaction::get_data_alignment
Date: Wed, 5 Nov 2014 14:29:46 +0800
Message-ID: <CAMm-wc+v1_yrcHgftxjgNBo1QARP29K5V_mshuANYq=gn8yRXg@mail.gmail.com>
Reply-To: yuandong1222@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgsg2.qq.com ([54.254.200.128]:49957 "EHLO smtpbgsg2.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbaKEGai (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Nov 2014 01:30:38 -0500
Received: from mail-vc0-f181.google.com (unknown [209.85.220.181])
	by esmtp4.qq.com (ESMTP) with SMTP id 0
	for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 14:29:47 +0800 (CST)
Received: by mail-vc0-f181.google.com with SMTP id hy10so44488vcb.26
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 22:29:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

I am now working with the BP osd: update Transaction encoding, but the
Transaction::get_data_alignment make me confused.

This method give the alignment which is used by FileJournal to do
better buffer build. It calculate the alignment by largest_data_off
and get_data_offset() while the first is an offset of some object and
the second is an offset of the transaction encode result. I am not
sure there is any reason to do calculation between them.

The code works fine, probably because any result is fine for
Transaction::get_data_alignment, while
FileJournal::prepare_single_write can use any alignment value to build
logical bufferlist.

Can you give me some explanation?  Thank you.


-- 
Dong Yuan
UnitedStack
Room 302, Block C, Building. 4, Zongguancun Software Park, 100193
Haidian Dist. Beijing. China
yuandong@unitedstack.com


