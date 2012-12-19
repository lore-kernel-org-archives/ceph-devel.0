From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: Re: ceph stability
Date: Wed, 19 Dec 2012 16:58:25 +0600
Message-ID: <CAD5ewrrq4A20rZ23FYM17k3qTSR7Dxzyt-9KuOu8YW+vTEAe-g@mail.gmail.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
	<50D19201.404@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:59706 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2LSL2R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 06:28:17 -0500
Received: by mail-vb0-f42.google.com with SMTP id fa15so2158873vbb.29
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 03:28:16 -0800 (PST)
In-Reply-To: <50D19201.404@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

Hello Joao,

 thanks for feedback. is this fix available on the svn? i can provide
heavy testing for it.

2012/12/19 Joao Eduardo Luis <joao.luis@inktank.com>:
> On 12/19/2012 09:03 AM, Roman Hlynovskiy wrote:
>>
>> My first problem - I am getting spurious mon's deaths, which usually
>> looks like this:
>>
>> --- begin dump of recent events ---
>>       0> 2012-12-19 10:35:58.912119 b41eab70 -1 *** Caught signal
>> (Aborted) **
>>   in thread b41eab70
>>
>>   ceph version 0.55.1 (8e25c8d984f9258644389a18997ec6bdef8e056b)
>>   1: /usr/bin/ceph-mon() [0x8183a11]
>>   2: [0xb7714400]
>>   3: (gsignal()+0x47) [0xb7337577]
>>   4: (abort()+0x182) [0xb733a962]
>>   5: (__gnu_cxx::__verbose_terminate_handler()+0x14f) [0xb755653f]
>>   6: (()+0xbd405) [0xb7554405]
>>   7: (()+0xbd442) [0xb7554442]
>>   8: (()+0xbd581) [0xb7554581]
>>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x80f) [0x824cabf]
>>   10: /usr/bin/ceph-mon() [0x80e3c1d]
>>   11: (MDSMonitor::tick()+0x1e3b) [0x811ea0b]
>>   12: (MDSMonitor::on_active()+0x1d) [0x81188dd]
>>   13: (PaxosService::_active()+0x212) [0x80e4b02]
>>   14: (Context::complete(int)+0x19) [0x80c4cf9]
>>   15: (finish_contexts(CephContext*, std::list<Context*,
>> std::allocator<Context*> >&, int)+0x13f) [0x80d208f]
>>   16: (Monitor::recovered_leader(int)+0x3ac) [0x80ac5ac]
>>   17: (Paxos::handle_last(MMonPaxos*)+0xb02) [0x80e0572]
>>   18: (Paxos::dispatch(PaxosServiceMessage*)+0x2c4) [0x80e0e94]
>>   19: (Monitor::_ms_dispatch(Message*)+0x1181) [0x80c3b11]
>>   20: (Monitor::ms_dispatch(Message*)+0x31) [0x80d5021]
>>   21: (DispatchQueue::entry()+0x337) [0x82afa47]
>>   22: (DispatchQueue::DispatchThread::entry()+0x20) [0x823eec0]
>>   23: (Thread::_entry_func(void*)+0x11) [0x824be41]
>>   24: (()+0x57b0) [0xb75ef7b0]
>>   25: (clone()+0x5e) [0xb73d8cde]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>
>
> http://tracker.newdream.net/issues/3495
>
> Should be fixed in latest master, but the latest patch didn't make it to
> v0.55.1.
>
>   -Joao



-- 
...WBR, Roman Hlynovskiy
