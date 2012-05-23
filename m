From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Wed, 23 May 2012 00:33:54 -0700
Message-ID: <4FBC92E2.5020807@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com> <4FBBFE7B.4060406@profihost.ag> <65E9589544C4489F93761035433ADC01@inktank.com> <4FBC811F.5060004@profihost.ag> <4FBC83F3.7070400@inktank.com> <4FBC8B41.1020300@profihost.ag> <4FBC8F8F.6060004@inktank.com> <4FBC904A.7090407@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61221 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab2EWHd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 03:33:56 -0400
Received: by dady13 with SMTP id y13so9362803dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 00:33:56 -0700 (PDT)
In-Reply-To: <4FBC904A.7090407@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 05/23/2012 12:22 AM, Stefan Priebe - Profihost AG wrote:
> Am 23.05.2012 09:19, schrieb Josh Durgin:
>> On 05/23/2012 12:01 AM, Stefan Priebe - Profihost AG wrote:
>> You can use any of the rbd-specific options (like rbd_cache_max_dirty)
>> with qemu>= 0.15.
>>
>> You can set them in a global ceph.conf file, or specify them on the qemu
>> command line like:
>>
>> qemu -m 512 -drive
>> file=rbd:pool/image:rbd_cache_max_dirty=0:rbd_cache=true,format=raw,if=virtio
> ah thanks and sorry. Is there a way to verify which options are active /
> working on a specific rbd block device?

There's no way to ask which options it's using while it's running. That
would probably be a good thing to add (maybe as an admin socket
command).

Until then, if you want to know the exact settings of all your rbd
disks, you can specify all the necessary options on the qemu command
line, and not have a ceph.conf file.

Josh
