From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 15:58:27 -0500
Message-ID: <53333F73.709@ieee.org>
References: <1395736765.2823.29.camel@localhost>	<1395780835.2076.15.camel@localhost>	<1395781847.2076.21.camel@localhost>	<CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>	<1395782577.2076.23.camel@localhost>	<CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>	<1395783675.2076.26.camel@localhost>	<CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>	<1395784476.2076.28.camel@localhost>	<1395785839.2076.30.camel@localhost>	<5332075F.8080105@ieee.org>	<1395788695.2076.35.camel@localhost>	<53321896.1080606@ieee.org>	<1395797596.2076.43.camel@localhost>	<1395798658.2076.45.camel@localhost>	<5332339A.8030000@ieee.org>	<1395801625.2076.52.camel@localhost>	<53323EA5.6010506@ieee.org>	<1395801940.2076.54.camel@localhost>	<53324F79.1080108@ieee.or
 g>	<1395806447.2076.70.camel@localhost>	<53325F09.7000306@ieee.org>	<5332B643.5040403@ieee.org> <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:55879 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbaCZU6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 16:58:07 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so2217935iec.25
        for <ceph-devel@vger.kernel.org>; Wed, 26 Mar 2014 13:58:06 -0700 (PDT)
In-Reply-To: <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

Olivier reports that with the simple patch I provided
(which changed a "<" to a "!=" and removed an assertion)
he is running successfully.

To me this is fantastic news, and you can see I posted
a patch with the fix.

There remains a race condition though, one which I described
in a separate message earlier today.  I don't think it will
prove to be a problem in practice, but I agreed to work on
a fix to ensure the race condition is eliminated.  It will
require some work with reference counting image and object
requests.

The fix won't be coming today.  But I aim to provide it
in a matter of several days.

					-Alex
