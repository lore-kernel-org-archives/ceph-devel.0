From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 29 Nov 2013 16:11:18 +0100
Message-ID: <CAF6-1L7jtotzSPexz28_vKeNEGhWNzL3eGVu_Uibpkq6V+FaAA@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<CAF6-1L7UXXNRsyarZw+EcRjdPtnXAuULSZDGtDDB3Oy3O79KMQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B66BB564A@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47181 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3K2PLT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Nov 2013 10:11:19 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so14635458pbb.22
        for <ceph-devel@vger.kernel.org>; Fri, 29 Nov 2013 07:11:18 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B66BB564A@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

> Are you still working on this in any way?

Well I'm using it, but I haven't worked on it. I never was able to
reproduce any issue with it locally ...
In prod, I do run it with cache disabled though since I never took the
time to check using the cache was safe in the various failure modes.

Is 300 MB normal ? Well, that probably depends on your settings (cache
enabled / size / ...). But in anycase I'd guess the memory comes from
a librbd itself. It's not like I do much allocation myself :p

Cheers,

   Sylvain
