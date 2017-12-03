From: Lars Seipel <lars.seipel@gmail.com>
Subject: Re: Missing Debian packages (was: Luminous v12.2.2 released)
Date: Sun, 3 Dec 2017 10:31:51 +0100
Message-ID: <20171203093151.GA23927@horsthansen.slrz.net>
References: <877eu6uzcf.fsf@suse.com>
 <20171201192333.GA1830@horsthansen.slrz.net>
 <CAC-Np1xLHx-g+stePVYNk7UsQSbbzK8w+4OZt-8oxsZBp4NqtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45666 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdLCJby (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Dec 2017 04:31:54 -0500
Received: by mail-wr0-f182.google.com with SMTP id h1so14130105wre.12
        for <ceph-devel@vger.kernel.org>; Sun, 03 Dec 2017 01:31:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAC-Np1xLHx-g+stePVYNk7UsQSbbzK8w+4OZt-8oxsZBp4NqtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Found another issue, though, this time with the EL7 packages.

> Package librados2-12.2.2-0.el7.x86_64.rpm is not signed
> Package libcephfs2-12.2.2-0.el7.x86_64.rpm is not signed

Also, aarch64 is missing the files for 12.2.2.
