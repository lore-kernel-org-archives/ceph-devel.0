From: Alphe Salas <asalas@kepler.cl>
Subject: Re: Forever growing data in ceph using RBD image
Date: Wed, 06 Aug 2014 15:02:11 -0400
Message-ID: <53E27BB3.5030601@kepler.cl>
References: <53C7D97D.3010607@kepler.cl> <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net> <53C81266.6080306@kepler.cl> <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net> <20140717185714.GA10709@infradead.org> <53C821AC.1080307@kepler.cl> <alpine.DEB.2.00.1407171227110.3932@cobra.newdream.net> <53C83F22.4010502@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:46148 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaHFTCP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Aug 2014 15:02:15 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so3227111qgf.34
        for <ceph-devel@vger.kernel.org>; Wed, 06 Aug 2014 12:02:14 -0700 (PDT)
In-Reply-To: <53C83F22.4010502@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel <ceph-devel@vger.kernel.org>

How can I follow the state of advancement of the resolution of this 
issue ? I really need it and I really need to know when it will be 
release in order to immediatly install the new ceph version which patch
the forever growing data in ceph using RBD bold image (no QEMU etc..)




Alphe Salas
I.T ingeneer

On 07/17/2014 05:24 PM, Alphe Salas wrote:
> Thank you I though I was seeing things :)
> So it will come soon can I help chasing the things that give errors ?
>
>
>
> Alphe Salas
> I.T ingeneer
>
> On 07/17/2014 03:28 PM, Sage Weil wrote:
>> On Thu, 17 Jul 2014, Alphe Salas wrote:
>>> I don t use QEMU /KVM just a plain regular rbd image format 1 map and
>>> mounted
>>> to a real machine that is used as proxy for data droping to ceph.
>>
>> Oh, that explains part of it at least. The discard support isn't yet
>> upstream for the kernel RBD driver.  The patches are mostly ready but
>> there was a QA failure they're chasing down first.  Hopefully it will
>> make
>> it into the next kernel cycle.
>>
>> sage
>>
