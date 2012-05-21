From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: is rados block cluster production ready ?
Date: Mon, 21 May 2012 10:09:19 +0200
Message-ID: <4FB9F82F.9050208@profihost.ag>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro> <c1099add-5872-4b8b-9250-9dd33791a776@mailpro> <CADvuQREa3PXCG4Udvuy45wHUKBAruc40md_cOrssXYTN+8-JJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53245 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab2EUIJU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 04:09:20 -0400
In-Reply-To: <CADvuQREa3PXCG4Udvuy45wHUKBAruc40md_cOrssXYTN+8-JJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

Am 18.05.2012 18:13, schrieb Tommi Virtanen:
> <aderumier@odiso.com> wrote:
>> About network, does the rados protocol support some kind of multipathing ? Or does I need to use bonding/lacp ?
> 
> Bonding is almost always good if you have the switch ports & bandwidth
> to spare. Even without bonding, one of the tricks RADOS does is that
> each chunk of the RBD image is stored on a different OSD, so your
> hypervisor will actually talk to even thousands of OSDs when the vm
> accesses the disk. This way, the network link of any individual
> storage node is less likely to become a performance bottleneck for the
> vm.
That's great but if you go the way of having for example 8x OSDs per
server with 8 single Disks - how can i archieve that ceph is splitting
my files to the correct servers for redundancy?

Stefan
