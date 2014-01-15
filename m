From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph cli delay when one mon is down
Date: Wed, 15 Jan 2014 08:39:41 +0100
Message-ID: <2DE8E2E7-3A2F-4C0A-A19B-3AED0B43F1DC@profihost.ag>
References: <24E144B8C0207547AD09C467A8259F75592E9F78@lisa.maurer-it.com> <alpine.DEB.2.00.1401142323550.11815@cobra.newdream.net> <24E144B8C0207547AD09C467A8259F75592E9FDF@lisa.maurer-it.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:41415 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbaAOHjq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 02:39:46 -0500
In-Reply-To: <24E144B8C0207547AD09C467A8259F75592E9FDF@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 15.01.2014 um 08:33 schrieb Dietmar Maurer <dietmar@proxmox.com>:

>> You can avoid this, and speed things up in general, by using the interactive
>> mode:
>> 
>> #!/bin/sh
>> ceph <<EOM
>> do something
>> do something else
>> EOM
> 
> Above is a bit clumsy.

Especially you don't know which command fails in which way and produced which exitcode or output.


> To be honest, I want to do things with perl, so 
> I guess it is better to use perl bindings for librados.
> 
> Are perl bindings already available? 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
