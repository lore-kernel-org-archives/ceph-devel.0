From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: OSD daemon changes port no
Date: Mon, 3 Dec 2012 10:20:12 +0100
Message-ID: <CAF6-1L4+0CwzW=to5DWe_q3bEk6eD3hMSLeekN2hZ5fhHTZ2=g@mail.gmail.com>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
	<alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net>
	<CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com>
	<alpine.DEB.2.00.1211202217320.1082@cobra.newdream.net>
	<CAGfy=6=7xGcuaDnB72Lp9mey_esU015wCyiTZKPHwEFw=pEuyQ@mail.gmail.com>
	<alpine.DEB.2.00.1211202302390.1082@cobra.newdream.net>
	<CAGfy=6mL5UAeO9EM7VD4BbRRYy2eC8C1HLMu3vvyizYD43NiGw@mail.gmail.com>
	<alpine.DEB.2.00.1211210726110.1082@cobra.newdream.net>
	<CAGfy=6kAkXrdYwL-Ui-Xd2Qsqaf8hcUbWGY94QOFfaRA1AmUrA@mail.gmail.com>
	<alpine.DEB.2.00.1211260826190.23552@cobra.newdream.net>
	<CAGfy=6mOnv90GighPr=nTWapJU_4wjo-z9nHh_ji6VvvrUeMHg@mail.gmail.com>
	<alpine.DEB.2.00.1211270851320.30109@cobra.newdream.net>
	<CAGfy=6mNa02BE6vsRssx6qURxCy9TtnXShxaS0PMPcepnuARvQ@mail.gmail.com>
	<CAGfy=6mDnVDTSNFD5R-iXz1cPAty1FmXa7fX6K1kA9UqAWJvCg@mail.gmail.com>
	<CAGfy=6kNPEiUSByW7Bo6CMgttXdZSdYR5ESajXWxEW30+qyhPw@mail.gmail.com>
	<alpine.DEB.2.00.1211300831310.3173@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63155 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2LCJUN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 04:20:13 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2410011oag.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 01:20:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211300831310.3173@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: hemant surale <hemant.surale@gmail.com>, ceph-devel@vger.kernel.org

> # cephfs foo set_layout --pool 3

From early tests I seem to remember that just setting the pool using
set_layout wasn't accepted by the tool, I had to reset all the layout
parameters in the command.

Cheers,

    Sylvain
