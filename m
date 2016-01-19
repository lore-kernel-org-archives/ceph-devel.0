From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Wed, 20 Jan 2016 00:55:49 +0800
Message-ID: <CACJqLyb=W5XSY8V98LSdpFhp+e_jCe2hV+KcDGTmWRBEid3g2w@mail.gmail.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
	<CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com>
	<alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36236 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbcASQzu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 11:55:50 -0500
Received: by mail-io0-f182.google.com with SMTP id g73so395842892ioe.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 08:55:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 20, 2016 at 12:46 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 19 Jan 2016, Haomai Wang wrote:
>> On Tue, Jan 19, 2016 at 11:15 PM, Sage Weil <sweil@redhat.com> wrote:
>>       I think we should add an optional 'config' file location to the
>>       config
>>       search path.  This would allow you to put customized options for
>>       an
>>       individual daemon in the daemon data directory.  Or, you could
>>       avoid
>>       putting a config in /etc/ceph entirely, so that the daemon data
>>       is
>>       completely self-contained on the device.  That would streamline
>>       boot disk
>>       failure (just reinstall OS and ceph package) or drive swaps
>>       between failed
>>       host hardware.
>>
>>       What do you think?
>>
>>
>> Totally agreed!
>>
>> Actually we have implemented alike thing downstream, ceph-osd,ceph-mon will
>> check ceph.conf in the local dir(/var/lib/ceph/*/*/ceph.conf) then overwrite
>> existing config values. That's said, it will load system ceph
>> config(/etc/ceph/ceph.conf) file then load local ceph.conf.
>
> The one reservation about this direction is that there are a few devices
> where I'm not sure how to attach the metadata (keyring, conf, and other
> random bits in the osd_data dir) to the device: the SPDK NVMe driver, and
> kinetic.  These are somewhat obscure, but I'm curious if there are other
> ideas floating around about how this should be approached...

Just like BlueStore::_write_bdev_label, I think it should use
BlockDevice::raw_write api which is used to record system metadata
instead of bufferlist::write_fd. So keyring, conf and others could be
reserved at the first section?

But it may exists dependence loop, if we want to read
config/keyring/device_info from osd, we need to know non-kernel device
info at first then we can attach this and do reading.

A possible solution is that we could recover info from non-kernel
device. For example, we still store osd info at os
directory(/var/lib/ceph/osd/ceph-0), but we will write these into
device(including kernel or non-kernel), if os disk failed, we could
use ceph-device-scan tool to discover this and extract necessary info
from this disk into the active os directory?

>
> sage



-- 
Best Regards,

Wheat
