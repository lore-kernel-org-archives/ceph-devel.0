From: Sagi Grimberg <sagig@dev.mellanox.co.il>
Subject: Re: [PATCH 12/18] target: compare and write backend driver sense
 handling
Date: Sun, 6 Sep 2015 09:38:08 +0300
Message-ID: <55EBDF50.9090006@dev.mellanox.co.il>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
 <1438161835-27960-12-git-send-email-mchristi@redhat.com>
 <55E9F3DC.1010404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34498 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbIFGhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Sep 2015 02:37:55 -0400
Received: by wicfx3 with SMTP id fx3so57730744wic.1
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2015 23:37:54 -0700 (PDT)
In-Reply-To: <55E9F3DC.1010404@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

On 9/4/2015 10:41 PM, Mike Christie wrote:
> Hey Nick and Christoph,

Hi Mike,

>
> For the target_core_iblock + rbd/COMPARE_AND_WRITE support approach, I
> still need a patch like below to be able to allow target_core_iblock.c
> to be able to specify specific codes like TCM_MISCOMPARE_VERIFY.

I just posted a couple of patches to use scsi helpers to set the
sense buffer with/without information (see translate_sense_reason).
You can just add TCM_MISCOMPARE_VERIFY entry to sense_info_table with
.add_sector_info = true.

Moreover, we have a field in the command structure to keep the error
sector (used in DIF). So you should go ahead and use that.

Sagi.
