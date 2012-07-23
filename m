From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: [rados] Asynchronous operations
Date: Mon, 23 Jul 2012 17:59:21 +0200
Message-ID: <jujscq$sug$1@dough.gmane.org>
References: <jsecti$m2u$1@dough.gmane.org> <Pine.LNX.4.64.1206270821040.18530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43751 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab2GWP7e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Jul 2012 11:59:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1StL2i-0002us-P2
	for ceph-devel@vger.kernel.org; Mon, 23 Jul 2012 17:59:32 +0200
Received: from 82-169-160-32.ip.telfort.nl ([82.169.160.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 17:59:32 +0200
Received: from rutger by 82-169-160-32.ip.telfort.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 17:59:32 +0200
In-Reply-To: <Pine.LNX.4.64.1206270821040.18530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 06/27/2012 05:22 PM, Sage Weil wrote:
>
> There is a get_return_value() method on the AioCompletion that gives you
> bytes read (for reads).  For write operations, it is always 0 (success) or
> an error code.
>

Thanks for the info. Maybe a bit of a newbie question, but in that case, 
how do I detect a read error, given an AioCompletion object?

Thanks,

Rutger


