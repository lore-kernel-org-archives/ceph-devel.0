From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 22:19:37 +0100
Message-ID: <CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62669 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWVTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:19:39 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so1186791wey.5
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:19:38 -0800 (PST)
In-Reply-To: <CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
> That's one step further. What does the log show now?

I've solved. Ceph primary keyring should be also placed on radosgw.

On radosgw these two files are needed:
/etc/ceph/ceph.conf (the same for the whole cluster)
/etc/ceph/ceph.keyring (the same for the whole cluster)
