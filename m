From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: cannot mount cephfs (with rbd working)
Date: Mon, 13 Aug 2012 17:44:45 -0700
Message-ID: <50299F7D.4080808@inktank.com>
References: <50299B30.6060102@bytesandbutter.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62313 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab2HNAov (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 20:44:51 -0400
Received: by obbuo13 with SMTP id uo13so7672261obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Aug 2012 17:44:51 -0700 (PDT)
In-Reply-To: <50299B30.6060102@bytesandbutter.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tobias Florek <tobias.florek@bytesandbutter.de>
Cc: ceph-devel@vger.kernel.org

On 08/13/2012 05:26 PM, Tobias Florek wrote:
<snip>
> # cat /etc/ceph/ceph.conf
> [osd]
>      osd journal_size = 1000
>
> [mon.a]
>      host = storage1
>      mon addr = 10.0.0.5:6789
>
> [osd.0]
>      host = storage1
>
> [osd.1]
>      host = storage1
>
> [msd.a]

That should be mds. Due to that typo, you have no mds running, which is
required for cephfs.

Josh

>      host = storage1
>
> [mount]
>      allow = %everyone
>
> # /etc/init.d/ceph status
> === mon.a ===
> mon.a: running 0.48argonaut
> === osd.0 ===
> osd.0: running 0.48argonaut
> === osd.1 ===
> osd.1: running 0.48argonaut
>
>
>
> thank you in advance for your help,
>   tobias florek

