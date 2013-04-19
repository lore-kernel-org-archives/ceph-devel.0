From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 19 Apr 2013 16:41:29 +0200
Message-ID: <CAF6-1L7UXXNRsyarZw+EcRjdPtnXAuULSZDGtDDB3Oy3O79KMQ@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:33530 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030552Ab3DSOla (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 10:41:30 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so1746520bkt.24
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 07:41:29 -0700 (PDT)
In-Reply-To: <20130419064524.GQ11427@reaktio.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: ceph-devel@vger.kernel.org, xen-devel@lists.xen.org

> If you have time to write up some lines about steps required to test this,
> that'd be nice, it'll help people to test this stuff.

To quickly test, I compiled the package and just replaced the tapdisk
binary from my "normal" blktap install with the newly compiled one.

Then you need to setup a RBD image named 'test' in the default 'rbd'
pool. You also need to setup a proper ceph.conf and keyring file on
the client (since librbd will use those for the parameters). The
keyring must contain the 'client.admin' key

Then in the config file, use something like
"tap2:tapdisk:rbd:xxx,xvda1,w"  the 'xxx' part is currently ignored
...


Cheers,

    Sylvain
