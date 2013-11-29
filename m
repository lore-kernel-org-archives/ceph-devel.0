From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 29 Nov 2013 11:05:05 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66BB564A@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
 <CAF6-1L7UXXNRsyarZw+EcRjdPtnXAuULSZDGtDDB3Oy3O79KMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:44698 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab3K2LFL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Nov 2013 06:05:11 -0500
In-Reply-To: <CAF6-1L7UXXNRsyarZw+EcRjdPtnXAuULSZDGtDDB3Oy3O79KMQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sylvain,

Are you still working on this in any way?

It's been working great for me but seems to use an excessive amount of =
memory, like 300MB per process. Is that expected?

Thanks

James

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sylvain Munaut
> Sent: Saturday, 20 April 2013 12:41 AM
> To: Pasi K=E4rkk=E4inen
> Cc: ceph-devel@vger.kernel.org; xen-devel@lists.xen.org
> Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wan=
ts to
> test ? :p
>=20
> > If you have time to write up some lines about steps required to tes=
t this,
> > that'd be nice, it'll help people to test this stuff.
>=20
> To quickly test, I compiled the package and just replaced the tapdisk
> binary from my "normal" blktap install with the newly compiled one.
>=20
> Then you need to setup a RBD image named 'test' in the default 'rbd'
> pool. You also need to setup a proper ceph.conf and keyring file on
> the client (since librbd will use those for the parameters). The
> keyring must contain the 'client.admin' key
>=20
> Then in the config file, use something like
> "tap2:tapdisk:rbd:xxx,xvda1,w"  the 'xxx' part is currently ignored
> ...
>=20
>=20
> Cheers,
>=20
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
