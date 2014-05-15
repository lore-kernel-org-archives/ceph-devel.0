From: Holger =?iso-8859-1?q?Hoffst=E4tte?=
	<holger.hoffstaette@googlemail.com>
Subject: Re: Suspend and the ceph clients
Date: Thu, 15 May 2014 08:13:59 +0000 (UTC)
Message-ID: <pan.2014.05.15.08.13.59@googlemail.com>
References: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44638 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbaEOIOX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 May 2014 04:14:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Wkqny-0000RB-6G
	for ceph-devel@vger.kernel.org; Thu, 15 May 2014 10:14:18 +0200
Received: from p5b007409.dip0.t-ipconnect.de ([91.0.116.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 10:14:18 +0200
Received: from holger.hoffstaette by p5b007409.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 10:14:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, 14 May 2014 15:07:44 -0700, Gregory Farnum wrote:
> [..]
> Unfortunately, I don't know anything about Linux's suspend
> functionality or APIs, and my weak attempts at googling and grepping
> aren't turning anything up. So a question to everybody:
> 
> 2) What notifications does Linux send, and what filesystem mechanisms
> does it invoke, when it is suspending?

Is this what you're looking for?
https://www.kernel.org/doc/Documentation/power/freezing-of-tasks.txt

User space is usually controlled by ("legacy") pm-utils, which simply
executes a bunch of scripts (packaged and user provided) in various
stages. It works reasonably well but is of course fragile - typical
scripted duct tape.

systemd has its own (IMHO much less fragile) way of doing things:
http://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.html

Hope this helps.

-h

