From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: MDS crash on 0.60 after upgrade from 0.58
Date: Thu, 04 Apr 2013 10:02:19 +0100
Message-ID: <515D419B.3000002@inktank.com>
References: <dcbb6527421f9a4537782e43dcaf4e47@omrb.pnpi.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:44422 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab3DDJDJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 05:03:09 -0400
Received: by mail-ea0-f175.google.com with SMTP id r16so913125ead.6
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 02:03:08 -0700 (PDT)
In-Reply-To: <dcbb6527421f9a4537782e43dcaf4e47@omrb.pnpi.spb.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Shvetsov <alexxy@gentoo.org>
Cc: ceph-devel@vger.kernel.org

On 04/04/2013 09:27 AM, Alexey Shvetsov wrote:
> Hi all!
>
> I'm getting mds crash on 0.60 after i upgraded to it from 0.58 release.
> MDS log looks like http://bpaste.net/show/88863/
> MON log looks like http://bpaste.net/show/88864/
>
> Interesting that if we didnt started osd then mds will not crash
>
> PS configuration consist of 18 osd + 1 mon + 1 mds
>

Hello Alexey,

First of all, it appears that your monitors have not been upgraded. 
Their crash dumps state their version to be 0.59 still.

Furthermore, the issue you're suffering from is the one described in 
ticket #4519 at the tracker [1], and the fix [2] is already present on 
v0.60, just not 0.59.

   -Joao

[1] - http://tracker.ceph.com/issues/4519
[2] - 71ec9c6bd54d560cc2bca4b6d0dbb3e6961df135
