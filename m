From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 06:47:07 +0100
Message-ID: <D37FDADD-C230-48D8-AA09-38C474D1F395@profihost.ag>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com> <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net> <50F72150.7080002@inktank.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:54166 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab3AQFrM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 00:47:12 -0500
In-Reply-To: <50F72150.7080002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

Am 16.01.2013 um 22:53 schrieb Mark 
> With only 2 SSDs for 12 spinning disks, you'll need to make sure the SSDs are really fast.  I use Intel 520s for testing which are great, but I wouldn't use them in  production.

Why not? I use them for a ssd only ceph cluster.

Stefan