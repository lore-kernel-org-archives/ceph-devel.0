From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 16:11:58 +0100
Message-ID: <50CB41BE.8020300@profihost.ag>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de> <50CB3F32.2070106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33006 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524Ab2LNPMB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:12:01 -0500
In-Reply-To: <50CB3F32.2070106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

but do i set a label for a partition without FS like the journal blockdev?
Am 14.12.2012 16:01, schrieb Mark Nelson:
> I often map partitions to something in /dev/disk/by-partlabel and use
> those in my ceph.conf files.  that way disks can be remapped behind the
> scenes and the ceph configuration doesn't have to change even if disks
> get replaced.

Greets,
Stefan
