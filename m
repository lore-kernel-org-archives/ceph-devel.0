From: Alfredo Deza <adeza@redhat.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 13:01:25 -0500
Message-ID: <CAC-Np1zHyOQBc+E=6Hy1RtsECd3m0SKWUxKrWaQOcBFJd6iLuA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
 <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com>
 <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com> <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com>
 <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com>
 <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com> <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
 <3fe910a6-3a6c-510d-ae32-6c072e99f046@redhat.com> <CAFMfnwpzu0bcV3NVuM94J2GoFrAKmroq1696Xzbpvrf3VovTHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:48754 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdKNSB1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 13:01:27 -0500
Received: by mail-qt0-f181.google.com with SMTP id f8so27376367qta.5
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 10:01:27 -0800 (PST)
In-Reply-To: <CAFMfnwpzu0bcV3NVuM94J2GoFrAKmroq1696Xzbpvrf3VovTHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: Mark Nelson <mnelson@redhat.com>, John Spray <jspray@redhat.com>, =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 14, 2017 at 11:37 AM, Kyle Bader <kyle.bader@gmail.com> wrote:
>>>> Using Ceph on any decent scale actually requires one to use at least
>>>> Puppet
>>>> or similar tool, I wouldn't add any unnecessary complexity to already
>>>> complex code just because of novice users that are going to have hard
>>>> time
>>>> using Ceph anyway once a disk breaks and needs to be replaced, or when
>>>> performance goes to hell because users are free to create and remove
>>>> snapshots every 5 minutes.
>
> This discussion reminds me of a heated debate we had in the early days
> about whether configuration management should handle the provisioning
> of OSDs, or whether Ceph should have a tool to hide the ugliness. At
> the time, I was staunchly on the configuration management side. We
> used this horribleness to create new OSDs:
>
> https://github.com/dreamhost-cookbooks/ceph/blob/de5929eb45bda50785aa01181b281e25af0d1785/recipes/osd.rb
>
> Today we have ceph-disk (and soon to be ceph-volume)! I still have my
> reservations about the level of udev wizardry, which is tricky to
> debug, but it generally works and makes the experience better the vast
> majority of operators, reglardless . This lead to a single method to
> prepare OSDs that was configuration management agnostic. Nowadays all
> the Ansible/Chef/Puppet thingers use ceph-disk.

There is a separation needed here I think, where there are tools and
abstractions that work at a local (or close to always local) level.
ceph-disk and
ceph-volume are good examples of this, since they operate with the
context of local devices. At some point during the process they do
need to inform
the cluster of their operations though (e.g. there is a new OSD,
register as part of the cluster).

So configuration that makes sense for a localized service like
ceph-volume (or ceph-disk) makes sense to be on the server itself.
That is why there are abstractions
via Puppet/Chef/Ansible for these tools, because these tools are
cluster-aware, and they are just delegating to localized services.

For configuration it might make sense to have this sort of duality,
where some settings and configuration makes sense for the server but
the rest is for the cluster.

I'm not sure that everything (exclusively) must be file-based or on
the monitors. If we are trying to make sure users are happy with these
changes, lets accept/embrace views like the one from Piotr, which
doesn't mean throwing away ideas on where we should be headed.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
