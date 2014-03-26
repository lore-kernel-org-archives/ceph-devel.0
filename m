From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 06:47:30 -0500
Message-ID: <5332BE52.6020404@ieee.org>
References: <1395736765.2823.29.camel@localhost>	<1395780835.2076.15.camel@localhost>	<1395781847.2076.21.camel@localhost>	<CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>	<1395782577.2076.23.camel@localhost>	<CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>	<1395783675.2076.26.camel@localhost>	<CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>	<1395784476.2076.28.camel@localhost>	<1395785839.2076.30.camel@localhost>	<5332075F.8080105@ieee.org>	<1395788695.2076.35.camel@localhost>	<53321896.1080606@ieee.org>	<1395797596.2076.43.camel@localhost>	<1395798658.2076.45.camel@localhost>	<5332339A.8030000@ieee.org>	<1395801625.2076.52.camel@localhost>	<53323EA5.6010506@ieee.org>	<1395801940.2076.54.camel@localhost>	<53324F79.1080108@ieee.or
 g>	<1395806447.2076.70.camel@localhost>	<53325F09.7000306@ieee.org>	<5332B643.5040403@ieee.org> <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46894 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbaCZLrK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 07:47:10 -0400
Received: by mail-ob0-f175.google.com with SMTP id uy5so2297426obc.34
        for <ceph-devel@vger.kernel.org>; Wed, 26 Mar 2014 04:47:10 -0700 (PDT)
In-Reply-To: <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/26/2014 06:43 AM, Ilya Dryomov wrote:
> It looks like img_request kref currenlty exists for posterity only.
> Unless I'm missing something, its counter is set to 1 in
> rbd_img_request_create() and is not incremented anywhere else, which
> means that the instant rbd_img_request_put() is called, img_request is
> freed.  I naively assumed it was incremented and decremented in
> rbd_img_obj_request_add() and rbd_img_obj_request_del() respectively..
> Maybe that's something we should look at first?

I believe it was something that I never finished implementing.

So yes, the kref is there to be used, it just isn't, really.

If you want to give it a try, be my guest.  I'll review it
carefully.  (I can't really test my changes very well anyway.)

If you want me to do it, let me know.

					-Alex
