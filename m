From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Tue, 03 Jul 2012 09:49:18 +0200
Message-ID: <4FF2A3FE.7090205@profihost.ag>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro> <4FF13BEB.8080906@profihost.ag> <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com> <4FF1F4F6.4030403@profihost.ag> <4FF204DB.80709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45412 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab2GCHtV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 03:49:21 -0400
In-Reply-To: <4FF204DB.80709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Hello,


Am 02.07.2012 22:30, schrieb Josh Durgin:
> If you add admin_socket=/path/to/admin_socket for your client running
> qemu (in that client's ceph.conf section or manually in the qemu
> command line) you can check that caching is enabled:
>
> ceph --admin-daemon /path/to/admin_socket show config | grep rbd_cache
>
> And see statistics it generates (look for cache) with:
>
> ceph --admin-daemon /path/to/admin_socket perfcounters_dump

This doesn't work for me:
ceph --admin-daemon /var/run/ceph.sock show config
read only got 0 bytes of 4 expected for response length; invalid 
command?2012-07-03 09:46:57.931821 7fa75d129700 -1 asok(0x8115a0) 
AdminSocket: request 'show config' not defined

Also perfcounters does not show anything:
# ceph --admin-daemon /var/run/ceph.sock perfcounters_dump
{}

~]# ceph -v
ceph version 0.48argonaut-2-gb576faa 
(commit:b576faa6f24356f4d3ec7205e298d58659e29c68)

Stefan
