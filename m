From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 16:25:34 +0100
Message-ID: <50CB44EE.7040709@profihost.ag>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de> <50CB3F32.2070106@inktank.com> <50CB41BE.8020300@profihost.ag> <50CB43D8.3020603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58645 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab2LNPZg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:25:36 -0500
In-Reply-To: <50CB43D8.3020603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

Am 14.12.2012 16:20, schrieb Mark Nelson:
> sudo parted -s -a optimal /dev/$DEV mklabel gpt
> sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-journal 0% 10G
> sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-data 10G 100%

My disks are gpt too and i'm also using parted. But i don't want to 
recreate my partitions. I haven't seen a way in parted to set such a 
label later.

Greets,
Stefan
