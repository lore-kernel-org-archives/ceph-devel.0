From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Fri, 21 May 2010 00:16:46 +0200
Message-ID: <AANLkTinlpdEK-vqMYkYwvWT-tZBpfn2FZHi6LUiS5cPz@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
	 <4BF5A9D2.5080609@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58412 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977Ab0ETWQs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 18:16:48 -0400
In-Reply-To: <4BF5A9D2.5080609@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

2010/5/20 Anthony Liguori <anthony@codemonkey.ws>:
>> With new approaches like Sheepdog or Ceph, things are getting a lot
>> cheaper and you can scale your system without disrupting your servic=
e.
>> The concepts are quite similar to what Amazon is doing in their EC2
>> environment, but they certainly won't publish it as OpenSource anyti=
me
>> soon.
>>
>> Both projects have advantages and disadvantages. Ceph is a bit more
>> universal as it implements a whole filesystem. Sheepdog is more
>> feature complete in regards of managing images (e.g. snapshots). Bot=
h
>> projects require some additional work to become stable, but they are
>> on a good way.
>>
>> I would really like to see both drivers in the qemu tree, as they ar=
e
>> the key to a design shift in how storage in the datacenter is being
>> built.
>>
>
> I'd be more interested in enabling people to build these types of sto=
rage
> systems without touching qemu.

You could do this by using Yehuda's rbd kernel driver, but I think
that it would be better to avoid this additional layer.

> Both sheepdog and ceph ultimately transmit I/O over a socket to a cen=
tral
> daemon, right? =A0So could we not standardize a protocol for this tha=
t both
> sheepdog and ceph could implement?

There is no central daemon. The concept is that they talk to many
storage nodes at the same time. Data is distributed and replicated
over many nodes in the network. The mechanism to do this is quite
complex. I don't know about sheepdog, but in Ceph this is called RADOS
(reliable autonomic distributed object store). Sheepdog and Ceph may
look similar, but this is where they act different. I don't think that
it would be possible to implement a common protocol.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
