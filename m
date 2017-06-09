From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 08:19:20 -0400
Message-ID: <CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com> <alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35239 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdFIMTW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 08:19:22 -0400
Received: by mail-wr0-f178.google.com with SMTP id q97so31171394wrb.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 05:19:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Bassam Tabbara <Bassam.Tabbara@quantum.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Thu, Jun 8, 2017 at 3:54 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 8 Jun 2017, Bassam Tabbara wrote:
>> Thanks Sage.
>>
>> > At CDM yesterday we talked about removing the ability to name your ceph
>> > clusters.
>>
>> Just to be clear, it would still be possible to run multiple ceph
>> clusters on the same nodes, right?
>
> Yes, but you'd need to either (1) use containers (so that different
> daemons see a different /etc/ceph/ceph.conf) or (2) modify the systemd
> unit files to do... something.

In the container case, I need to clarify that ceph-docker deployed
with ceph-ansible is not capable of doing this, since
the ad-hoc systemd units use the hostname as part of the identifier
for the daemon, e.g:

    systemctl enable ceph-mon@{{ ansible_hostname }}.service


>
> This is actually no different from Jewel. It's just that currently you can
> run a single cluster on a host (without containers) but call it 'foo' and
> knock yourself out by passing '--cluster foo' every time you invoke the
> CLI.
>
> I'm guessing you're in the (1) case anyway and this doesn't affect you at
> all :)
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
