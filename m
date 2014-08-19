From: Gregory Farnum <greg@inktank.com>
Subject: Re: size and depth of Tree Bucket
Date: Tue, 19 Aug 2014 14:47:17 -0700
Message-ID: <CAPYLRzjvTD_32-VLnCPH7TfPvpZVwdNCsVE_1F27=PUh_gSqNA@mail.gmail.com>
References: <CANX6DakEDhAjfSTcb4vtRbW-yX_TnV7Vd=VCWHuBQE=Cbu-cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54132 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaHSVrS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 17:47:18 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so8253230vcb.30
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 14:47:17 -0700 (PDT)
In-Reply-To: <CANX6DakEDhAjfSTcb4vtRbW-yX_TnV7Vd=VCWHuBQE=Cbu-cDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Viral Mehta <viral.vkm@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 13, 2014 at 4:09 AM, Viral Mehta <viral.vkm@gmail.com> wrote:
> Hi,
>
> I was looking at ceph/crush/builder.c crush_make_tree_bucket() function,
>
> I would like to understand what "size" argument refers to ? Generally speaking
> Tree Size is Total Number of the nodes. And this would be the same as number of
> items.
>
> But, crush.h mentions that it is NOT true. Can someone shed some light ?

This is some pretty opaque code, and I don't spend much time in it,
but just looking at the surroundings the argument is just the "size"
of the following array (int *items). It's the number of entries there
are within this bucket.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
