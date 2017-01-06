From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Hammer 0.94.10 release - last call
Date: Fri, 6 Jan 2017 14:56:03 -0500
Message-ID: <CAC-Np1yHUzoMCh72g6i1Ak75OPM-n=NgyE=-8HBCEvJYQAcG8Q@mail.gmail.com>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz> <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz> <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
 <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org> <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
 <ecd937e4-98df-b42e-8a57-5c8bb963fd54@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34876 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937934AbdAFT5V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 14:57:21 -0500
Received: by mail-qt0-f181.google.com with SMTP id x49so22256713qtc.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 11:56:04 -0800 (PST)
In-Reply-To: <ecd937e4-98df-b42e-8a57-5c8bb963fd54@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 6, 2017 at 9:13 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> The way to test this would be to create a cluster with monitors that
>> can't form a quorum. For example, with 2 monitors or by giving
>> bad short hostnames in the configuration. The test would need to
>> verify that it doesn't hang forever, it just fails after 10 minutes.
>
>
> Can you help with that?

There isn't a test case for Jewel either. I don't think the lack of a
task should prevent this from getting backported to hammer.

Not sure how to create one,  but could help provide any details for it
>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
