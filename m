From: Loic Dachary <loic@dachary.org>
Subject: crush devices class types
Date: Sun, 22 Jan 2017 17:44:11 +0100
Message-ID: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44948 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAVQpt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jan 2017 11:45:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

You proposed an improvement to the crush map to address different device types (SSD, HDD, etc.)[1]. When learning how to create a crush map, I was indeed confused by the tricks required to create SSD only pools. After years of practice it feels more natural :-)

The source of my confusion was mostly because I had to use a hierarchical description to describe something that is not organized hierarchically. "The rack contains hosts that contain devices" is intuitive. "The rack contains hosts that contain ssd that contain devices" is counter intuitive. Changing:

    # devices
    device 0 osd.0
    device 1 osd.1
    device 2 osd.2
    device 3 osd.3

into:

    # devices
    device 0 osd.0 ssd
    device 1 osd.1 ssd
    device 2 osd.2 hdd
    device 3 osd.3 hdd

where ssd/hdd is the device class would be much better. However, using the device class like so:

    rule ssd {
            ruleset 1
            type replicated
            min_size 1
            max_size 10
            step take default:ssd
            step chooseleaf firstn 0 type host
            step emit
    }

looks arcane. Since the goal is to simplify the description for the first time user, maybe we could have something like:

    rule ssd {
            ruleset 1
            type replicated
            min_size 1
            max_size 10
            device class = ssd
            step take default
            step chooseleaf firstn 0 type host
            step emit
    }

What do you think ?

Cheers

[1] http://pad.ceph.com/p/crush-types http://tracker.ceph.com/projects/ceph/wiki/CDM_01-FEB-2017

-- 
Loïc Dachary, Artisan Logiciel Libre
