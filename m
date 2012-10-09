From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: How to write data to snapshot.
Date: Tue, 9 Oct 2012 06:56:31 +0000 (UTC)
Message-ID: <loom.20121009T085302-672@post.gmane.org>
References: <loom.20121007T070909-887@post.gmane.org> <CADvuQRHsA1peMugN4acw7o9SHDCtbP4wpXD_DXPsjZhCY7ZNfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46280 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab2JIG4o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Oct 2012 02:56:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TLTkF-0004SA-1J
	for ceph-devel@vger.kernel.org; Tue, 09 Oct 2012 08:56:47 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 08:56:47 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 08:56:47 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Tommi ,

    If we convert snapshot into writable(mutable),we will copy data to that 
snapshot and getting data multiple times,is it possible.
This will works on ceph-0.48 or any other version.

Thanks,
Ramu.


