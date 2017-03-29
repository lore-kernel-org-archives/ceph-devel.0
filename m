From: Forumulator V <forumulator@gmail.com>
Subject: RGW zones and admin ops
Date: Wed, 29 Mar 2017 09:33:53 +0530
Message-ID: <CAN1NP8h0h8Vo-EpjbmWSYg_L3G3KpCGfFUPBMJ=Crno3CgUW6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34637 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdC2EDz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 00:03:55 -0400
Received: by mail-vk0-f42.google.com with SMTP id z204so4351919vkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 21:03:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was going through the RGW code, and couldn't understand a few parts.

i.) Where is zones and zonegroup information stored(on the backend)?
Also do all RGW instances in a zone store objects on the same object
storage cluster?

ii.) What do zones and zonegroups really correspond to? Are they like
regions in S3?

iii.) Where are the users and their metadata stored? Is it also on the backend?


I'm sure the answers are there in the code, I understood some of it
but not these parts.

Thanks,
Pranjal
