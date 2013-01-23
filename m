From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 22:43:23 +0100
Message-ID: <CAJH6TXi2xDN=RPCxnvbOt727v=VgR_V4xVrLjNH-8MDnSaXvfQ@mail.gmail.com>
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
Received: from mail-wg0-f52.google.com ([74.125.82.52]:58660 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab3AWVnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:43:25 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so3084746wgh.31
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:43:23 -0800 (PST)
In-Reply-To: <CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
> You mean a radosgw user?

Yes.

> You need to run radosgw-admin also with '-n client.radosgw.gateway',
> or have the client.admin key in your keyring.

same results with '-n client.radosgw.gateway'
