From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD Backup
Date: Wed, 21 Nov 2012 14:56:42 +0100
Message-ID: <50ACDD9A.5050405@profihost.ag>
References: <50ACD936.8060907@profihost.ag> <50ACDB85.4020006@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57965 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2KUN4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 08:56:48 -0500
In-Reply-To: <50ACDB85.4020006@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Wido,

thanks for all your explanations.

This doesn't seem to work:
> rbd export --snap BACKUP <img> <dest>

rbd -p kvmpool1 export --snap BACKUP vm-101-disk-1 /vm-101-disk-1.img 

rbd: error setting snapshot context: (2) No such file or directory

Or should i still create and delete a snapshot named BACKUP before doing 
this?

Greets,
Stefan
