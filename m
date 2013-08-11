From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Sun, 11 Aug 2013 00:51:24 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
 <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:38659 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3HKAvl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Aug 2013 20:51:41 -0400
In-Reply-To: <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: =?iso-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

> 
> Hi,
> 
> > I've had a few occasions where tapdisk has segfaulted:
> >
> > tapdisk[9180]: segfault at 7f7e3a5c8c10 ip 00007f7e387532d4 sp
> 00007f7e3a5c8c10 error 4 in libpthread-2.13.so[7f7e38748000+17000]
> > tapdisk:9180 blocked for more than 120 seconds.
> > tapdisk         D ffff88043fc13540     0  9180      1 0x00000000
> >
> > and then like:
> >
> > end_request: I/O error, dev tdc, sector 472008
> >
> > I can't be sure but I suspect that when this happened either one OSD was
> > offline, or the cluster lost quorum briefly.
> 
> Interesting. There might be an issue if a request ends in error, I'll
> have to check that.
> I'll have a look on monday.
> 

You say in tdrbd_finish_aiocb:

        while (1) {
                /* POSIX says write will be atomic or blocking */
                rv = write(prv->pipe_fds[1], (void*)&req, sizeof(req));

but from what I've read in "man 7 pipe", the statement about being atomic only applies if the pipe is open in non-blocking mode, and you open it with a call to pipe() (same as pipe2(,0)) and you never call fcntl to change it. This would be consistent with the random crashes I'm seeing - I thought they were related to transient errors but my ceph cluster has been perfectly stable for a few days now and it's still happening.

What do you think?

Thanks

James

