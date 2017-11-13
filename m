From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: decompiled crushmap device list after removing osd
Date: Mon, 13 Nov 2017 15:12:32 +0100
Message-ID: <20171113141232.dm3stov7lep7hqkf@jf_suse_laptop>
References: <20171107144658.crbrv6sxidvyuay2@jf_suse_laptop>
 <alpine.DEB.2.11.1711071940140.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44320 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbdKMPGb (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 13 Nov 2017 10:06:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1711071940140.29217@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 07, 2017 at 07:41:53PM +0000, Sage Weil wrote:
>On Tue, 7 Nov 2017, Jan Fajerski wrote:
>> Hi,
>> I noticed some weird behaviour of crushtool when decompiling a map after an
>> osd has been removed. Say I have a cluster with 4 osds. When I remove osd.2,
>> get and decompile the crushmap, I get this device list in the crushmap:
>>
>> # devices
>> device 0 osd.0 class hdd
>> device 1 osd.1 class hdd
>> device 2 device2
>> device 3 osd.3 class hdd
>>
>> I'd appreciate some info on whether this is intended behaviour and what the
>> reasoning is. I'd expect the map not to list id 2 at all and afaict the
>> crushmap doesn't contain the id anymore. If there is no reason for listing
>> that I'd be happy to make a PR.
>
>There's no good rason to print it.  It comes from
>
>  out << "\n# devices\n";
>  for (int i=0; i<crush.get_max_devices(); i++) {
>    out << "device " << i << " ";
>    print_item_name(out, i, crush);
>    print_item_class(out, i, crush);
>    out << "\n";
>  }
>
>There isn't a convenient way at this point to know whether the device is
>used in the hierarchy, so exclusing it is a bit of a hassle.  Happy to
>take a PR doing so, though!
https://github.com/ceph/ceph/pull/18901
>
>sage
>
>

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
