From: Abhishek Dixit <dixitabhi@gmail.com>
Subject: RGW : Transaction Id in response?
Date: Thu, 26 Feb 2015 10:05:40 +0530
Message-ID: <CAGoDY9=k7MFQVv_cJaV5jPtJUQwHddr=OmCySSC599vW4hLB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:37235 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBZEgC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 23:36:02 -0500
Received: by labhs14 with SMTP id hs14so8549236lab.4
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 20:36:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I was doing comparison of Open Stack Swift response headers and Ceph
RGW response.
This is in regard to X-Trans-Id header in response from Open Stack
Swift storage.
Swift response to a request always have the header "X-Trans-Id".
X-Trans-Id : A unique transaction identifier for this request.

X-Trans-Id seems to serve two purpose:
1. Every log messages for a request will carry this and aid in
debugging/analyzing.
2. Benchmarking for latency.

So, do we have similar unique identifier in Ceph RGW response which
associates with each request?

Or do we need add support for this?

Thanks
Abhishek Dixit
