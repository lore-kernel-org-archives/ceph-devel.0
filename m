From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Fwd: Re: [ceph-users] Able to crash mon with invalid command
Date: Thu, 21 Feb 2013 17:47:50 +0000
Message-ID: <51265DC6.1050109@inktank.com>
References: <51265B08.5000901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42896 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab3BURsS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 12:48:18 -0500
Received: by mail-wi0-f172.google.com with SMTP id ez12so7863060wid.5
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 09:48:17 -0800 (PST)
In-Reply-To: <51265B08.5000901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

Forgot to cross-post this to ceph-devel.


-------- Original Message --------
Subject: Re: [ceph-users] Able to crash mon with invalid command
Date: Thu, 21 Feb 2013 17:36:08 +0000
From: Joao Eduardo Luis <joao.luis@inktank.com>
To: Travis Rhoden <trhoden@gmail.com>
CC: ceph-users@ceph.com

On 02/21/2013 05:33 PM, Joao Eduardo Luis wrote:
> On 02/20/2013 06:39 PM, Travis Rhoden wrote:
>> Actually, looking at the source code, that is a valid command -- and the
>> monitor correctly responded that it needed either "exit" or "enter"
>> after the command.  I don't know why it segfaulted, though.
>
> By far the weirdest segfault I've seen in a while.
>
> Will look into this and report back.
>
> Thanks!
>
>    -Joao

Oh, not weird at all.  We're trying to read the next position in the
array without even checking if it exists.  I'll have a fix in a minute
or so.

Thanks again!

   -Joao

>
>>
>> On Wed, Feb 20, 2013 at 1:31 PM, Travis Rhoden <trhoden@gmail.com
>> <mailto:trhoden@gmail.com>> wrote:
>>
>>     I typed in the following command and it crashed one of my monitors:
>>
>>     # ceph quorum
>>     2013-02-20 18:22:59.327916 7f908186f700  0 monclient: hunting for
>>     new mon
>>     unknown quorum subcommand; use exit or enter
>>
>>     # ceph -s
>>         health HEALTH_WARN 1 mons down, quorum 0,1,3,4 a,b,d,e
>>
>>     Log from ceph-mon.c.log:
>>
>>          -1> 2013-02-20 18:22:57.594190 7f92d84db700  0 mon.c@2(peon) e1
>>     handle_command mon_command(quorum v 0) v1
>>           0> 2013-02-20 18:22:57.721764 7f92d84db700 -1 *** Caught
>>     signal (Segmentation fault) **
>>       in thread 7f92d84db700
>>
>>       ceph version 0.56.3 (6eb7e15a4783b122e9b0c85ea9ba064145958aa5)
>>       1: /usr/bin/ceph-mon() [0x5379da]
>>       2: (()+0xfcb0) [0x7f92dd8cecb0]
>>       3: (std::string::compare(char const*) const+0x2c) [0x7f92dcfe382c]
>>       4: (bool std::operator==<char, std::char_traits<char>,
>>     std::allocator<char> >(std::basic_string<char,
>>     std::char_traits<char>, std::allocator<char> > const&, char
>>     const*)+0x9) [0x488919]
>>       5: (Monitor::handle_command(MMonCommand*)+0x13a8) [0x4741e8]
>>       6: (Monitor::_ms_dispatch(Message*)+0x103b) [0x484bcb]
>>       7: (Monitor::ms_dispatch(Message*)+0x32) [0x4945c2]
>>       8: (DispatchQueue::entry()+0x349) [0x63d009]
>>       9: (DispatchQueue::DispatchThread::entry()+0xd) [0x5d67bd]
>>       10: (()+0x7e9a) [0x7f92dd8c6e9a]
>>       11: (clone()+0x6d) [0x7f92dc767cbd]
>>       NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>     needed to interpret this.
>>
>>     I had meant to do "ceph quorum_status".  doh.
>>     Version is 0.56.3 all around
>>
>>       - Travis
>>
>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>



