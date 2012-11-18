From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [BUG] rbd discard should return OK even if rbd file does not
 exist
Date: Sat, 17 Nov 2012 18:38:30 -0800
Message-ID: <50A84A26.20902@inktank.com>
References: <50A80D65.7070901@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65236 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab2KRCic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 21:38:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2655379pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 18:38:32 -0800 (PST)
In-Reply-To: <50A80D65.7070901@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/17/2012 02:19 PM, Stefan Priebe wrote:
> Hello list,
>
> right now librbd returns an error if i issue a discard for a sector /
> byterange where ceph does not have any file as i had never written to
> this section.

Thanks for bringing this up again. I haven't had time to dig deeper
into it yet, but I definitely want to fix this for bobtail.

> This is not correct. It should return 0 / OK in this case.
>
> Stefan
>
> Examplelog:
> 2012-11-02 21:06:17.649922 7f745f7fe700 20 librbd::AioRequest: WRITE_FLAT
> 2012-11-02 21:06:17.649924 7f745f7fe700 20 librbd::AioCompletion:
> AioCompletion::complete_request() this=0x7f72cc05bd20
> complete_cb=0x7f747021d4b0
> 2012-11-02 21:06:17.649924 7f747015c780  1 -- 10.10.0.2:0/2028325 -->
> 10.10.0.18:6803/9687 -- osd_op(client.26862.0:3073
> rb.0.1044.359ed6c7.000000000bde [delete] 3.bd84636 snapc 2=[]) v4 -- ?+0
> 0x7f72d81c69b0 con 0x7f74600dbf50
> 2012-11-02 21:06:17.649934 7f747015c780 20 librbd:  oid
> rb.0.1044.359ed6c7.000000000bdf 0~4194304 from [4156556288,4194304]
> 2012-11-02 21:06:17.649972 7f7465a6e700  1 -- 10.10.0.2:0/2028325 <==
> osd.1202 10.10.0.18:6806/9821 143 ==== osd_op_reply(1652
> rb.0.1044.359ed6c7.000000000652 [delete] ondisk = -2 (No such file or
> directory)) v4 ==== 130+0+0 (2964367729 0 0) 0x7f72dc0f0090 con
> 0x7f74600e4350
> 2012-11-02 21:06:17.649994 7f745f7fe700 20 librbd::AioRequest: write
> 0x7f74600feab0 should_complete: r = -2

This last line isn't printing what's actually being returned to the
application. It's still in librbd's internal processing, and will be
converted to 0 for the application.

Could you try with the master or next branches? After the
'should_complete' line, there should be a line like:

<date> <time> <thread_id> 20 librbd::AioCompletion: 
AioCompletion::finalize() rval 0 ...

That 'rval 0' shows the actual return value the application (qemu in
this case) will see.

Josh
