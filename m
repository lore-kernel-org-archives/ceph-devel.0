From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: osd dies / crahes directly after mkcephfs
Date: Fri, 15 Jun 2012 23:47:41 +0200
Message-ID: <4FDBAD7D.6050707@profihost.ag>
References: <4FDBA78C.4050401@profihost.ag> <Pine.LNX.4.64.1206151444550.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57353 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab2FOVrj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 17:47:39 -0400
In-Reply-To: <Pine.LNX.4.64.1206151444550.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 23:45, schrieb Sage Weil:
> On Fri, 15 Jun 2012, Stefan Priebe wrote:
>> Hi,
>>
>> i've seen several osd crashes on one of my machines directly after creating
>> the ceph fs.
>>
>> Attached is the osd log. I also have a core dump file. Do you need it?
>
> This happens when the underlying file system isn't responding.  Does
> 'dmesg' include any kernel errors or warnings?

no last lines:
[117189.774948] XFS (sde1): Mounting Filesystem
[117189.799705] XFS (sde1): Ending clean mount

Stefan
