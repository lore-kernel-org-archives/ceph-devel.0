From: Sage Weil <sage@inktank.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 08:20:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304220815060.14431@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au> <517159C3.5030100@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
 <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au> <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
 <51752156.9050004@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33229 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3DVPUD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 11:20:03 -0400
In-Reply-To: <51752156.9050004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: James Harper <james.harper@bendigoit.com.au>, Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> You may want to try increasing your read_ahead_kb on the OSD data disks and
> see if that helps read speeds.

Jumping into this thread late, so I'm not sure if this was covered, but:

Remember that readahead on the OSDs will only help up to the size of the 
object (4MB).  To get good read performance in general what is really 
needed is for the librbd user to do readahead so that the next object(s)
are being fetched before they are needed.  I don't think this happens with 
'dd' (opening a block device as a file does not trigger the kernel VM 
readahead code, IIRC).  Unless Sylvian implemented this in his tool 
explicitly, it won't happen there either.

sage
