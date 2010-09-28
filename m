From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Usage of rbd
Date: Tue, 28 Sep 2010 11:20:05 -0700
Message-ID: <AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com>
References: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51784 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab0I1SUH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Sep 2010 14:20:07 -0400
Received: by ewy23 with SMTP id 23so1945529ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Sep 2010 11:20:06 -0700 (PDT)
In-Reply-To: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 28, 2010 at 8:55 AM, Takuya ASADA <syuu@dokukino.com> wrote:
>
> Hi,
>
> I'm trying to test kvm-rbd, and I just failed to create image on it.
> I followed installation sequence on the wiki
> (http://ceph.newdream.net/wiki/Kvm-rbd),
> and executed
> $ qemu-img create -f rbd rbd:data/foo 10G
> it returned
>
> failed assigning block id
> qemu-img: rbd:data/foo: error while creating rbd: Input/output error
>
> Then I looked into source code, and realized maybe I need to load libcls_rbd.so,
> so I executed
> $ cclass -a
> $ ceph class list
> rbd class shows up.
>
> 10.09.29_00:55:53.939866 mon <- [class,list]
> 10.09.29_00:55:53.940230 mon0 -> 'installed classes:
> rbd (v1.2 [x86-64])
> ' (0)
>
> Then I tried "qemu-img create" again, also "rbd create", it didn't work at all.
> Like this:
>
> $ rbd -p hoge99 --size 10 create test.img
> failed to assign a block name for image
> create error: Operation not supported
>
> $ qemu-img create -f rbd rbd:data/foo 10G
> Formatting 'rbd:data/foo', fmt=rbd size=10737418240 cluster_size=0
> failed assigning block id
> qemu-img: rbd:data/foo: error while creating rbd: Input/output error
>
> osd and mon are working correctly, I can use it via rados command and librados.
>
> My question is:
> - Am I missing something to start using rbd?

The rbd class is loaded but not activated. You can run 'ceph class
activate rbd 1.2', it should fix it (note that it takes a minute to
propagate).

>
> - Do I need rbd kernel module for kvm-rbd?
> I thought it's just a userland application, which calling librados.
>
It is a userland application, and you don't need any kernel module.

Thanks,
Yehuda
