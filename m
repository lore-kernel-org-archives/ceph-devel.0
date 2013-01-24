From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Thu, 24 Jan 2013 23:10:08 +0100
Message-ID: <CAJH6TXgYCA4oZXOocTcTC_oZEm=nsV-YB4K9vSW9pN6-32ORdg@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
	<CAJH6TXh68YA2=Dc86==21LjOtAfiZHSzXRgxMPtepw2TBV_tyQ@mail.gmail.com>
	<CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52352 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab3AXWKK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 17:10:10 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so671226wgb.4
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 14:10:09 -0800 (PST)
In-Reply-To: <CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
> You mean a radosgw user?

This command:
radosgw-admin user create --uid=johndoe --display-name="John Doe"
--email=john@example.com

should be ran on radosgw node or on ceph node?
Because I'm able to create the user, but unable to authenticate with
any S3 client (I receive a 403 error)
