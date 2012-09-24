From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Machine hangs while writing to ceph filesystem
Date: Mon, 24 Sep 2012 10:54:28 -0400
Message-ID: <201209241454.q8OEsSp0006148@ayesha.phys.virginia.edu>
References: <505CEE02.1030507@inktank.com>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:56367 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab2IXOya (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 10:54:30 -0400
In-reply-to: Your message of "Fri, 21 Sep 2012 17:45:22 CDT."
             <505CEE02.1030507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Alex,

elder@inktank.com said:
> If you are able to and are comfortable with it, could you please try to mount
> your file system with the "nocrc" mount option?

> I believe I have found the cause of this problem, but it would be useful to
> have you verify that it goes away when this option is used.

					-Alex 

	Thanks for your help.  I've tried "nocrc", and it does
indeed seem to make the problem go away.

					Bryan

-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


