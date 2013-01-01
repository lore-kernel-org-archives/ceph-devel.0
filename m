From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: 0.55 crashed during upgrade to bobtail
Date: Tue, 1 Jan 2013 23:16:31 +0300
Message-ID: <CABYiri-4uo03O8tGfd_mtRF5gXAHv63QRonHPqYHkXhPipYY=A@mail.gmail.com>
References: <CABYiri_pJynyL2DSRqErkAYp0H0sDmwg0HCAYfB84JUZ2dfczw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45182 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab3AAUQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jan 2013 15:16:52 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so12571865oag.15
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jan 2013 12:16:51 -0800 (PST)
In-Reply-To: <CABYiri_pJynyL2DSRqErkAYp0H0sDmwg0HCAYfB84JUZ2dfczw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 1, 2013 at 9:49 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Hi,
>
> All osds in the dev cluster died shortly after upgrade (packet-only,
> i.e. binary upgrade, even without restart running processes), please
> see attached file.
>
> Was: 0.55.1-356-g850d1d5
> Upgraded to: 0.56 tag
>
> The only one difference is a version of the gcc corresponding
> libstdc++ - 4.6 on the buildhost and 4.7 on the cluster. Of course I
> may do a rollback and problem will eliminate with high probability,
> but seems there should be some fix. Also I have something simular in
> the the testing env days ago -  packet upgrade inside 0.55 killed all
> _windows_ guests_ and one of tens of linux guests running above rbd.
> Unfortunately I have no debug sessions at this moment and I have only
> tail of the log from qemu:
>
> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
>   what():  buffer::end_of_buffer
>
> I`m blaming ldconfig action from librbd because nothing else `ll cause
> such case of destroy on the running processes - may be I`m wrong.
>
> thanks!
>
> WBR, Andrey

Sorry, I`m not able to reproduce crash after rollback and traces was
uncomplete due to lack of disk space on specified core location, so
please don`t mind it.
