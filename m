From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Can't start Ceph with CentOS 5.6
Date: Thu, 14 Apr 2011 12:24:42 +0200
Message-ID: <4DA6CB6A.60106@provocation.net>
References: <4DA69AB6.9050508@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:48142 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1DNKYq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 06:24:46 -0400
In-Reply-To: <4DA69AB6.9050508@science-computing.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/14/2011 08:56 AM, Christoph Raible wrote:

> ...i want to start ceph with  /etc/init.d/ceph -a start  oder service 
> ceph -a start   but the service is unknown and in /etc/init.d  there 
> is noch such file!

You will find it in the sources, src/init-ceph. Copy it to /etc/init.d/ceph
or /etc/rc.d/init.d/ceph and register it if need be with chkconfig -add ceph.

Note that you can build rpm and deb packages directly from the source and
they put stuff automatically where it belongs, depending on your distro.

Z

