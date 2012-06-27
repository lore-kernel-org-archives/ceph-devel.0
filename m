From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: OSD Hardware questions
Date: Wed, 27 Jun 2012 15:04:12 +0200
Message-ID: <4FEB04CC.4050008@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59822 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab2F0NEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 09:04:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i'm still thinking about optimal OSD hardware and while reading through 
the mailinglist and wiki had some questions.

I want to use SSD so my idea was to use a fast single socket cpu with 
8-10 SSD disks per OSD.

I got the following recommandations through the mailinglist:
"Dual socket servers will be overkill given the setup you're describing. 
Our WAG rule of thumb is 1GHz of modern CPU per OSD daemon. You might 
consider it if you decided you wanted to do an OSD per disk instead 
(that's a more common configuration, but it requires more CPU and RAM 
per disk and we don't know yet which is the better choice)."

but in my tests i see a CPU usage of 160% + 15% kworker per OSD Daemon 
on a 3,6ghz intel xeon CPU. That's far away of 1GHz per OSD. That's 
around 6,3Ghz per OSD. Is anything wrong here?

When i want to use 8-10 SSD Disks i need around 20 cores with 3,6Ghz. 
But there is no single socket with 20 cores with 3,6Ghz.

Or should i consider using a Raid 5 or 6?

Anything wrong?

Stefan

