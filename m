From: Gregory Farnum <greg@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Thu, 5 Jul 2012 14:33:18 -0700
Message-ID: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro>
	<4FF13BEB.8080906@profihost.ag>
	<CAPYLRzinbjLOhNJeYRq99gu9bLom6jkZOh5Z+taSDf0DGJ_ACw@mail.gmail.com>
	<4FF1F4F6.4030403@profihost.ag>
	<4FF204DB.80709@inktank.com>
	<4FF2A3FE.7090205@profihost.ag>
	<Pine.LNX.4.64.1207030828240.27608@cobra.newdream.net>
	<4FF337F4.8020004@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34554 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab2GEVdU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 17:33:20 -0400
Received: by lbbgm6 with SMTP id gm6so13543707lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 14:33:19 -0700 (PDT)
In-Reply-To: <4FF337F4.8020004@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

Could you send over the ceph.conf on your KVM host, as well as how
you're configuring KVM to use rbd?

On Tue, Jul 3, 2012 at 11:20 AM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> I'm sorry but this is the KVM Host Machine there is no ceph running o=
n this
> machine.
>
> If i change the admin socket to:
> admin_socket=3D/var/run/ceph_$name.sock
>
> i don't have any socket at all ;-(
>
> Am 03.07.2012 17:31, schrieb Sage Weil:
>
>> On Tue, 3 Jul 2012, Stefan Priebe - Profihost AG wrote:
>>>
>>> Hello,
>>>
>>> Am 02.07.2012 22:30, schrieb Josh Durgin:
>>>>
>>>> If you add admin_socket=3D/path/to/admin_socket for your client ru=
nning
>>>> qemu (in that client's ceph.conf section or manually in the qemu
>>>> command line) you can check that caching is enabled:
>>>>
>>>> ceph --admin-daemon /path/to/admin_socket show config | grep rbd_c=
ache
>>>>
>>>> And see statistics it generates (look for cache) with:
>>>>
>>>> ceph --admin-daemon /path/to/admin_socket perfcounters_dump
>>>
>>>
>>> This doesn't work for me:
>>> ceph --admin-daemon /var/run/ceph.sock show config
>>> read only got 0 bytes of 4 expected for response length; invalid
>>> command?2012-07-03 09:46:57.931821 7fa75d129700 -1 asok(0x8115a0)
>>> AdminSocket:
>>> request 'show config' not defined
>>
>>
>> Oh, it's 'config show'. =A0Also, 'help' will list the supported comm=
ands.
>>
>>> Also perfcounters does not show anything:
>>> # ceph --admin-daemon /var/run/ceph.sock perfcounters_dump
>>> {}
>>
>>
>> There may be another daemon that tried to attach to the same socket =
file.
>> You might want to set 'admin socket =3D /var/run/ceph/$name.sock' or
>> something similar, or whatever else is necessary to make it a unique=
 file.
>>
>>> ~]# ceph -v
>>> ceph version 0.48argonaut-2-gb576faa
>>> (commit:b576faa6f24356f4d3ec7205e298d58659e29c68)
>>
>>
>> Out of curiousity, what patches are you applying on top of the relea=
se?
>>
>> sage
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
