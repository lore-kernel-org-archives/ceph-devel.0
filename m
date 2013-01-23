From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 22:25:56 +0100
Message-ID: <CAJH6TXh68YA2=Dc86==21LjOtAfiZHSzXRgxMPtepw2TBV_tyQ@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47722 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3AWVZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:25:57 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so1144431wib.15
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:25:56 -0800 (PST)
In-Reply-To: <CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:
> I've solved. Ceph primary keyring should be also placed on radosgw.
>
> On radosgw these two files are needed:
> /etc/ceph/ceph.conf (the same for the whole cluster)
> /etc/ceph/ceph.keyring (the same for the whole cluster)

Now I'm unable to create a rados user:

2013-01-23 22:25:25.679678 7f6e814c2700  0 -- x.y.z.111:0/1006191 >>
x.y.z.102:6801/7493 pipe(0x1819490 sd=4 :0 pgs=0 cs=0 l=1).fault
