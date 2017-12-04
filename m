From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Missing Debian packages (was: Luminous v12.2.2 released)
Date: Mon, 4 Dec 2017 09:48:01 -0500
Message-ID: <CAC-Np1yjC=+rq=mzOhoJ6eNWzQUjTURuDP3xmy=AKkeQ+EqkyA@mail.gmail.com>
References: <877eu6uzcf.fsf@suse.com> <20171201192333.GA1830@horsthansen.slrz.net>
 <CAC-Np1xLHx-g+stePVYNk7UsQSbbzK8w+4OZt-8oxsZBp4NqtQ@mail.gmail.com> <20171203093151.GA23927@horsthansen.slrz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:40391 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753125AbdLDOsC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Dec 2017 09:48:02 -0500
Received: by mail-qt0-f177.google.com with SMTP id u42so21424079qte.7
        for <ceph-devel@vger.kernel.org>; Mon, 04 Dec 2017 06:48:02 -0800 (PST)
In-Reply-To: <20171203093151.GA23927@horsthansen.slrz.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Seipel <lars.seipel@gmail.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Dec 3, 2017 at 4:31 AM, Lars Seipel <lars.seipel@gmail.com> wrote:
> Found another issue, though, this time with the EL7 packages.
>
>> Package librados2-12.2.2-0.el7.x86_64.rpm is not signed
>> Package libcephfs2-12.2.2-0.el7.x86_64.rpm is not signed

This has been fixed, thanks for notifying us.


>
> Also, aarch64 is missing the files for 12.2.2.

There aren't any aarch64 packages for this release. We were unable to build them
