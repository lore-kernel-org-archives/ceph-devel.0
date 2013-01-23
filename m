From: Cesar Mello <cmello@gmail.com>
Subject: Re: radosgw
Date: Wed, 23 Jan 2013 19:08:37 -0200
Message-ID: <CAJVE5RVuDCXRZTKqs5oRH09+BrJ_nf8XZuuixS944U9-HURPvA@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:63452 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWVIk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:08:40 -0500
Received: by mail-vc0-f170.google.com with SMTP id p16so799757vcq.15
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:08:38 -0800 (PST)
In-Reply-To: <CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

Now that I built from the sources I think I got stuck in this too. The logs:

root@l3:/etc/ceph# cat /var/log/ceph/radosgw.log
2013-01-23 19:05:42.233438 7ff3dae2c780  0 ceph version
0.56-395-g371e6fb (371e6fbed624ececb385663a59dad907e9153d6a), process
radosgw, pid 3811
2013-01-23 19:05:43.937851 7ff3c9ffb700  2 garbage collection: start
2013-01-23 19:06:12.234511 7ff3d2bbe700 -1 Initialization timeout,
failed to initialize
2013-01-23 19:06:17.581501 7f7016801780  0 ceph version
0.56-395-g371e6fb (371e6fbed624ececb385663a59dad907e9153d6a), process
radosgw, pid 3831
2013-01-23 19:06:17.596145 7f70057fa700  2 garbage collection: start
root@l3:/etc/ceph#


On Wed, Jan 23, 2013 at 4:06 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Wed, Jan 23, 2013 at 10:02 AM, Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> wrote:
>> 2013/1/23 Yehuda Sadeh <yehuda@inktank.com>:
>>> try
>>> # radosgw -n client radosgw.gateway
>>
>> Still doesn't work.
>
> whoops, was missing a period there.
>
>>
>> # radosgw -n client radosgw.gateway
>> error parsing 'client': expected string of the form TYPE.ID, valid
>> types are: auth, mon, osd, mds, client
>>
>> # radosgw -n client.radosgw.gateway
>
> That's one step further. What does the log show now?
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
