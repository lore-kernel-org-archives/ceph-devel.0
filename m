From: Alphe Salas <asalas@kepler.cl>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 15:19:08 -0400
Message-ID: <53C821AC.1080307@kepler.cl>
References: <53C7D97D.3010607@kepler.cl> <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net> <53C81266.6080306@kepler.cl> <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net> <20140717185714.GA10709@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:38341 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbaGQTTM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 15:19:12 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so2347994qgf.17
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 12:19:12 -0700 (PDT)
In-Reply-To: <20140717185714.GA10709@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I don t use QEMU /KVM just a plain regular rbd image format 1 map and 
mounted to a real machine that is used as proxy for data droping to ceph.


---

Alphe Salas
I.T ingeneer

On 07/17/2014 02:57 PM, Christoph Hellwig wrote:
> On Thu, Jul 17, 2014 at 11:27:31AM -0700, Sage Weil wrote:
>> I assume you are using kvm/qemu?  It may be that older versions aren't
>> passing through trims; Josh would know more.  Or maybe the trim sizes are
>> too small to let rados effectively deallocate entire objects.  Logs might
>> help there.
>
> At least for the qemu version from a few month ago that I'm using in my
> testing I explicitly have to enable passthrough of UNMAP/TRIM on the
> qemu command line.
>
