From: Brett Niver <bniver@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Wed, 30 Nov 2016 13:57:56 -0500
Message-ID: <CAMdDSN0kbQ-7MV05=iK6ee1k2QN0pYsggfDp0PaPqf2CGfk0kg@mail.gmail.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33063 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbcK3S56 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 13:57:58 -0500
Received: by mail-oi0-f52.google.com with SMTP id w63so241502025oiw.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 10:57:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Besides the obvious disk pull, I really like the option to dynamically
identify mappings.  Ive used a very similar concept on fabric switch
enclosures as part of visually verifying proper cabling and path
mapping...

On Wed, Nov 30, 2016 at 11:51 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> libstoragemgmt has made progress on a generic interface for twiddling
> enclosure LEDs!
>
>>      * RHEL 7.3 or Fedora 24+
>>      * sudo yum install libstoragemgmt
>>      * sudo lsmcli local-disk-ident-led-on --path /dev/sdX
>>      * sudo lsmcli local-disk-ident-led-off --path /dev/sdX
>>      * sudo lsmcli local-disk-fault-led-on --path /dev/sdX
>>      * sudo lsmcli local-disk-fault-led-off --path /dev/sdX
>
>> Python API document:
>>
>>      python2 -c'import lsm; help(lsm.LocalDisk.ident_led_on)'
>>      python2 -c'import lsm; help(lsm.LocalDisk.ident_led_off)'
>>      python2 -c'import lsm; help(lsm.LocalDisk.fault_led_on)'
>>      python2 -c'import lsm; help(lsm.LocalDisk.fault_led_off)'
>>
>> C API document:
>>
>>      Check header file `libstoragemgmt_local_disk.h` in
>>      `libstoragemgmt-devel` rpm package. The functions are:
>>
>>      lsm_local_disk_ident_led_on()
>>      lsm_local_disk_ident_led_off()
>>      lsm_local_disk_fault_led_on()
>>      lsm_local_disk_fault_led_off()
>
> Since this is in a reasonably usable state, I think It's time for us to
> figure out how we are going to do this in ceph.
>
> A few ideas:
>
>  ceph osd identify osd.123    # blink for a few seconds?
>
> or
>
>  ceph osd ident-led-on osd.123  # turn on
>  ceph osd ident-led-off osd.123  # turn off
>  ceph osd fault-led-on osd.123  # turn on
>  ceph osd fault-led-off osd.123  # turn off
>
> This would mean persistently recording the LED state in the OSDMap.  And
> it would mean ceph-osd is the one twiddling the LEDs.  But that might not
> be the way to go in all cases.  For example, if we have an OSD that fails,
> once we confirm that we've healed (and don't need that OSDs data) we'd
> probably want to set the fault light so that the disk can be pulled
> safely.  In that case, ceph-osd isn't running (it's long-since failed),
> and we'd need some other agent on the node to twiddle the light.  Do we
> really want multiple things twiddling lights?
>
> We also often have a N:M mapping of osds to devices (multiple devices per
> OSD, multiple OSDs per device), which means a per-OSD flag might not be
> the right way to think about this anyway.
>
> Has anyone thought this through yet?
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
