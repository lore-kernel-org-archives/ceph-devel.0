From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: C++11 and librados C++
Date: Tue, 04 Aug 2015 09:56:46 -0700
Message-ID: <mpqqse$8ri$3@ger.gmane.org>
References: <CAN=+7FX9Va+rxRr87E6bn6djjHSvXtVZTd+f576g=n01TJ5cRA@mail.gmail.com> <55C09812.8000704@42on.com> <alpine.DEB.2.00.1508040550250.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56241 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbbHDQ4z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 12:56:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZMfWH-0008E9-N2
	for ceph-devel@vger.kernel.org; Tue, 04 Aug 2015 18:56:53 +0200
Received: from 66.87.138.30 ([66.87.138.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 18:56:53 +0200
Received: from eternaleye by 66.87.138.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 18:56:53 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@lists.ceph.com

Sage Weil wrote:

> On Tue, 4 Aug 2015, Wido den Hollander wrote:
>> On 03-08-15 22:25, Samuel Just wrote:
>> > It seems like it's about time for us to make the jump to C++11.  This
>> > is probably going to have an impact on users of the librados C++
>> > bindings.  It seems like such users would have to recompile code using
>> > the librados C++ libraries after upgrading the librados library
>> > version.  Is that reasonable?  What do people expect here?
>> 
>> Well, some people use Qemu build by their distro, but they use librados
>> / librbd from ceph.com
>> 
>> So if they suddenly have to rebuild Qemu that would hurt them I think.
> 
> Qemu fortunately is using the C bindings, so it would not be affected.
> It is only the C++ ABI (or lack thereof) that is problematic.
> 
> What users of the C++ bindings are there out there?

One thing I think is worth noting: GCC 5 represents an ABI break for C++11 
http://developerblog.redhat.com/2015/02/05/gcc5-and-the-c11-abi/

Thus, some serious care is needed to avoid compat hazards when using C++11.

