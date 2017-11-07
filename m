From: Sage Weil <sage@newdream.net>
Subject: Re: decompiled crushmap device list after removing osd
Date: Tue, 7 Nov 2017 19:41:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711071940140.29217@piezo.novalocal>
References: <20171107144658.crbrv6sxidvyuay2@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:34830 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdKGTl5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 14:41:57 -0500
In-Reply-To: <20171107144658.crbrv6sxidvyuay2@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Fajerski <jfajerski@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 7 Nov 2017, Jan Fajerski wrote:
> Hi,
> I noticed some weird behaviour of crushtool when decompiling a map after an
> osd has been removed. Say I have a cluster with 4 osds. When I remove osd.2,
> get and decompile the crushmap, I get this device list in the crushmap:
> 
> # devices
> device 0 osd.0 class hdd
> device 1 osd.1 class hdd
> device 2 device2
> device 3 osd.3 class hdd
> 
> I'd appreciate some info on whether this is intended behaviour and what the
> reasoning is. I'd expect the map not to list id 2 at all and afaict the
> crushmap doesn't contain the id anymore. If there is no reason for listing
> that I'd be happy to make a PR.

There's no good rason to print it.  It comes from

  out << "\n# devices\n";
  for (int i=0; i<crush.get_max_devices(); i++) {
    out << "device " << i << " ";
    print_item_name(out, i, crush);
    print_item_class(out, i, crush);
    out << "\n";
  }
  
There isn't a convenient way at this point to know whether the device is 
used in the hierarchy, so exclusing it is a bit of a hassle.  Happy to 
take a PR doing so, though!

sage

