From: hemant surale <hemant.surale@gmail.com>
Subject: Re: OSD daemon changes port no
Date: Tue, 27 Nov 2012 15:07:33 +0530
Message-ID: <CAGfy=6khPdyuyeERLj6r849L8VPPq_mbaKod5rxBjUYxHhsY6w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57308 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2K0Jhe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 04:37:34 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6623187vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 01:37:33 -0800 (PST)
In-Reply-To: <CAGfy=6mOnv90GighPr=nTWapJU_4wjo-z9nHh_ji6VvvrUeMHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

I did "mkdir a " "chmod 777 a" . So dir "a" is /home/hemant/a" .
then I used "mount.ceph 10.72.148.245:/ /home/hemant/a "
after that following cmd is executed

root@hemantsec-virtual-machine:/home/hemant# cephfs /home/hemant/a
set_layout --pool 3
Error setting layout: Invalid argument


Please help me out with this problem.

-
Hemant Surale.

On Tue, Nov 27, 2012 at 3:06 PM, hemant surale <hemant.surale@gmail.com> wrote:
> I did "mkdir a " "chmod 777 a" . So dir "a" is /home/hemant/a" .
> then I used "mount.ceph 10.72.148.245:/ /ho
>
> root@hemantsec-virtual-machine:/home/hemant# cephfs /home/hemant/a
> set_layout --pool 3
> Error setting layout: Invalid argument
