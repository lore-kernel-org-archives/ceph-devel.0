From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Can't restart ceph-mon
Date: Wed, 26 Jun 2013 08:10:05 +0800
Message-ID: <CAJiejCSHa0XoYOet7nFpJJC50G4yD9Mc2sfdwVsMSvreMN_u3A@mail.gmail.com>
References: <CAJiejCT4ALLi5nTqjtyL+bzhy=qkQUk34J=y8iJB=jqTh_fXDA@mail.gmail.com>
 <alpine.DEB.2.00.1306242034230.8175@cobra.newdream.net> <CAJiejCTHEwXDbUHeN33dFORuiwSMWnpkGT-eBO2xk2CS-b3kQA@mail.gmail.com>
 <alpine.DEB.2.00.1306250825070.2998@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:63581 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3FZAK0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 20:10:26 -0400
Received: by mail-qe0-f51.google.com with SMTP id a11so760995qen.24
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jun 2013 17:10:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306250825070.2998@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

2013/6/25 Sage Weil <sage@inktank.com>:
> On Tue, 25 Jun 2013, Drunkard Zhang wrote:
>> 2013/6/25 Sage Weil <sage@inktank.com>:
>> > What version of ceph is this?
>> >
>> c16 ~ # ceph -v
>> ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)
>
> Please try v0.61.4.. this and many other bugs have been fixed since then.
>
Thanks for your reply, I'm just providing information in case there
was a bug, and I'm planning to upgrade whole cluster to v0.61.* too :)
