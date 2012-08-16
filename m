From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 16 Aug 2012 15:55:30 -0700
Message-ID: <CADvuQRECoAOwck32hhtSLjUVRcDAXXE_WNWh5LnYYKN87Q2X-A@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de>
 <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net> <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net>
 <CADvuQRGBEva_8OB--M2JxMBoCXQ3i5GJkaJ-QvP-SoVqv7xDzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53206 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752354Ab2HPWzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 18:55:52 -0400
Received: by lagy9 with SMTP id y9so1773631lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 15:55:50 -0700 (PDT)
In-Reply-To: <CADvuQRGBEva_8OB--M2JxMBoCXQ3i5GJkaJ-QvP-SoVqv7xDzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 3:52 PM, Tommi Virtanen <tv@inktank.com> wrote:
> I'm not sure how well our config system will handle dynamic variable
> names -- ceph-authtool was fine with me just putting data in

*ceph-conf
