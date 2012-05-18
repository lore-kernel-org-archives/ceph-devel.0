From: Tommi Virtanen <tv@inktank.com>
Subject: Re: is rados block cluster production ready ?
Date: Fri, 18 May 2012 09:13:33 -0700
Message-ID: <CADvuQREa3PXCG4Udvuy45wHUKBAruc40md_cOrssXYTN+8-JJw@mail.gmail.com>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro> <c1099add-5872-4b8b-9250-9dd33791a776@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab2ERQNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 12:13:54 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4021651dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 09:13:54 -0700 (PDT)
In-Reply-To: <c1099add-5872-4b8b-9250-9dd33791a776@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Thanks Christian for doing an awesome job, you answered some of the
questions better than I personally could have ;)

On Thu, May 17, 2012 at 11:08 PM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
> About network, does the rados protocol support some kind of multipathing ? Or does I need to use bonding/lacp ?

Bonding is almost always good if you have the switch ports & bandwidth
to spare. Even without bonding, one of the tricks RADOS does is that
each chunk of the RBD image is stored on a different OSD, so your
hypervisor will actually talk to even thousands of OSDs when the vm
accesses the disk. This way, the network link of any individual
storage node is less likely to become a performance bottleneck for the
vm.

> I have submited the contact form on Inktank website, as we would like to pay for support/expertise to build this cluster, but didn't have response yet.

You should receive a response soon.
