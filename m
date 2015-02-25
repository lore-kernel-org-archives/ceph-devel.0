From: Srini Vempati <svempati@clearskydata.com>
Subject: Hitting assert in OSDService::get_map during OSD start time
Date: Tue, 24 Feb 2015 21:57:15 -0500
Message-ID: <D112A43B.3476%svempati@clearskydata.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:38668 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbBYC5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 21:57:21 -0500
Received: by qcvx3 with SMTP id x3so927795qcv.5
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 18:57:20 -0800 (PST)
Received: from [192.168.50.194] ([75.143.26.118])
        by mx.google.com with ESMTPSA id p8sm651364qha.20.2015.02.24.18.57.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 18:57:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

While  experimenting with key value backend store we are hitting the
assert in OSDService::get_map during one of the OSD start time.

Can you please help us in understanding

1. What is the reason to hit this assert
2. Is there anyway I can work around so that I can bring my OSD back
without losing the data.


We have setup the CEPH cluster with 2 nodes, 10 OSDs per node  and we are
using 0.91 version.


0> 2015-02-24 16:45:48.407399 7fac29954980 -1 *** Caught signal (Aborted)
**
 in thread 7fac29954980

 ceph version 0.91 (725d66098c98c2008b5fa07538325cc6816ca4a1)
 1: /usr/bin/ceph-osd() [0xb06e05]
 2: (()+0xf130) [0x7fac27a1c130]
 3: (gsignal()+0x39) [0x7fac264325c9]
 4: (abort()+0x148) [0x7fac26433cd8]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x175) [0x7fac26d36de5]
 6: (()+0x5de36) [0x7fac26d34e36]
 7: (()+0x5de81) [0x7fac26d34e81]
 8: (()+0x5e099) [0x7fac26d35099]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x269) [0xbfe439]
 10: (OSDService::get_map(unsigned int)+0x3f) [0x6e1eaf]
 11: (OSD::load_pgs()+0x1b78) [0x69db98]
 12: (OSD::init()+0xc6f) [0x69f8bf]
 13: (main()+0x26b9) [0x624d29]
 14: (__libc_start_main()+0xf5) [0x7fac2641eaf5]
 15: /usr/bin/ceph-osd() [0x63ee19]



Thanks,
Srini


