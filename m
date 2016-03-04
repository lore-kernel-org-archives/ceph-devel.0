From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: ceph mon failed to restart
Date: Fri, 4 Mar 2016 14:26:16 +0530
Message-ID: <CANA9Uk5NunzikNVvWe5REppEjSWcr4CXeTyJQr-+zsv45KSErw@mail.gmail.com>
References: <CANA9Uk7foqUXQkbVBerBdHothy91CzohWeW+NfYMdtaTqHXwOw@mail.gmail.com>
	<56D804BD.1010806@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34618 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbcCDI4R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 03:56:17 -0500
Received: by mail-vk0-f51.google.com with SMTP id e185so47631132vkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 00:56:17 -0800 (PST)
In-Reply-To: <56D804BD.1010806@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This issue was fixed...by removing the mon (clean remove) from the
cluster and add it again.

Thanks
Swami

On Thu, Mar 3, 2016 at 3:02 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 03/03/2016 09:30 AM, M Ranga Swami Reddy wrote:
>>
>> I have tried to restart the one of the ceph mon , got the below error:
>> ==
>>
>> 2016-03-03 08:16:00.120355 7f43b067d7c0 -1 obtain_monmap unable to find a
>> monmap
>>
>> 2016-03-03 08:16:00.120374 7f43b067d7c0 -1 unable to obtain a monmap:
>> (2) No such file or directory
>>
>> 2016-03-03 08:16:00.124437 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
>> not in monmap and have been in a quorum before; must have been removed
>>
>> 2016-03-03 08:16:00.124715 7f43b067d7c0 -1 mon.node-11@-1(probing) e0
>> commit suicide!
>>
>> 2016-03-03 08:16:00.124727 7f43b067d7c0 -1 failed to initialize
>>
>> failed: 'ulimit -n 32768;  /usr/bin/ceph-mon -i node-11 --pid-file
>> /var/run/ceph/mon.node-11.pid -c /etc/ceph/ceph.conf --cluster ceph '
>>
>> Starting ceph-create-keys on node-11...
>> ===
>>
>> Any hint appriciated...
>
>
> Which Ceph version are you running?
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
