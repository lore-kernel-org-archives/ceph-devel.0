From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 08:37:23 -0800
Message-ID: <CAFMfnwpzu0bcV3NVuM94J2GoFrAKmroq1696Xzbpvrf3VovTHQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
 <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com>
 <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com> <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com>
 <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com>
 <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com> <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
 <3fe910a6-3a6c-510d-ae32-6c072e99f046@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:49529 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755379AbdKNQhY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 11:37:24 -0500
Received: by mail-qt0-f180.google.com with SMTP id p44so15954617qtj.6
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 08:37:24 -0800 (PST)
In-Reply-To: <3fe910a6-3a6c-510d-ae32-6c072e99f046@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: John Spray <jspray@redhat.com>, =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

>>> Using Ceph on any decent scale actually requires one to use at least
>>> Puppet
>>> or similar tool, I wouldn't add any unnecessary complexity to already
>>> complex code just because of novice users that are going to have hard
>>> time
>>> using Ceph anyway once a disk breaks and needs to be replaced, or when
>>> performance goes to hell because users are free to create and remove
>>> snapshots every 5 minutes.

This discussion reminds me of a heated debate we had in the early days
about whether configuration management should handle the provisioning
of OSDs, or whether Ceph should have a tool to hide the ugliness. At
the time, I was staunchly on the configuration management side. We
used this horribleness to create new OSDs:

https://github.com/dreamhost-cookbooks/ceph/blob/de5929eb45bda50785aa01181b281e25af0d1785/recipes/osd.rb

Today we have ceph-disk (and soon to be ceph-volume)! I still have my
reservations about the level of udev wizardry, which is tricky to
debug, but it generally works and makes the experience better the vast
majority of operators, reglardless . This lead to a single method to
prepare OSDs that was configuration management agnostic. Nowadays all
the Ansible/Chef/Puppet thingers use ceph-disk.
