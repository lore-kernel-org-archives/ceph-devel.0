From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: documentation error for adding monitor?
Date: Mon, 06 Jan 2014 16:35:47 +0000
Message-ID: <52CADB63.6090301@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B6F359EEA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:53577 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbaAFQfT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 11:35:19 -0500
Received: by mail-wg0-f51.google.com with SMTP id b13so15720454wgh.6
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jan 2014 08:35:18 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B6F359EEA@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/05/2014 10:31 PM, James Harper wrote:
> When I follow the steps for adding a new monitor at http://ceph.com/docs/master/rados/operations/add-or-rm-mons/, the 'ceph mon add <mon-id> <ip[:port>' step always tells me that the monitor already exists. Is this step actually necessary?
>
> Thanks
>
> James

Well, this is an annoying bug we just haven't been out to fix it.

In a nutshell, when you issue the add command we queue the command 
message until the monitor is actually added to the monmap -- which makes 
sense, as we don't want to return success before it actually happens. 
However, the monitor will bootstrap once it gets a new monmap, recalc 
the ranks and trigger a new election -- and this happens before the 
message is replied to.  Once the election is over, the monitor will 
rerun any queued messages it may have, so that it may forward those 
messages to the new leader (if any) or handle any message that whose 
actions may have been interrupted by the election -- and the message we 
queued earlier ends up being rerun, thus the error: when that message is 
rerun, the monitor it is trying to add already exists.

The monitor was successfully added though.

   -Joao


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
