From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: incremental rbd export / sparse files?
Date: Fri, 23 Nov 2012 09:03:59 +0100
Message-ID: <50AF2DEF.6080109@profihost.ag>
References: <50AE062E.5020301@profihost.ag> <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net> <24E144B8C0207547AD09C467A8259F755782F690@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56790 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030213Ab2KWIEJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 03:04:09 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F755782F690@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 23.11.2012 07:23, schrieb Dietmar Maurer:
>> Step 2 is to export the incremental changes.  The hangup there is figuring out
>> a generic and portable file format to represent those incremental changes;
>> we'd rather not invent something ourselves that is ceph-specific.
>> Suggestions welcome!
>
> AFAIK, both 'zfs' and 'btrfs' already have such format.

I think zfs could be problematic again with their licenses? If not i 
would prefer that one as it is proven and stable.

Greets,
Stefan
