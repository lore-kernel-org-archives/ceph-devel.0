From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cephfs set_layout - EINVAL - solved
Date: Fri, 9 Aug 2013 21:06:37 +0800
Message-ID: <CAAM7YA=G=upWHPjsq+0WRjwyG88h9MPVRvU4qxSzj5ndPWwdjw@mail.gmail.com>
References: <20130809074457.GA27330@oder.mch.fsc.net>
	<20130809090350.GB27330@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:57685 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab3HINGj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 09:06:39 -0400
Received: by mail-lb0-f180.google.com with SMTP id a16so3216760lbj.11
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 06:06:37 -0700 (PDT)
In-Reply-To: <20130809090350.GB27330@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 9, 2013 at 5:03 PM, Kasper Dieter
<dieter.kasper@ts.fujitsu.com> wrote:
> OK,
> I found this nice page: http://ceph.com/docs/next/dev/file-striping/
> which explains "--stripe_unit --stripe_count --object_size"
>
> But still I'm not sure about
> (1) what is the equivalent command on cephfs to 'rbd create --order 16' ?

you can get/set file layout through virtual xattr. for example:

# getfattr -d -m - targetfile

> (2) how to use those parameters to achieve different optimized layouts on CephFS directories
>     (e.g. for streaming, small sequential IOs, small random IOs)
>

ceph directories are not implemented as files. you can't optimize ceph
directories by this way.

Regards
Yan, Zheng

> -Dieter
>
> On Fri, Aug 09, 2013 at 09:44:57AM +0200, Kasper Dieter wrote:
>> Hi,
>>
>> my goal is to set the 'object size' used in the distribution inside rados
>> in an equal (or similar) way between RBD and CephFS.
>>
>> To set obj_size=64k in RBD I use the command:
>> rbd create --size 1024000 --pool SSD-r2 ssd2-1T-64k --order 16
>>
>> On cephfs set_layout '-s 65536' runs into EINVAL:
>> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 4194304 -c 1
>> Error setting layout: Invalid argument
>>
>> cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 65536 -c 1
>> cephfs /mnt/cephfs/fio-64k/ show_layout
>> layout.data_pool:     3
>> layout.object_size:   65536
>> layout.stripe_unit:   65536
>> layout.stripe_count:  1
>>
>> The man page of cephfs says
>> ---snip---
>>        -u --stripe_unit
>>               Set the size of each stripe
>>
>>        -c --stripe_count
>>               Set the number of objects to stripe across
>>
>>        -s --object_size
>>               Set the size of the objects to stripe across
>> ---snip---
>>
>> What is the equivalent command on cephfs to 'rbd create --order 16' ?
>> Can you please give same explanation how "--stripe_unit --stripe_count --object_size"
>> should be used in combination to achieve different layouts on CephFS directories
>> (e.g. optimized for streaming, small sequential IOs, small random IOs)
>> ?
>>
>> Thanks,
>> -Dieter
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
