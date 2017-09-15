From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Fri, 15 Sep 2017 11:02:45 -0700
Message-ID: <CA+2bHPa0QL94xckywnrF-j+k1KvZwZv4KVEzcj-DmqDFURby=Q@mail.gmail.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com>
 <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com>
 <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
 <87inglfqsp.fsf@suse.com> <87fubofiji.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:46757 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIOSDR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 14:03:17 -0400
Received: by mail-io0-f175.google.com with SMTP id d16so10332638ioj.3
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 11:03:17 -0700 (PDT)
In-Reply-To: <87fubofiji.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Yuri Weinstein <yweinste@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

On Fri, Sep 15, 2017 at 1:54 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
> So had failures in many jobs of all the 3 suites due to an ansible
> failure, the fs suite, however, has a few failures in this test
> (tasks.cephfs.test_misc.TestMisc), is anyone aware of prior failures of
> this suite, can be seen in this run for eg.
>
> http://pulpito.ceph.com/abhi-2017-09-14_11:23:49-fs-wip-luminous-2017-09-14-distro-basic-smithi/1632469/

That fs failure is known and can be ignored:
http://tracker.ceph.com/issues/21381

-- 
Patrick Donnelly
