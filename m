From: Gregory Farnum <greg@inktank.com>
Subject: Re: rados_pool_list usage
Date: Wed, 27 Mar 2013 08:59:49 -0700
Message-ID: <9B043BA89C1943F989AD6213B2361DD7@inktank.com>
References: <5152B4EC.4070700@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59592 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab3C0P7w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 11:59:52 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so1049169pad.30
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 08:59:52 -0700 (PDT)
In-Reply-To: <5152B4EC.4070700@42on.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>



On Wednesday, March 27, 2013 at 1:59 AM, Wido den Hollander wrote:

> Hi,
> 
> While working with rados_pool_list I stumbled upon what I think is a 
> documentation issue.
> 
> librados.h tells me this:
> 
> /**
> * List objects in a pool
> *
> * Gets a list of pool names as NULL-terminated strings. The pool
> * names will be placed in the supplied buffer one after another.
> * After the last pool name, there will be two 0 bytes in a row.
> *
> * If len is too short to fit all the pool name entries we need, we 
> will fill
> * as much as we can.
> *
> * @param cluster cluster handle
> * @param buf output buffer
> * @param len output buffer length
> * @returns length of the buffer we would need to list all pools
> */
> int rados_pool_list(rados_t cluster, char *buf, size_t len);
> 
> "If len is too short to fit all the pool name entries we need, we will 
> fill as much as we can."
> 
> From what I could remember it would return the length required if "len" 
> isn't long enough. Looking at the Python and PHP bindings (which I 
> wrote) it seems that is correct.
> 
> It also says: "@returns length of the buffer we would need to list all 
> pools"
> 
> Docs issue I guess?
It certainly returns the amount of space needed; does it not also fill in the given buffer with however many pools it could? (It might not, but those sentences aren't contradictory in my mind.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


