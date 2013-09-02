From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw 0.67.2 update -> "ERROR: failed to initialize watch"
Date: Mon, 2 Sep 2013 17:14:16 +0200
Message-ID: <CAF6-1L7hiN7WJ4WAiwjvRd1LNY2GjbYSS5tAkxYu9u7CuHv6Ww@mail.gmail.com>
References: <CAF6-1L66AG8a1N0ujFvAbYYgXTZ41ug6HtiLvPY8c_AEriHXAw@mail.gmail.com>
	<CAF6-1L67azE9qJpsmFWAPdjD+yd9WmPKRoLxGe9pS5GDnHE=pQ@mail.gmail.com>
	<CAF6-1L7z8i4NfYT4NC8ymFo1p1WTkxxdi2==AUFtEA_7J1fK1w@mail.gmail.com>
	<CABBk=J9TgfADOStKVct8Gbut+T1nuBO+jCdHL5L3mjRWamyBrg@mail.gmail.com>
	<CAF6-1L6i=fwrSo5dmsyrLRiYjy-5UzmO4dzWnX-drLx=TkXZ=g@mail.gmail.com>
	<CABBk=J-OUyvRSyoN8pc_4-GmE-XbRwjEAHMyC=9kAGhzbbgD4g@mail.gmail.com>
	<CAC-hyiHoHf7aZCyt2x7xgigD5+jfey3b57R1kDQA2X0qnFNFBg@mail.gmail.com>
	<CAF6-1L7qMw1Bp=La=+TsC-dhEX5EJSMJPxjOZnbfkzNALXmZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64810 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140Ab3IBPOR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Sep 2013 11:14:17 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4849408pdj.36
        for <ceph-devel@vger.kernel.org>; Mon, 02 Sep 2013 08:14:17 -0700 (PDT)
In-Reply-To: <CAF6-1L7qMw1Bp=La=+TsC-dhEX5EJSMJPxjOZnbfkzNALXmZUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,


>> I just pushed a fix to wip-6161, can you verify that it fixes the issue
>> for you?

The fix wip-6161 branch seem to fix the problem for me. I was able to
re-enable the cache and have radosgw start (and seemingly work
properly).

Cheers,

    Sylvain
