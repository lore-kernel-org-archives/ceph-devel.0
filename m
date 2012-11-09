From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd volume upgrades
Date: Fri, 09 Nov 2012 11:04:29 -0800
Message-ID: <509D53BD.6020706@inktank.com>
References: <CAPYLRziMQAR3tiN7syxBMTiiJ-xRVGYCK1MUYHrii5-UHMCnGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54098 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab2KITEx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 14:04:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2971491pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 11:04:53 -0800 (PST)
In-Reply-To: <CAPYLRziMQAR3tiN7syxBMTiiJ-xRVGYCK1MUYHrii5-UHMCnGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/09/2012 11:01 AM, Gregory Farnum wrote:
> I was asked today if there's a way to upgrade RBD volumes from v1 to
> v2. I didn't think so, but wanted
> 1) to make sure I'm right,
> 2) to ask how hard it would be,
> 3) to ask if we haven't done it because it didn't occur to us or
> because it's too hard.
> -Greg
>

This was addressed in the original discussions about format 2.

You need to export and then import the volume as format 2. Format 2 uses
different names for objects, so providing an 'upgrade' path would still
require copying all the data around.

Josh
