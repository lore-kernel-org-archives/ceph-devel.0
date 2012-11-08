From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: trying to import crushmap results in max_devices > osdmap max_osd
Date: Thu, 08 Nov 2012 15:59:33 -0800
Message-ID: <509C4765.6010307@inktank.com>
References: <509A7E0C.9040606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39724 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2KHX76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 18:59:58 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so2405853pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 15:59:58 -0800 (PST)
In-Reply-To: <509A7E0C.9040606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/07/2012 07:28 AM, Stefan Priebe - Profihost AG wrote:
> Hello,
>
> i've added two nodes with 4 devices each and modified the crushmap.
>
> But importing the new map results in:
> crushmap max_devices 55 > osdmap max_osd 35
>
> What's wrong?

I think this is an obsolete check since 
ee541c0f8d871172ec61962372efca943308e5fe.

wip-max-devices removes these checks.
Sage, is there any reason to keep them?

Josh
