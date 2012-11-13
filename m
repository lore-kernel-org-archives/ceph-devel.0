From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: optmize librbd for iops
Date: Mon, 12 Nov 2012 23:51:48 -0800
Message-ID: <50A1FC14.3010007@inktank.com>
References: <50A0FE96.9030708@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62936 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab2KMHvv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 02:51:51 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4872895pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 23:51:51 -0800 (PST)
In-Reply-To: <50A0FE96.9030708@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/12/2012 05:50 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> are there any plans to optimize librbd for iops? Right now i'm able to
> get 50.000 iop/s via iscsi and 100.000 iop/s using multipathing with iscsi.
>
> With librbd i'm stuck to around 18.000iops. As this scales with more
> hosts but not with more disks in a vm. It must be limited by rbd
> implementation in kvm / librbd.

It'd be interesting to see which layers are most limiting in this
case - qemu/kvm, librados, or librbd.

How does rados bench with 4k writes and then 4k reads with many
concurrent IOs do?

Unfortunately there's no librbd read benchmark yet.

Josh

