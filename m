From: Holger =?iso-8859-1?q?Hoffst=E4tte?=
	<holger.hoffstaette@googlemail.com>
Subject: Re: Suspend and the ceph clients
Date: Thu, 15 May 2014 08:28:43 +0000 (UTC)
Message-ID: <pan.2014.05.15.08.28.42@googlemail.com>
References: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
	<pan.2014.05.15.08.13.59@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56496 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaEOI25 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 May 2014 04:28:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Wkr27-0005Lk-MS
	for ceph-devel@vger.kernel.org; Thu, 15 May 2014 10:28:55 +0200
Received: from p5b007409.dip0.t-ipconnect.de ([91.0.116.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 10:28:55 +0200
Received: from holger.hoffstaette by p5b007409.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 10:28:55 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Forgot something..

> User space is usually controlled by ("legacy") pm-utils, which simply

The power management events themselves are typically handled via acpid,
which then executes scripts associated with them (i.e. things provided
by pm-utils). Division of responsibilities.
Not sure how PM would work without ACPI.

-h

