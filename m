From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD Backup
Date: Thu, 22 Nov 2012 22:23:00 +0100
Message-ID: <50AE97B4.4060501@profihost.ag>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl> <50AE0535.8080904@profihost.ag> <50AE24FD.8090103@widodh.nl> <50AE944E.4030704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58701 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab2KVVXD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 16:23:03 -0500
In-Reply-To: <50AE944E.4030704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

Am 22.11.2012 22:08, schrieb Josh Durgin:

>> This way you have a pretty consistent snapshot.
>
> You can get an entirely consistent snapshot using xfs_freeze to
> stop I/O to the fs until you thaw it. It's done at the vfs level
> these days, so it works on all filesystems.

Great thing we even use XFS ;-) but when i do
xfs_freeze -f /

it just hangs and i can't do anything until i reset the whole VM.

Stefan
