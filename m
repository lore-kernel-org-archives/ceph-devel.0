From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: handling qemu-guest logs in ceph-ansible
Date: Tue, 2 Aug 2016 09:19:07 -0400
Message-ID: <CA+aFP1DGzX7M7CugzH51VXTQzasZkSe3Jxm+kudRE6PzeotPWQ@mail.gmail.com>
References: <CALqRxCzk4-u842fq5xBW2SrdYSY+9wD=zLEDtUrAgNZ-L4pggA@mail.gmail.com>
 <CAJ4mKGa6Mj7PJ8nnij+QcbgdCtCfzuH7POgeXBXyo51CtT91Qg@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36822 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965972AbcHBNt4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 09:49:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id pp5so63698922pac.3
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2016 06:48:24 -0700 (PDT)
In-Reply-To: <CAJ4mKGa6Mj7PJ8nnij+QcbgdCtCfzuH7POgeXBXyo51CtT91Qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Our documented process is to create a new cephx user (e.g.
client.libvirt) and libvirt / QEMU will then use that client (and its
configuration file settings) since you probably don't want to be
running with admin credentials [1]. You can create a "[client]"
section as a catch-all in addition to user-specific sections like
"[client.libvirt]".

[1] http://docs.ceph.com/docs/master/rbd/libvirt/

On Mon, Aug 1, 2016 at 4:18 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Aug 1, 2016 at 12:25 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> With the new unprivileged user support in Jewel, I'm seeing some
>> issues with logging and file permissions.
>>
>> ceph-ansible always configures client logging on every cluster node, like so:
>>
>>   [client]
>>   log file = /var/log/ceph/qemu-guest-$pid.log
>>
>> As a result, every single client command (eg "ceph health") will
>> create a new root-owned "qemu-guest-$pid" log file (which leads to
>> issues with logrotate failing to rotate the root-owned files in the
>> diretory...)
>>
>> It's clear we need to remove that bit from the ceph.conf files that
>> ceph-ansible writes, but I'm wondering what it *should* be?
>>
>> Is there a more granular way to configure Ceph so that we only log
>> qemu/librbd interactions to qemu-guest-$pid, rather than all client
>> logs?
>
> I don't know the full toolchain these all use (is this for teuthology
> or a wider thing?), but generally:
> * you can specify different config files on the command line when the
> client starts
> * you can specify override config values of any kind on the command
> line when a client starts
> * I believe that QEMU/KVM configs for CephFS let you specify config
> values independently
> * I think(?) you can specify config "sections" based on specific
> client IDs, not just the [client] type
>
> So I'd look into whichever of those options is most convenient. :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
