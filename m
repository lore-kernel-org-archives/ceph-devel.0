From: Wido den Hollander <wido@42on.com>
Subject: Re: [librbd] Add interface of get the snapshot size?
Date: Mon, 24 Mar 2014 14:40:29 +0100
Message-ID: <533035CD.5010907@42on.com>
References: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:33302 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbaCXNkb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Mar 2014 09:40:31 -0400
In-Reply-To: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/24/2014 02:30 PM, Haomai Wang wrote:
> Hi all,
>
> As we know, snapshot is a lightweight resource in librbd and we
> doesn't have any statistic informations about it. But it causes some
> problems to the cloud management.
>
> We can't measure the size of snapshot, different snapshot will occur
> different space. So we don't have way to estimate the resource usage
> of user.
>
> Maybe we can have a counter to record space usage when volumn created.

What do you mean with space usage? Cluster wide or pool usage?

> When creating snapshot, the counter is freeze and store as the size of
> snapshot. New counter will assign to zero for the volume.
>
> Any feedback is appreciate!
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
