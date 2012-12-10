From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Errors attaching RBD image to a running VM
Date: Mon, 10 Dec 2012 13:12:45 -0800
Message-ID: <50C6504D.8090307@inktank.com>
References: <20121207212247.GA12635@staff.dca.net> <50C272A0.9020506@inktank.com> <20121210204850.GC22300@staff.dca.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37942 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2LJVNG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 16:13:06 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2172145pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 13:13:06 -0800 (PST)
In-Reply-To: <20121210204850.GC22300@staff.dca.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Morgan <mmorgan@dca.net>
Cc: ceph-devel@vger.kernel.org

On 12/10/2012 12:48 PM, Michael Morgan wrote:
> On Fri, Dec 07, 2012 at 02:50:08PM -0800, Josh Durgin wrote:
>> Yes, this is fixed in libvirt 0.9.12. There were a couple issues with
>> properly escaping JSON and using a space instead of a semicolon with
>> qemu's command parsing.
>>
>> There are a couple more rbd-related bug fixes in later versions of
>> libvirt, but you wouldn't hit those problems using OpenStack.
>
> Thanks Josh! After building and installing libvirt 1.0.0 RPMs I unfortunately
> seem to have taken a step backwards. Any use of network disks with
> protocol="rbd" causes libvirt to bail with a dreaded 'No such file or
> directory':
>
> 2012-12-10 20:08:37.203+0000: 16691: error : virFileOpenAs:1077 : failed to open file 'volumes/volume-485390a9-5a39-46c1-8434-872acbc645d8': No such file or directory
> 2012-12-10 20:08:37.203+0000: 16691: error : virStorageFileGetMetadataRecurse:962 : cannot open file 'volumes/volume-485390a9-5a39-46c1-8434-872acbc645d8': No such file or directory

There was a regression in 1.0.0 with attaching non-files, such as RBD.
This is fixed by f0e72b2f5c675f927d04545dc5095f9e5998f171, which you
could cherry-pick onto 1.0.0.

If you'd rather just use a released version, 0.10.2 should be fine.

> I see there is a specific flag in the spec file for RBD support in this version
> but I'm assuming that's more for pool support, correct?

Yes, --with-storage-rbd is just for using rbd as a backend for libvirt
pools.

Josh
