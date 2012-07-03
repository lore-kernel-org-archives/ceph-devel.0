From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Tue, 03 Jul 2012 20:20:36 +0200
Message-ID: <4FF337F4.8020004@profihost.ag>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro> <4FF13BEB.8080906@profihost.ag> <CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com> <4FF1F4F6.4030403@profihost.ag> <4FF204DB.80709@inktank.com> <4FF2A3FE.7090205@profihost.ag> <Pine.LNX.4.64.1207030828240.27608@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60855 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2GCSUj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 14:20:39 -0400
In-Reply-To: <Pine.LNX.4.64.1207030828240.27608@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Gregory Farnum <greg@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

I'm sorry but this is the KVM Host Machine there is no ceph running on 
this machine.

If i change the admin socket to:
admin_socket=/var/run/ceph_$name.sock

i don't have any socket at all ;-(

Am 03.07.2012 17:31, schrieb Sage Weil:
> On Tue, 3 Jul 2012, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> Am 02.07.2012 22:30, schrieb Josh Durgin:
>>> If you add admin_socket=/path/to/admin_socket for your client running
>>> qemu (in that client's ceph.conf section or manually in the qemu
>>> command line) you can check that caching is enabled:
>>>
>>> ceph --admin-daemon /path/to/admin_socket show config | grep rbd_cache
>>>
>>> And see statistics it generates (look for cache) with:
>>>
>>> ceph --admin-daemon /path/to/admin_socket perfcounters_dump
>>
>> This doesn't work for me:
>> ceph --admin-daemon /var/run/ceph.sock show config
>> read only got 0 bytes of 4 expected for response length; invalid
>> command?2012-07-03 09:46:57.931821 7fa75d129700 -1 asok(0x8115a0) AdminSocket:
>> request 'show config' not defined
>
> Oh, it's 'config show'.  Also, 'help' will list the supported commands.
>
>> Also perfcounters does not show anything:
>> # ceph --admin-daemon /var/run/ceph.sock perfcounters_dump
>> {}
>
> There may be another daemon that tried to attach to the same socket file.
> You might want to set 'admin socket = /var/run/ceph/$name.sock' or
> something similar, or whatever else is necessary to make it a unique file.
>
>> ~]# ceph -v
>> ceph version 0.48argonaut-2-gb576faa
>> (commit:b576faa6f24356f4d3ec7205e298d58659e29c68)
>
> Out of curiousity, what patches are you applying on top of the release?
>
> sage
>

