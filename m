From: Loic Dachary <loic@dachary.org>
Subject: Re: question about global activate_lock in ceph-disk
Date: Thu, 5 Jan 2017 14:49:18 +0100
Message-ID: <f5c2def8-e34d-6942-cfe0-497b659c901f@dachary.org>
References: <8917B54C-BCF8-40F8-BFAF-BD2A12AFA044@xsky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58706 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbdAENte (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2017 08:49:34 -0500
In-Reply-To: <8917B54C-BCF8-40F8-BFAF-BD2A12AFA044@xsky.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: guojian@xsky.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

[cc'ing ceph-devel so others can benefit from the answer]

Hi,

You are correct, there is no need for a global lock for something like:

ceph-disk activate /dev/sda1 & ceph-disk activate /dev/sdb1

when the journal (or bluestore auxiliary partitions) are collocated with the data on the same disk. However, if both sda1 and sdb1 are using a journal on sdc, activating them in parallel means they will both operate on sdc in parallel. Although it should be fine most of the time, there may be race conditions because this has never been tested.

Over the past year ceph-disk and the boot sequence has improved and all known race conditions have been diagnosed and fixed (the last one dated month ago http://tracker.ceph.com/issues/17889). Although the fix was very simple, it was tricky to diagnose.

In other words, the global lock is a conservative approach to avoid race conditions and it could be replaced by a OSD specific lock in some cases. It could also be replaced by an OSD specific lock in all cases after it has been extensively tested.

Cheers

On 01/05/2017 12:12 PM, 邵国健 wrote:
> Hi Loic,
> 
> I found that there are global locks for preparing and activating osd in ceph-disk: prepare_lock, activate_lock at https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L260
> I can’t find out why we need global lock for all osds since it cannot make activating different osds at the same time in parallel, is it better to use lock for each osd? for example, if we have 10 osds, there are 10 activate_locks.
> 
> It would be appreciated if you could give some help at your convenience.
> —————————
> Thanks,
> Guojian

-- 
Loïc Dachary, Artisan Logiciel Libre
