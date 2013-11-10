From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: libuuid vs boost uuid
Date: Sun, 10 Nov 2013 01:44:22 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:50138 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBo3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 20:44:29 -0500
In-Reply-To: <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> On Sat, 9 Nov 2013, James Harper wrote:
> > Just out of curiosity (recent thread about windows port) I just had a
> > quick go at compiling librados under mingw (win32 cross compile), and
> > one of the errors that popped up was the lack of libuuid under mingw.
> > Ceph appears to use libuuid, but I notice boost appears to include a
> > uuid class too, and it seems that ceph already uses some of boost (which
> > already builds under mingw).
> >
> > Is there anything special about libuuid that would mean boost's uuid
> > class couldn't replace it? And would it be better to still use ceph's
> > uuid.h as a wrapper around the boost uuid class, or to modify ceph to
> > use the boost uuid class directly?
> 
> Nice!  Boost uuid looks like it would work just fine.  It is probably
> easier and less disruptive to use it from within the existing class in
> include/uuid.h.
> 

That seems to work (the header compiles at least), but then it falls down when things try to memcpy out of it. In particular, an fsid appears to be a char[16]. Is that a uuid? And is keeping it as a byte array an optimisation?

James
