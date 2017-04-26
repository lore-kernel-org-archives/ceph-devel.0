From: Elita Lobo <loboelita@gmail.com>
Subject: Re: When is do_redundant_reads flag set?
Date: Wed, 26 Apr 2017 09:30:46 +0530
Message-ID: <CAA8xDw3hLGUQv6WGazDWDS-f2ZzRD3-2gWOPwd89S12ipcgqnw@mail.gmail.com>
References: <CAA8xDw0KvsgYGC7utasZKpy5_960T3vDd4N_7TVecSey=f4X=g@mail.gmail.com>
 <alpine.DEB.2.11.1704211319500.6575@piezo.novalocal> <5642a610-e299-4505-2302-e164325cde9a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37808 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdDZEAr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Apr 2017 00:00:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id m123so113074461wma.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 21:00:47 -0700 (PDT)
In-Reply-To: <5642a610-e299-4505-2302-e164325cde9a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, Myna V <mynaramana@gmail.com>

On Wed, Apr 26, 2017 at 4:12 AM, David Zafman <dzafman@redhat.com> wrote:
>
> Using the following command to enable the option will cause true to be
> passed for the do_redundant_reads arg.
>
> To enable:
>
> ceph osd pool set <poolname> fast_read 1
>
> To disable:
>
> ceph osd pool set <poolname> fast_read 0
>
>
> David
>


Thanks for the info Sage and David! So can I assume that
read_redundant_reads flag will always have value 0 unless specified by
user ?


Regards,
Elita Lobo
