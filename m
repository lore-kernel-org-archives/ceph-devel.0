From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD trim / unmap support?
Date: Tue, 06 Nov 2012 09:09:07 +0100
Message-ID: <5098C5A3.60201@profihost.ag>
References: <509306CC.5080307@profihost.ag> <5093078C.4020404@inktank.com> <50938233.9090902@profihost.ag> <50938DA0.6090205@profihost.ag> <5093F1F6.5040502@inktank.com> <50942963.1020700@profihost.ag> <509566BB.5030706@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57995 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab2KFIJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 03:09:11 -0500
In-Reply-To: <509566BB.5030706@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 03.11.2012 19:47, schrieb Stefan Priebe:
> Hi Josh,
>
>> Thanks - here it comes:
>> https://www.dropbox.com/s/blegk8u14n30ntq/librbd.log.gz
>
> It this one OK? Do you get an idea what this could be?

I checked this again today with latest git and wip-rbd-read branch but i 
still get the same I/O errors.

Stefan
