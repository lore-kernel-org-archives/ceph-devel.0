From: John Spray <john.spray@redhat.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 18:01:16 +0000
Message-ID: <54EF5F6C.8030305@redhat.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>	<54EF527B.8060403@redhat.com>	<CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>	<54EF5CF0.3030503@redhat.com> <CAGbvivKiuJ1UrACb2W_fX+8TFDvJ0XrayGYXjL3qGRWZMCPSYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbbBZSBU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 13:01:20 -0500
In-Reply-To: <CAGbvivKiuJ1UrACb2W_fX+8TFDvJ0XrayGYXjL3qGRWZMCPSYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: ceph-devel@vger.kernel.org

On 26/02/2015 17:58, Wyllys Ingersoll wrote:
> Yeah, I noticed that too, so I recreated both of those pools and it
> still wont start. It crashes in a different place now, but still wont
> start, even after running 'newfs'.  Attached is the debug log output
> when I start ceph-mds
>
> ...
> common/Thread.cc: In function 'int Thread::join(void**)' thread
> 7f0127612700 time 2015-02-26 07:55:09.734802
> common/Thread.cc: 141: FAILED assert(status == 0)
>   ceph version 0.80.8 (69eaad7f8308f21573c604f121956e64679a52a7)
>   1: (Thread::detach()+0) [0x8c30d0]
>   2: (MonClient::shutdown()+0x50f) [0x881d5f]
>   3: (MDS::suicide()+0xe5) [0x576285]
>   4: (MDLog::handle_journaler_write_error(int)+0x5f) [0x7aab2f]
>   5: (Context::complete(int)+0x9) [0x56d9a9]
>   6: (Journaler::handle_write_error(int)+0x5e) [0x7b949e]
>   7: (Journaler::_finish_write_head(int, Journaler::Header&,
> Context*)+0x306) [0x7b9946]
>   8: (Context::complete(int)+0x9) [0x56d9a9]
>   9: (Objecter::check_op_pool_dne(Objecter::Op*)+0x214) [0x7ce6a4]
>   10: (Objecter::C_Op_Map_Latest::finish(int)+0x124) [0x7cea04]
>   11: (Context::complete(int)+0x9) [0x56d9a9]
>   12: (Finisher::finisher_thread_entry()+0x1b8) [0x9aced8]
>   13: (()+0x8182) [0x7f012db95182]
>   14: (clone()+0x6d) [0x7f012c50befd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> 2015-02-26 07:55:09.736256 7f0127612700 -1 common/Thread.cc: In
> function 'int Thread::join(void**)' thread 7f0127612700 time
> 2015-02-26 07:55:09.734802
> common/Thread.cc: 141: FAILED assert(status == 0)
That is still looking like a missing pool (the check_op_pool_dne frame 
in the trace).  Can you post "ceph osd dump" and "ceph mds dump"?

John
