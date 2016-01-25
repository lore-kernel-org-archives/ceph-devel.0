From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: OSD behavior, in case of its journal disk (either HDD or SSD) failure
Date: Tue, 26 Jan 2016 00:37:00 +0530
Message-ID: <CANA9Uk6N=VEu+cwG0LRZQHWNziUkuNBJsHjEdXewxXxwX-f+UA@mail.gmail.com>
References: <CANA9Uk5d_vNEtr7Zv+afs8qzYVa-LTi=DEuJSm1w=h8NeC9w3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35091 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbcAYTHC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 14:07:02 -0500
Received: by mail-vk0-f50.google.com with SMTP id k1so79220554vkb.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 11:07:01 -0800 (PST)
In-Reply-To: <CANA9Uk5d_vNEtr7Zv+afs8qzYVa-LTi=DEuJSm1w=h8NeC9w3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

+ ceph-devel

On Mon, Jan 25, 2016 at 6:34 PM, M Ranga Swami Reddy
<swamireddy@gmail.com> wrote:
> Hello,
>
> If a journal disk fails (with crash or power failure, etc), what
> happens on OSD operations?
>
> PS: Assume that journal and OSD is on a separate drive.
>
> Thanks
> Swami
