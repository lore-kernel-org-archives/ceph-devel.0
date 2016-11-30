From: Sage Weil <sweil@redhat.com>
Subject: disk enclosure LEDs
Date: Wed, 30 Nov 2016 16:51:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755213AbcK3Qv4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 11:51:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 486328F515
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 16:51:56 +0000 (UTC)
Received: from ovpn-112-118.phx2.redhat.com (ovpn-112-118.phx2.redhat.com [10.3.112.118])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uAUGpsi6003490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 11:51:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

libstoragemgmt has made progress on a generic interface for twiddling 
enclosure LEDs!

>      * RHEL 7.3 or Fedora 24+
>      * sudo yum install libstoragemgmt
>      * sudo lsmcli local-disk-ident-led-on --path /dev/sdX
>      * sudo lsmcli local-disk-ident-led-off --path /dev/sdX
>      * sudo lsmcli local-disk-fault-led-on --path /dev/sdX
>      * sudo lsmcli local-disk-fault-led-off --path /dev/sdX

> Python API document:
> 
>      python2 -c'import lsm; help(lsm.LocalDisk.ident_led_on)'
>      python2 -c'import lsm; help(lsm.LocalDisk.ident_led_off)'
>      python2 -c'import lsm; help(lsm.LocalDisk.fault_led_on)'
>      python2 -c'import lsm; help(lsm.LocalDisk.fault_led_off)'
> 
> C API document:
> 
>      Check header file `libstoragemgmt_local_disk.h` in
>      `libstoragemgmt-devel` rpm package. The functions are:
> 
>      lsm_local_disk_ident_led_on()
>      lsm_local_disk_ident_led_off()
>      lsm_local_disk_fault_led_on()
>      lsm_local_disk_fault_led_off()

Since this is in a reasonably usable state, I think It's time for us to 
figure out how we are going to do this in ceph.

A few ideas:

 ceph osd identify osd.123    # blink for a few seconds?

or

 ceph osd ident-led-on osd.123  # turn on
 ceph osd ident-led-off osd.123  # turn off
 ceph osd fault-led-on osd.123  # turn on
 ceph osd fault-led-off osd.123  # turn off

This would mean persistently recording the LED state in the OSDMap.  And 
it would mean ceph-osd is the one twiddling the LEDs.  But that might not 
be the way to go in all cases.  For example, if we have an OSD that fails, 
once we confirm that we've healed (and don't need that OSDs data) we'd 
probably want to set the fault light so that the disk can be pulled 
safely.  In that case, ceph-osd isn't running (it's long-since failed), 
and we'd need some other agent on the node to twiddle the light.  Do we 
really want multiple things twiddling lights?

We also often have a N:M mapping of osds to devices (multiple devices per 
OSD, multiple OSDs per device), which means a per-OSD flag might not be 
the right way to think about this anyway.

Has anyone thought this through yet?

Thanks!
sage
