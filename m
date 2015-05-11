From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [BUG] rbd hard lookup -> kernel crush by some crush maps
Date: Mon, 11 May 2015 12:53:52 +0300
Message-ID: <CAOi1vP-sEmjaxwouBTSyeR=AjqWQSdrNQvMvm-Obkcdu8OeY5w@mail.gmail.com>
References: <CAGqmi74aCmT1=ai5sFg1GEQd2MTYzAP8wNnp8uDBh_X2k8D1vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36670 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbEKJxy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 05:53:54 -0400
Received: by wizk4 with SMTP id k4so98474871wiz.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 02:53:53 -0700 (PDT)
In-Reply-To: <CAGqmi74aCmT1=ai5sFg1GEQd2MTYzAP8wNnp8uDBh_X2k8D1vw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 12:37 PM, Timofey Titovets <nefelim4ag@gmail.com> wrote:
> Sorry list, i just can't find how send bugs to tracking system -_-
>
> How reporduce:
> 1. Use crush rule
> rule replicated_ruleset {
>   ruleset 0
>   type replicated
>   min_size 1
>   max_size 10
>   step take default
>   step choose firstn 0 type room
>   step choose firstn 0 type rack
>   step choose firstn 0 type host
>   step chooseleaf firstn 0 type osd
>   step emit
> }
> 2. inject into cluster
> 3. do:
> rbd map <rbd name>
>
> crushtool passed test successful, but if you inject map into cluster
> (i use 0.94.1)
> All kernel rbd Clients who use rbd map, immadentely crush.
> i don't know which kernel not affected, but i catch it with 4.0.1
>
> With long stucktrace in kernel and message like "Hard lookup detected"
> Sorry but i realy have a problems with find logs =_=

Can you paste your entire crushmap?

Thanks,

                Ilya
