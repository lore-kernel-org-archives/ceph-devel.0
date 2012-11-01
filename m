From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD trim / unmap support?
Date: Thu, 01 Nov 2012 16:36:44 -0700
Message-ID: <5093078C.4020404@inktank.com>
References: <509306CC.5080307@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:63385 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab2KAXg7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 19:36:59 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1384349dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 16:36:58 -0700 (PDT)
In-Reply-To: <509306CC.5080307@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/01/2012 04:33 PM, Stefan Priebe wrote:
> Hello list,
>
> does rbd support trim / unmap? Or is it planned to support it?
>
> Greets,
> Stefan

librbd (and thus qemu) support it. The rbd kernel module does not yet.
See http://ceph.com/docs/master/rbd/qemu-rbd/#enabling-discard-trim

Josh
