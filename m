From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: seastar starting points
Date: Tue, 19 Dec 2017 10:41:52 -0500
Message-ID: <CAKOnarkNj3CXHsbEcxDtrzsWiHtFHZoYV=SkSVQKVYgLM=oS+w@mail.gmail.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
 <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com> <fc7d157d-6117-ab89-606c-656a9fa1585e@redhat.com>
 <CAJ4mKGYCJuxhKrdZT8L4o3Ya8yCdyCfqWyU3wMdwV5wWgdA8Pw@mail.gmail.com> <b9159d8a-d810-b2c2-f6a6-f9d2554ea7af@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:40236 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753494AbdLSPlz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Dec 2017 10:41:55 -0500
Received: by mail-it0-f44.google.com with SMTP id f190so3231214ita.5
        for <ceph-devel@vger.kernel.org>; Tue, 19 Dec 2017 07:41:54 -0800 (PST)
In-Reply-To: <b9159d8a-d810-b2c2-f6a6-f9d2554ea7af@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Haomai Wang <haomai@xsky.com>

Hi folks,

On Fri, Dec 15, 2017 at 12:07 PM, Casey Bodley <cbodley@redhat.com> wrote:
> I think it's important to have separate
> Messenger/Connection interfaces that expose futures to the application
> though. And ideally we'd be able to call into dpdk from seastar threads
> without requiring a separate thread pool.
>

Pretty much this.  Implementing a distinct Messenger seems better for
isolation, as well.

Matt

-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
