From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: unable to build Debian Stretch for 12.1.2
Date: Mon, 31 Jul 2017 16:20:40 -0600
Message-ID: <CALqRxCx2N6BswvPJXfcpDyPd9dNXhV7P3h-km0NbW7w7eQoiJg@mail.gmail.com>
References: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
 <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com>
 <CAC-Np1xnvw9KtwdKcTLTsKdarWH25FAeoExWhzB0Ad+TuTHM4A@mail.gmail.com>
 <CAF-wwdFhpUowuBT7Rxfmw4wPQUWHnxF7ZKQ0hRMoPo79cY-hEQ@mail.gmail.com>
 <CAF-wwdHQ9Zcp58VBBGqFOTFGz5acsLxe5ZVXX9jTyc_uSSAzvw@mail.gmail.com> <68916451.345723.1501076601021.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:38331 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdGaWUm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 18:20:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id g189so17358303vke.5
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 15:20:41 -0700 (PDT)
In-Reply-To: <68916451.345723.1501076601021.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 26, 2017 at 7:43 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> Hi,
>
> It's building fine here on a real debian strech.
>
> git clone https://github.com/ceph/ceph
> git submodule update --force --init --recursive
> git checkout v12.1.1

That looks like an older version, and Alfredo's seeing this crash in 12.1.2.

Would you please try within pbuilder?

- Ken
