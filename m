From: tsk <aixt2006@gmail.com>
Subject: How to deal with a single host with several harddisks
Date: Wed, 4 May 2011 17:37:28 +0800
Message-ID: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39007 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1EDJh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 05:37:29 -0400
Received: by wya21 with SMTP id 21so683487wya.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 02:37:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,


May I know that,  if there is 6 harddisk available for btrfs in just a
single host,  there should be 6 cosd process in the host when the
disks are all working?

A single cosd process can not manage several disks?

How should the ceph.conf be configured for this scenario?


Thx!
