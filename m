From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Heads-up: possible Jewel/Kraken RBD compatibility issue that
 might impact users doing rolling upgrades
Date: Tue, 9 May 2017 12:21:22 -0400
Message-ID: <CA+aFP1AZPXdmAqQnky9_GB52wRyYXmzgtLUEDWWguCi3oYA8fA@mail.gmail.com>
References: <CAPUexz9k-4qcpkB0x4FKuZfeLTUbLUq_=abSbKa9AjAGhzHuiw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35086 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdEIQVX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 12:21:23 -0400
Received: by mail-yw0-f180.google.com with SMTP id l135so3031326ywb.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 09:21:23 -0700 (PDT)
In-Reply-To: <CAPUexz9k-4qcpkB0x4FKuZfeLTUbLUq_=abSbKa9AjAGhzHuiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looking at the debug logs in the associated tracker ticket (thanks!),
it looks like three update object map ops were sent to the OSD and
never completed. This is strange since milliseconds before those three
requests were sent, six object map update ops were sent to the same
object and completed successfully.

Are you still able to reproduce this issue? If so, can you re-run with
"--debug-ms=20 --debug-objecter=20" as well? I attempted to import the
same cirros image using a Jewel 10.2.7 client and Kraken 11.2.0 OSDs
and was unable to reproduce.

Thanks,
Jason

On Tue, May 9, 2017 at 10:18 AM, Florian Haas <florian@hastexo.com> wrote:
> Hi everyone,
>
> just a quick heads-up on this issue: http://tracker.ceph.com/issues/19889
>
> TL;DR: "rbd import" looks like it breaks when upgrading a cluster from
> Jewel to Kraken (and potentially, Luminous — not sure about that) and
> before upgrading the client itself. In other words, this might cause
> disruption in upgrades with clients using "rbd import"-like
> functionality (such as OpenStack Glance).
>
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
