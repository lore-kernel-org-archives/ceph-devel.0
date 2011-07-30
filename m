From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 19:36:12 +0300
Message-ID: <4E3432FC.9030204@ufm.su>
References: <4E33D101.1050504@ufm.su> <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:40221 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab1G3QgP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 12:36:15 -0400
In-Reply-To: <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
Cc: ceph-devel@vger.kernel.org

On 07/30/2011 06:34 PM, Theodore Tso wrote:
> On Jul 30, 2011, at 5:38 AM, Fyodor Ustinov wrote:
>
>> fail. Epic fail
>>
>> Inode 238551053, i_blocks is 24, should be 32.  Fix? yes
>>
>> Inode 238551054, i_blocks is 40, should be 32.  Fix? yes
>> ...
> Fyodor, what kernel were you using?  Was it a RHEL 6.x
> kernel, like Christian?
As it is written in subject - 3.0.0 release.

It's Ubuntu 11.04 with custom kernel

Linux osd0 3.0.0-ufm+ #1 SMP Fri Jul 22 12:34:13 EEST 2011 x86_64 x86_64 
x86_64 GNU/Linux


WBR,
     Fyodor.
