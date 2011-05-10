From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 11:47:01 +0000 (UTC)
Message-ID: <loom.20110510T134503-22@post.gmane.org>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51603 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1EJLrR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2011 07:47:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QJlPH-00037S-NV
	for ceph-devel@vger.kernel.org; Tue, 10 May 2011 13:47:15 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:47:15 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:47:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Simon Tian <aixt2006 <at> gmail.com> writes:

> [root <at> mon-00 ~]# cclass -a
> [root <at> mon-00 ~]# ceph class list

Do you forget "ceph class activate rbd 1.3" ?


