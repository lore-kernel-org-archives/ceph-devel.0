From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 15:28:20 +0100
Message-ID: <226f223c-88d6-1d94-410a-482479c54691@digiware.nl>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
 <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50581 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdAWO2Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Jan 2017 09:28:25 -0500
In-Reply-To: <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, Ming Lin <minggr@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 23-1-2017 14:12, kefu chai wrote:
> On Mon, Jan 23, 2017 at 1:32 PM, Ming Lin <minggr@gmail.com> wrote:
>> Hi,
>>
>> [mon]
>> mon initial members = a
>>
>> [mon.a]
>> mon addr = 192.168.0.1:7000
>>
>> jewel release with 1 monitor and 3 OSDs.
>>
>> After hours of fio rbd test, the monitor binded port(7000) was closed
>> for unknown reason.
> 
> is this reproduciable? can you enable ms-debug=1 and attach the log?
> 
>> But monitor is still running,
>>
>> # pidof ceph-mon
>> 21980
>>
>> Another strange thing is there are more than 1000 threads for the
>> ceph-mon process.
>>
>> # ls /proc/21980/task/ |wc -l
>> 1022
>>
>> Any possible reason?
> 
> are you using the simple messenger? maybe you can use pstree to check
> the thread names?

Other nice tools to help you here to see where the socket has gone:
	sockstat
	lsof

They can tell you if the socket is somewhere else opened.
And what the state is.

Or they can tell you what other port(s) the monitor has opened.

Also note that recycling thru large numbers of ports does not always
goes well with the TCPstack. That is why there is the options:
     SO_REUSEADDR       enables local address reuse
     SO_REUSEPORT       enables duplicate address and port bindings

But then still you might run out of ports if too many are left in a WAIT
state.

--WjW

