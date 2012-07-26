From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Setting a big maxosd kills all mons
Date: Thu, 26 Jul 2012 14:11:45 -0700
Message-ID: <CAC-hyiHZBx6P1b1WA4zcg6+Y4U9X1oU9yM_WXL9=bbf_vZDNig@mail.gmail.com>
References: <CAPUexz9EHLsEvSCrw40U6L9zP=yWA6S81GCoeoBwXutPzxm9Cw@mail.gmail.com>
	<CAPYLRzhqbsKzR_TtAxKAV8t71aeHc29hSoqWUwi82bfXBcf_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46172 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2GZVLq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 17:11:46 -0400
Received: by bkwj10 with SMTP id j10so1533573bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 14:11:45 -0700 (PDT)
In-Reply-To: <CAPYLRzhqbsKzR_TtAxKAV8t71aeHc29hSoqWUwi82bfXBcf_-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 10:49 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Jul 5, 2012 at 10:39 AM, Florian Haas <florian@hastexo.com> wrote:
>> Hi guys,
>>
>> Someone I worked with today pointed me to a quick and easy way to
>> bring down an entire cluster, by making all mons kill themselves in
>> mass suicide:
>>
>> ceph osd setmaxosd 2147483647
>> 2012-07-05 16:29:41.893862 b5962b70  0 monclient: hunting for new mon
> Ungh. Can you file a bug report? The problem here is that the monitor
> is trying to allocate a number of maps and arrays with that many
> entries; we probably need to put an artificial cap in place as a
> config option.
>
>
>> I don't know what the actual threshold is, but setting your maxosd to
>> any sufficiently big number should do it. I had hoped 2^31-1 would be
>> fine, but evidently it's not.
>>
>> This is what's in the mon log -- the first line is obviously only on
>> the leader at the time of the command, the others are on all mons.
>>
>>     -1> 2012-07-05 16:29:41.829470 b41a1b70  0 mon.daisy@0(leader) e1
>> handle_command mon_command(osd setmaxosd 2147483647 v 0) v1
>>      0> 2012-07-05 16:29:41.887590 b41a1b70 -1 *** Caught signal (Aborted) **
>>  in thread b41a1b70
>>
>>  ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>>  1: /usr/bin/ceph-mon() [0x816f461]
>>  2: [0xb7738400]
>>  3: [0xb7738424]
>>  4: (gsignal()+0x51) [0xb731a781]
>>  5: (abort()+0x182) [0xb731dbb2]
>>  6: (__gnu_cxx::__verbose_terminate_handler()+0x14f) [0xb753b53f]
>>  7: (()+0xbd405) [0xb7539405]
>>  8: (()+0xbd442) [0xb7539442]
>>  9: (()+0xbd581) [0xb7539581]
>>  10: (()+0x11dea) [0xb7582dea]
>>  11: (tc_new()+0x26) [0xb75a1636]
>>  12: (std::vector<unsigned char, std::allocator<unsigned char>
>>>::_M_fill_insert(__gnu_cxx::__normal_iterator<unsigned char*,
>> std::vector<unsigned char, std::allocator<unsigned char> > >, unsigned
>> int, unsigned char const&)+0x79) [0x8185629]
>>  13: (OSDMap::set_max_osd(int)+0x497) [0x817c6b7]
>>
>> From src/mon/OSDMonitor.cc:
>>
>>       int newmax = atoi(m->cmd[2].c_str());
>>       if (newmax < osdmap.crush->get_max_devices()) {
>>         err = -ERANGE;
>>         ss << "cannot set max_osd to " << newmax << " which is < crush
>> max_devices "
>>            << osdmap.crush->get_max_devices();
>>         goto out;
>>       }
>>
>> I think that counts as unchecked user input, or has cmd[2] been
>> sanitized at any time before it gets here?
>
> Yeah, there's all kinds of unsanitized user input in the monitor
> command-parsing code.
>
Pushed wip-2752, set a configurable max osd cap.

Yehuda
