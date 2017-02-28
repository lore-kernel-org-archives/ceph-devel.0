From: Willem Jan Withagen <wjw@medusa.nl>
Subject: Re: Illegal memory access in rados...
Date: Tue, 28 Feb 2017 19:24:21 +0100
Message-ID: <e9bad50e-5b44-95fe-e8b4-a9380fb6da62@medusa.nl>
References: <58728700-ebf2-cade-d501-d6ccddde4a7d@medusa.nl>
 <alpine.DEB.2.11.1702281648180.22694@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.medusa.nl ([176.74.240.8]:62182 "EHLO smtp.medusa.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdB1SZd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 13:25:33 -0500
In-Reply-To: <alpine.DEB.2.11.1702281648180.22694@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 28-2-2017 17:49, Sage Weil wrote:
> On Tue, 28 Feb 2017, Willem Jan Withagen wrote:
>> I wonder whether this is known? (running FreeBSD)
>>
>> When running:
>> ceph_objectstore_tool.py
> I believe Kefu just fixed this:
>
> 	https://github.com/ceph/ceph/pull/13685
Running to lots of "just fixed"s. :)
Will try

--WjW

> sage
>
>> I keep getting:
>> 3: Wait for health_ok...DONE
>> 3: Created Replicated pool #1
>> 3: Created Erasure coded pool #2
>> 3: Creating 4 objects in replicated pool
>> 3: CRITICAL:Rados put command failed with -11
>>
>> gdb gives me:
>> #0  0x000000080df5bdaa in thr_kill () from /lib/libc.so.7
>> #1  0x000000080df5bd7b in __raise (s=11) at /usr/src/lib/libc/gen/raise.c:52
>> #2  0x00000000004eec36 in reraise_fatal (signum=11) at
>> /home/jenkins/workspace/ceph-master/src/global/signal_handler.cc:74
>> #3  0x00000000004edca9 in handle_fatal_signal (signum=11) at
>> /home/jenkins/workspace/ceph-master/src/global/signal_handler.cc:138
>> #4  0x000000080c140754 in handle_signal (actp=0x7fffdf7ee990, sig=11,
>> info=0x7fffdf7eed80, ucp=0x7fffdf7eea10) at
>> /usr/src/lib/libthr/thread/thr_sig.c:246
>> #5  0x000000080c13fdbf in thr_sighandler (sig=11, info=0x7fffdf7eed80,
>> _ucp=0x7fffdf7eea10) at /usr/src/lib/libthr/thread/thr_sig.c:189
>> #6  <signal handler called>
>> #7  MonClient::build_authorizer (this=0x80f92b060, service_id=16) at
>> memory:2733
>> #8  0x0000000800afdc28 in librados::RadosClient::ms_get_authorizer
>> (this=0x80f92b000, dest_type=16, authorizer=0x7fffdf7eefc8, force_new=false)
>>     at /home/jenkins/workspace/ceph-master/src/librados/RadosClient.cc:63
>> #9  0x000000080233b731 in Messenger::ms_deliver_get_authorizer
>> (this=0x80f908600, peer_type=16, force_new=false) at Messenger.h:722
>> #10 0x000000080237cc1a in AsyncMessenger::get_authorizer
>> (this=0x80f908600, peer_type=16, force_new=false) at AsyncMessenger.h:365
>> #11 0x0000000802359dc2 in AsyncConnection::_process_connection
>> (this=0x81124b800) at
>> /home/jenkins/workspace/ceph-master/src/msg/async/AsyncConnection.cc:1024
>>
>> #7  MonClient::build_authorizer (this=0x80f92b060, service_id=16) at
>> memory:2733
>> 2733            {return __ptr_.first() != nullptr;}
>>
>> But __ptr_ is optimized out. So cehking anything is hard.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

