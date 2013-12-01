From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Sun, 1 Dec 2013 04:08:45 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66BD65DF@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<CAF6-1L7UXXNRsyarZw+EcRjdPtnXAuULSZDGtDDB3Oy3O79KMQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B66BB564A@BITCOM1.int.sbss.com.au>
 <CAF6-1L7jtotzSPexz28_vKeNEGhWNzL3eGVu_Uibpkq6V+FaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:42764 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3LAEIz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Nov 2013 23:08:55 -0500
In-Reply-To: <CAF6-1L7jtotzSPexz28_vKeNEGhWNzL3eGVu_Uibpkq6V+FaAA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> Hi James,
> 
> > Are you still working on this in any way?
> 
> Well I'm using it, but I haven't worked on it. I never was able to
> reproduce any issue with it locally ...
> In prod, I do run it with cache disabled though since I never took the
> time to check using the cache was safe in the various failure modes.
> 
> Is 300 MB normal ? Well, that probably depends on your settings (cache
> enabled / size / ...). But in anycase I'd guess the memory comes from
> a librbd itself. It's not like I do much allocation myself :p
> 

What sort of memory are your instances using? I haven't turned on any caching so I assume it's disabled.

I increased the stack size to 8M to work around the crash I was having, but lowering that to 2MB doesn't have any significant impact on memory usage.

James
