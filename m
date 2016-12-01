From: John Spray <jspray@redhat.com>
Subject: Re: disk enclosure LEDs
Date: Thu, 1 Dec 2016 00:10:55 +0000
Message-ID: <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34987 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbcLAALR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 19:11:17 -0500
Received: by mail-qk0-f177.google.com with SMTP id n204so228292729qke.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 16:11:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 30, 2016 at 4:51 PM, Sage Weil <sweil@redhat.com> wrote:
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

My preferences is to keep this as lightweight as possible and keeping
it in `tell` commands that the OSD can pass through almost completely
directly to libstoragemgmt.  This could include "fault on", "fault
off" and "blink"/"identify, but without putting any persistent state
in there: if you stopped ceph-osd the blinking would stop (but a
toggled fault light would stay on).  Using tell commands would also
make it straightforward to get an error back if the OSD can't identify
a device to blink an LED on, instead of setting something in the OSD
map and then wondering why nothing blinks.

The "what block device am I?" part in the OSD (especially given
many-to-one relations as you say) is probably harder than the calling
into libstoragemgmt.  We would probably also need all the LED commands
to have a flag to optionally target the journal drive instead of the
data drive.  Where multiple OSDs target the same drive, I don't see
that as a problem: it's reasonable to have the commands me "blink the
drive you use" and not "blink a drive and thereby claim you are the
only thing using it".

John

>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
