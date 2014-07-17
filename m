From: Alphe Salas <asalas@kepler.cl>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 17:24:50 -0400
Message-ID: <53C83F22.4010502@kepler.cl>
References: <53C7D97D.3010607@kepler.cl> <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net> <53C81266.6080306@kepler.cl> <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net> <20140717185714.GA10709@infradead.org> <53C821AC.1080307@kepler.cl> <alpine.DEB.2.00.1407171227110.3932@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:48980 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbaGQVYy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 17:24:54 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so2664384qcr.6
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 14:24:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407171227110.3932@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel <ceph-devel@vger.kernel.org>

Thank you I though I was seeing things :)
So it will come soon can I help chasing the things that give errors ?



Alphe Salas
I.T ingeneer

On 07/17/2014 03:28 PM, Sage Weil wrote:
> On Thu, 17 Jul 2014, Alphe Salas wrote:
>> I don t use QEMU /KVM just a plain regular rbd image format 1 map and mounted
>> to a real machine that is used as proxy for data droping to ceph.
>
> Oh, that explains part of it at least. The discard support isn't yet
> upstream for the kernel RBD driver.  The patches are mostly ready but
> there was a QA failure they're chasing down first.  Hopefully it will make
> it into the next kernel cycle.
>
> sage
>
