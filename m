From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: osd dies / crahes directly after mkcephfs
Date: Fri, 15 Jun 2012 23:50:04 +0200
Message-ID: <4FDBAE0C.6010606@profihost.ag>
References: <4FDBA78C.4050401@profihost.ag> <Pine.LNX.4.64.1206151445290.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58766 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab2FOVuD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 17:50:03 -0400
In-Reply-To: <Pine.LNX.4.64.1206151445290.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 23:46, schrieb Sage Weil:
> On Fri, 15 Jun 2012, Stefan Priebe wrote:
>> Hi,
>>
>> i've seen several osd crashes on one of my machines directly after creating
>> the ceph fs.
>>
>> Attached is the osd log. I also have a core dump file. Do you need it?
>
> Also, are you mounting the ceph file system on the same node as the osd?
> This might be a sync(2)-induced deadlock.
No i use only rados / rbd and in this case i have never used the fs at 
all as it has happened directly after mkcephfs and -a start. So i didn't 
even had the chance.

> Putting a ceph fs mount on the same node as an osd is dicey in low memory
> situations.  On older glibcs and kernels without syncfs(2) support, it can
> easily deadlock.
Even this does not apply i have syncfs.

my send log shows: mount syncfs(2) syscall fully supported (by glibc and 
kernel)

Stefan
