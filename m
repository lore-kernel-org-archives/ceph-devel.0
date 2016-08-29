From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: debugging librbd to a VM
Date: Tue, 30 Aug 2016 09:12:46 +1000
Message-ID: <CAF-wwdHOjAXXUt+-ehKEPYV9Ldte7U48fyCsTUdVUcTkXiohxg@mail.gmail.com>
References: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
 <20160829080314.GA1733@gmail.com> <CAF-wwdFbgk_WcYQbEteGuCPF-b=WkX9ZpdACR01+GRoZCHB6=A@mail.gmail.com>
 <MWHPR12MB1934B4AFE9933CF16FFF2E5E9BE10@MWHPR12MB1934.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37023 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbcH2XMv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 19:12:51 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so8244214wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 16:12:49 -0700 (PDT)
In-Reply-To: <MWHPR12MB1934B4AFE9933CF16FFF2E5E9BE10@MWHPR12MB1934.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Mykola Golub <mgolub@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 30, 2016 at 8:53 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
> So in my case what would $name be?

OK. To begin with just hard code a consistent name.

/var/log/ceph/rbd.log

Use that in the conf file, touch it and chmod it then restart you qemu
instance (don't
just restart the VM).

>
> -- Tom
>
>> -----Original Message-----
>> From: Brad Hubbard [mailto:bhubbard@redhat.com]
>> Sent: Monday, August 29, 2016 5:29 PM
>> To: Mykola Golub <mgolub@mirantis.com>
>> Cc: Deneau, Tom <tom.deneau@amd.com>; ceph-devel@vger.kernel.org
>> Subject: Re: debugging librbd to a VM
>>
>> On Mon, Aug 29, 2016 at 6:03 PM, Mykola Golub <mgolub@mirantis.com> wrote:
>> > May be qemu does not see you ceph.conf? Or some other environmental
>> > issue (e.g. with qemu rbd driver). Try
>> >
>> > ldd /usr/bin/qemu-system-x86_64 |grep rbd
>> >
>> > Have you tried starting it from command line?
>> >
>> > You could check if config debug options work as expected setting them
>> > on your working cluster.
>>
>> You can also try "touch /tmp/cbt/ceph/log/$name.log" and "chmod 777
>> /tmp/cbt/ceph/log/$name.log" to eliminate permissions issues.
>>
>> >
>> > On Fri, Aug 26, 2016 at 09:08:30PM +0000, Deneau, Tom wrote:
>> >> I have two small clusters configured with the same version of Ceph and
>> the same OS version.
>> >> (different processor hardware)
>> >>
>> >> On these clusters I have bootable RBD images that I expect a VM to boot
>> from.
>> >> On one cluster, the VM does not boot from the image.  On the other
>> cluster, it boots fine.
>> >> On the failing cluster, a VM can boot fine from the base qcow2 image
>> from which the rbd image was created.  It's only rbd images that are
>> causing problems for the VM.
>> >>
>> >> I would like to enable some debug logging that could tell where the two
>> clusters are diverging.
>> >>
>> >> I tried adding
>> >>         debug rbd = 20
>> >>         log file = /tmp/cbt/ceph/log/$name.log
>> >>
>> >> I do see some rbd debug messages to stderr during operations like rbd
>> clone, etc. but I don't see any log files created in /tmp/cbt/ceph or
>> /var/log/ceph or any messages when librbd is being used by say qemu-img
>> convert, or by qemu-kvm.
>> >>
>> >> Is there a way to see detailed debug messages for librbd?
>> >>
>> >> Or is there a better way to see where things are diverging between
>> these two clusters?
>> >> (note: I tried lttng but could not get it to record anything)
>> >>
>> >> -- Tom
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >> in the body of a message to majordomo@vger.kernel.org More majordomo
>> >> info at  http://vger.kernel.org/majordomo-info.html
>> >
>> > --
>> > Mykola Golub
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Cheers,
>> Brad



-- 
Cheers,
Brad
