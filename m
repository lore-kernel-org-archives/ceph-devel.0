From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 16:02:15 +0100
Message-ID: <50CB3F77.5010503@profihost.ag>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38269 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876Ab2LNPCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:02:17 -0500
In-Reply-To: <50CB3D33.7070800@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Dennis,

Am 14.12.2012 15:52, schrieb Dennis Jacobfeuerborn:
>> didn't match anymore - as the numbers got renumber due to the failed disk.
>> Is there a way to use some kind of UUIDs here too for journal?
>
> You should be able to use /dev/disk/by-uuid/* instead. That should give you
> a stable view of the filesystems.

Good idea but there are only listed partitions with UUIDs. When the 
journal is using directly the partition it does not have a UUID.

But this reminded me of /dev/disk/by-id and that works fine. I'm now 
using the wwn Number.

Greets,
Stefan
