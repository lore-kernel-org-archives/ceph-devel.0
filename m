From: hemant surale <hemant.surale@gmail.com>
Subject: Re: OSD daemon changes port no
Date: Mon, 3 Dec 2012 16:30:46 +0530
Message-ID: <CAGfy=6nxXXE+Rpa69E5McnGoaaS2k8SuXO_b0q_Omc6JSuZtMA@mail.gmail.com>
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
	<CAF6-1L4+0CwzW=to5DWe_q3bEk6eD3hMSLeekN2hZ5fhHTZ2=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44536 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab2LCLAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 06:00:48 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1433274vby.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 03:00:47 -0800 (PST)
In-Reply-To: <CAF6-1L4+0CwzW=to5DWe_q3bEk6eD3hMSLeekN2hZ5fhHTZ2=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Yeah. Here I also used "cephfs foomount --pool 3 -c 1 -u 4194304 -s
4194304 " instead of "cephfs foomount --pool 3 "



On Mon, Dec 3, 2012 at 2:50 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
>> # cephfs foo set_layout --pool 3
>
> From early tests I seem to remember that just setting the pool using
> set_layout wasn't accepted by the tool, I had to reset all the layout
> parameters in the command.
>
> Cheers,
>
>     Sylvain
