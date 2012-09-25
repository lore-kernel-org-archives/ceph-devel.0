From: Damien Churchill <damoxc@gmail.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on
 kernel 3.2, 3.5, 3.5.4
Date: Tue, 25 Sep 2012 10:26:34 +0100
Message-ID: <CAFtEh-cp6K5VGp0qp_mOpofckb0OWEiZHpMjnbbuUUpx_b18+g@mail.gmail.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com>
	<5060E5B5.8040807@inktank.com>
	<CAP5wSLeuLhJxrqmiaz8-4SXo_Sfzs8xY23UMO2O7vivnBMNDBg@mail.gmail.com>
	<50612747.6090805@inktank.com>
	<CAP5wSLcVt5AqbNoe=snK_2gCscAion-=s9YuPQo_KeYNVCx+oQ@mail.gmail.com>
	<CAP5wSLdBMjyF=4mUWDKYpi8yfG8qOA5gFr8iZ9_3DtdKM8x_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34807 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2IYJ0f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 05:26:35 -0400
Received: by weyt9 with SMTP id t9so767707wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 02:26:34 -0700 (PDT)
In-Reply-To: <CAP5wSLdBMjyF=4mUWDKYpi8yfG8qOA5gFr8iZ9_3DtdKM8x_0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Huang <ythuang@gmail.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 25 September 2012 07:09, Christian Huang <ythuang@gmail.com> wrote:
>     we used Ubuntu 12.10 as base OS

Just a heads up, the 3.5.0-15.22 kernel in 12.10 has that patch already.
