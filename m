From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 17:06:29 +0100
Message-ID: <50CB4E85.50609@profihost.ag>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de> <50CB3F32.2070106@inktank.com> <50CB41BE.8020300@profihost.ag> <50CB43D8.3020603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58970 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2LNQGb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 11:06:31 -0500
In-Reply-To: <50CB43D8.3020603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Mark,

Am 14.12.2012 16:20, schrieb Mark Nelson:
> sudo parted -s -a optimal /dev/$DEV mklabel gpt
> sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-journal 0% 10G
> sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-data 10G 100%

Isn't that the part type you're using?
mkpart part-type start-mb end-mb

I like your idea and i think it's a good one but i want to know why this 
works. part-type isn't FS label...

Greets,
Stefan
