From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: osd not in tree
Date: Thu, 15 Nov 2012 23:41:08 -0800
Message-ID: <50A5EE14.6070108@inktank.com>
References: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57114 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2KPHlO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 02:41:14 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1684942pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 23:41:14 -0800 (PST)
In-Reply-To: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/15/2012 11:21 PM, Drunkard Zhang wrote:
> I installed mon x1, mds x1 and osd x11 in one host, then add some osd
> from other hosts, But they are not in osd tree, also not usable, how
> can I fix this?
>
> The crush command I used:
> ceph osd crush set 11 osd.11 3 pool=data datacenter=dh-1L, room=room1,
> row=02, rack=05, host=squid87-log13

Remove the commas in that command and it'll work. I fixed the docs for
this.

Josh

