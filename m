From: Sage Weil <sage@inktank.com>
Subject: Re: libuuid vs boost uuid
Date: Fri, 8 Nov 2013 22:43:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58324 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab3KIGno (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 01:43:44 -0500
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 9 Nov 2013, James Harper wrote:
> Just out of curiosity (recent thread about windows port) I just had a 
> quick go at compiling librados under mingw (win32 cross compile), and 
> one of the errors that popped up was the lack of libuuid under mingw. 
> Ceph appears to use libuuid, but I notice boost appears to include a 
> uuid class too, and it seems that ceph already uses some of boost (which 
> already builds under mingw).
> 
> Is there anything special about libuuid that would mean boost's uuid 
> class couldn't replace it? And would it be better to still use ceph's 
> uuid.h as a wrapper around the boost uuid class, or to modify ceph to 
> use the boost uuid class directly?

Nice!  Boost uuid looks like it would work just fine.  It is probably 
easier and less disruptive to use it from within the existing class in 
include/uuid.h.

sage
