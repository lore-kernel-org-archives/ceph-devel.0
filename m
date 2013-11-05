From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: writing a ceph cliente for MS windows
Date: Tue, 5 Nov 2013 23:33:24 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665DB5E4@BITCOM1.int.sbss.com.au>
References: <52780140.6090409@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:59789 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab3KEX6L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 18:58:11 -0500
In-Reply-To: <52780140.6090409@kepler.cl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas Michels <asalas@kepler.cl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Good day developers!
> 
> I would like to propose to the one interested  work with me to develop a
> ceph cliente for MS windows world, Basing us on dokanFS.
> 

I've looked at porting the rbd client to windows a little while back. That would require a kernel driver and all the rbd stuff is C++ (windows kernel is strictly C) so it was looking like a lot of work. Porting the rbd kernel implementation from Linux would have been easier.

An alternative would be to write a fuse-like kernel driver that talks to a userspace implementation of librbd. That would have been slower though, and have some restrictions like no swap space and no booting (although booting would have been a hard problem to solve even with a kernel-only implementation...)

Good luck!

James
