From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: Fixed URL for latest branch shaman build?
Date: Mon, 27 Feb 2017 10:54:41 -0600
Message-ID: <CAEPMp+5gn+e1om6m22bVrFhcoeFB6eTRUVvCXU0wccTXVPHevw@mail.gmail.com>
References: <CABZ+qqk+ni5ACoRaRqTd75G77sDMvXnzuSQT7pwyiM8z0tsnMQ@mail.gmail.com>
 <CAEPMp+7VMR8VCUs5hN+109wRKy16x7L_=W2dTY7Q50rdgVnwxQ@mail.gmail.com> <CABZ+qqmcyQ_kJZP9XJiaW26eiQCZN4sfJwZXHPP9qBsVgY9h_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33375 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdB0Qym (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 11:54:42 -0500
Received: by mail-qk0-f178.google.com with SMTP id n127so106362311qkf.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 08:54:42 -0800 (PST)
In-Reply-To: <CABZ+qqmcyQ_kJZP9XJiaW26eiQCZN4sfJwZXHPP9qBsVgY9h_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

> Is there a way to be specific about which flavor? We don't want the
> notcmalloc jewel builds, for example.

Yes, you can also include the flavor in the url. If you do not include
it, you'll get the 'default' or unflavored build.

https://shaman.ceph.com/api/repos/ceph/jewel/latest/centos/7/flavors/notcmalloc/repo/

vs.

https://shaman.ceph.com/api/repos/ceph/jewel/latest/centos/7/flavors/default/repo/

- Andrew
