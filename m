From: Sage Weil <sage@inktank.com>
Subject: Re: Can't restart ceph-mon
Date: Tue, 25 Jun 2013 08:25:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306250825070.2998@cobra.newdream.net>
References: <CAJiejCT4ALLi5nTqjtyL+bzhy=qkQUk34J=y8iJB=jqTh_fXDA@mail.gmail.com> <alpine.DEB.2.00.1306242034230.8175@cobra.newdream.net> <CAJiejCTHEwXDbUHeN33dFORuiwSMWnpkGT-eBO2xk2CS-b3kQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43469 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3FYPZZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 11:25:25 -0400
In-Reply-To: <CAJiejCTHEwXDbUHeN33dFORuiwSMWnpkGT-eBO2xk2CS-b3kQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

On Tue, 25 Jun 2013, Drunkard Zhang wrote:
> 2013/6/25 Sage Weil <sage@inktank.com>:
> > What version of ceph is this?
> >
> c16 ~ # ceph -v
> ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)

Please try v0.61.4.. this and many other bugs have been fixed since then.

Thanks!
sage

