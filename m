From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: broken init script under debian squeeze
Date: Tue, 22 May 2012 21:33:41 +0200
Message-ID: <4FBBEA15.2080900@profihost.ag>
References: <4FBB64EF.70402@profihost.ag> <CAC-hyiHp9e6NKXAfaYfirX_E2A3O2XRmLT7nDSOnwxjbKRwT6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53762 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2EVTdn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:33:43 -0400
In-Reply-To: <CAC-hyiHp9e6NKXAfaYfirX_E2A3O2XRmLT7nDSOnwxjbKRwT6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 22.05.2012 18:08, schrieb Yehuda Sadeh:
> On Tue, May 22, 2012 at 3:05 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag>  wrote:
>> Hi,
>>
>> the ceph init script seems to be broken - at least under debian lenny.
>>
>> It does simply nothing on a configured osd / mon server, so while system
>> start the daemons won't start. Ow do i have to configure the hostname to
>> match anything special in ceph.conf?
>> [root@system123 /etc]# /etc/init.d/ceph start
>> [root@system123 /etc]#
>>
>> option -a works fine (/etc/init.d/ceph -a start)
>>
>
> My guess is that you're missing 'host =<hostname>' entry under the
> relevant osd and mon sections in your ceph.conf.
no example:

[osd.0]
         host= stor1

but the system has

/etc/hosts:
192.168.0.10 server123 abc.xyz.de
10.0.255.10 stor1

Stefan
