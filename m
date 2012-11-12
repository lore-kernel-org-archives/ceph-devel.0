From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: changed rbd cp behavior in 0.53
Date: Mon, 12 Nov 2012 14:47:38 -0800
Message-ID: <50A17C8A.9020007@inktank.com>
References: <CABYiri8Hm2EjLsffgSp3aANPwVQ2FPYWx5q01Wkq7sk1Smp41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42404 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab2KLWrl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 17:47:41 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2933664dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 14:47:39 -0800 (PST)
In-Reply-To: <CABYiri8Hm2EjLsffgSp3aANPwVQ2FPYWx5q01Wkq7sk1Smp41w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/12/2012 08:30 AM, Andrey Korolyov wrote:
> Hi,
>
> For this version, rbd cp assumes that destination pool is the same as
> source, not 'rbd', if pool in the destination path is omitted.
>
> rbd cp install/img testimg
> rbd ls install
> img testimg
>
>
> Is this change permanent?
>
> Thanks!

This is a regression. The previous behavior will be restored for 0.54.
I added http://tracker.newdream.net/issues/3478 to track it.

Josh
