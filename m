From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Fri, 21 May 2010 06:28:42 +0100
Message-ID: <AANLkTimwt6XgIVRc7CC-aN--bmhg1xsDpo0MHUWEd5Ri@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
	 <4BF5A9D2.5080609@codemonkey.ws>
	 <AANLkTinlpdEK-vqMYkYwvWT-tZBpfn2FZHi6LUiS5cPz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61022 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0EUF2n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 May 2010 01:28:43 -0400
In-Reply-To: <AANLkTinlpdEK-vqMYkYwvWT-tZBpfn2FZHi6LUiS5cPz@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, May 20, 2010 at 11:16 PM, Christian Brunner <chb@muc.de> wrote:
> 2010/5/20 Anthony Liguori <anthony@codemonkey.ws>:
>> Both sheepdog and ceph ultimately transmit I/O over a socket to a ce=
ntral
>> daemon, right? =A0So could we not standardize a protocol for this th=
at both
>> sheepdog and ceph could implement?
>
> There is no central daemon. The concept is that they talk to many
> storage nodes at the same time. Data is distributed and replicated
> over many nodes in the network. The mechanism to do this is quite
> complex. I don't know about sheepdog, but in Ceph this is called RADO=
S
> (reliable autonomic distributed object store). Sheepdog and Ceph may
> look similar, but this is where they act different. I don't think tha=
t
> it would be possible to implement a common protocol.

I believe Sheepdog has a local daemon on each node.  The QEMU storage
backend talks to the daemon on the same node, which then does the real
network communication with the rest of the distributed storage system.
 So I think we're not talking about a network protocol here, we're
talking about a common interface that can be used by QEMU and other
programs to take advantage of Ceph, Sheepdog, etc services available
on the local node.

Haven't looked into your patch enough yet, but does librados talk
directly over the network or does it connect to a local daemon/driver?

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
