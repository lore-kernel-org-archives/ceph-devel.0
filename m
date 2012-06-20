From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 18:46:30 +0200
Message-ID: <0421100E-E107-4F83-B554-D7894E67EA28@profihost.ag>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl> <4FE195DE.50108@profihost.ag> <CADvuQRHGoXx4aMMfvyYeLpVKp2Vh7kyzZ1qWjhBSfrs8AMasTQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34436 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2FTQqf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 12:46:35 -0400
In-Reply-To: <CADvuQRHGoXx4aMMfvyYeLpVKp2Vh7kyzZ1qWjhBSfrs8AMasTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 20.06.2012 um 18:39 schrieb Tommi Virtanen <tv@inktank.com>:

> On Wed, Jun 20, 2012 at 2:20 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>> What does hostname | cut -d . -f 1 say?
>> 
>> It says ssdstor000i as the machine defaults to it's public IP.
>> 
>> Whouldn't it make sense to go through all aliases set in /etc/hosts which
>> point to a local IP?
> 
> Actually, the short hostname of the machine is completely unrelated to
> what IP addresses etc it has. The hostname is a configurable string.
> We treat it as such -- it's just expected to be a unique identifier
> for the host.
> 
> There's no nice, reliable way to look up aliases that point to a local
> IP. /etc/hosts is meant to be accessed through a library that also
> uses DNS, and you really don't want to tie your daemon startup to DNS
> availability and functioning.

Correct. So i should just change the /etc/hostname to the name that points to the internal ip via hosts file?