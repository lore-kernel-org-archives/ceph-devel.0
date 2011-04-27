From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph block pointer abstractions
Date: Wed, 27 Apr 2011 12:24:07 -0700
Message-ID: <5C6848CA1E2C4DC09E2F12612C447199@gmail.com>
References: <BANLkTimWV7QUUa7tQkzLO688XvMYKFKshQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34346 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1D0TYM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 15:24:12 -0400
Received: by pwi15 with SMTP id 15so844577pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 12:24:11 -0700 (PDT)
In-Reply-To: <BANLkTimWV7QUUa7tQkzLO688XvMYKFKshQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fabio Kaminski <fabiokaminski@gmail.com>
Cc: ceph-devel@vger.kernel.org

We're not quite sure what construct you're referring to here with "block pointer"?

Generally users of the Ceph client do not need to know about the position or movement of data on the storage cluster, though, if that answers your question. :)
-Greg
On Wednesday, April 27, 2011 at 12:18 PM, Fabio Kaminski wrote: 
> Suppose that i have a datastructure with a block pointer to another
> item(block)..
> how this pointer would work with ceph, if this block get moved to
> another data node, would it still work?
> 
> what is the best way to do it under ceph? im using cephs own userland libs..
> 
> block pointers? its safe? how.. :)
> 
> thanks,
> 
> Fabio Kaminski
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

