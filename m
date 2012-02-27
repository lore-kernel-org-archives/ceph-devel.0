From: Matt Weil <mweil@genome.wustl.edu>
Subject: ceph config without ctrfs
Date: Mon, 27 Feb 2012 17:18:56 -0600
Message-ID: <4F4C0F60.1070100@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:40909 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755341Ab2B0X0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 18:26:24 -0500
Received: from dhcp-10-0-108-185.gsc.wustl.edu (dhcp-10-0-108-185.gsc.wustl.edu [10.0.108.185])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id B180A40B47
	for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 17:18:56 -0600 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

How do you do this type of config (specifying multiple devices per 
server) on xfs not btrfs?

> [osd.1]
> 	host = linuscs92
> 	btrfs devs = /dev/cciss/c1d2
>
> [osd.2]
> 	host = linuscs92
> 	btrfs devs = /dev/cciss/c1d3
>
> [osd.3]
>         host = linuscs92
>         btrfs devs = /dev/cciss/c1d4
>
> [osd.4]
>         host = linuscs92
>         btrfs devs = /dev/cciss/c1d5
>
> [osd.5]
>         host = linuscs93
>         btrfs devs = /dev/cciss/c1d2
>
> [osd.6]
>         host = linuscs93
>         btrfs devs = /dev/cciss/c1d3
