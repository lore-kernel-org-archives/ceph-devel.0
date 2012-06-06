From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] ceph.spec.in: Fix license to GPL-2.0 and use SPDX format
Date: Wed, 06 Jun 2012 10:04:40 +0200
Message-ID: <4FCF0F18.6010104@suse.de>
References: <4FCE0309.90104@suse.de> <Pine.LNX.4.64.1206051928360.5946@cobra.newdream.net>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53837 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2FFIEp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jun 2012 04:04:45 -0400
In-Reply-To: <Pine.LNX.4.64.1206051928360.5946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 04:29 AM, Sage Weil wrote:
> On Tue, 5 Jun 2012, Holger Macht wrote:
>> Minor spec file fix. LGPLv2 in spec file is not correct, because some of
>> the included packages/binaries are GPLv2. For example:
>>
>>  src/os/btrfs_ioctl.h -> package ceph, binary ceph-osd
> 
> My understanding is that including a header file (in this case, to get the 
> ioctl number) does not create a derivative work.  Is that incorrect?

Guess not, at least from FSF's point of view [1]. I just listed it
because our legal team listed it, maybe even via automation. Without
looking, there might be other headers from which more (or even real)
code is included, though.

>>  src/mount/mtab.c     -> package ceph, binary mount.ceph
>>  src/common/fiemap.cc -> package ceph, binary rbd
>>
>> Also use SPDX format: http://www.spdx.org/licenses
>>
>> Signed-off-by: Holger Macht <hmacht@suse.de>
>> ---
>>  ceph.spec.in |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ceph.spec.in b/ceph.spec.in
>> index 81e7040..3b3026d 100644
>> --- a/ceph.spec.in
>> +++ b/ceph.spec.in
>> @@ -17,7 +17,7 @@ Name:		ceph
>>  Version:	@VERSION@
>>  Release:	6%{?dist}
>>  Summary:	User space components of the Ceph file system
>> -License:	LGPLv2
>> +License:	GPL-2.0
> 
> So this is effectively the most restrictive license in the package?

This specific change is only about the base package, what is called
ceph-common in deb-based and just ceph in rpm-based distributions.

However, while I'm at it, I'll change the licenses for the other
subpackages to SPDX format accordingly and send a new patch. Otherwise
I'd like to keep this commit separate from other spec file fixes to
preserve the rationale behind it.

Regards Holger

[1] http://lkml.indiana.edu/hypermail/linux/kernel/0301.1/0362.html
