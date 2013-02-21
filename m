From: Travis Rhoden <trhoden@gmail.com>
Subject: Able to crash mon with invalid command
Date: Thu, 21 Feb 2013 12:11:23 -0500
Message-ID: <CACkq2motaanU4NNWFPYXGQuisJwnRPTJB556j22fWRLove772w@mail.gmail.com>
References: <CACkq2mpBFukD0kSQm6TArLNXGYMTuZDV7XF0tCXsN_qLR7cgKA@mail.gmail.com>
 <CACkq2mrxHsoi03DyQDgFCT=rHUPhnSg67dmAePyfAc-uLmP4eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54738 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab3BURLs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 12:11:48 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so9226883oag.25
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 09:11:46 -0800 (PST)
In-Reply-To: <CACkq2mrxHsoi03DyQDgFCT=rHUPhnSg67dmAePyfAc-uLmP4eA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I threw this at ceph-users yesterday, but no responses.  It is
probably a better candidate for ceph-devel anyhow:

I typed in the following command and it crashed one of my monitors:

# ceph quorum
2013-02-20 18:22:59.327916 7f908186f700  0 monclient: hunting for new mon
unknown quorum subcommand; use exit or enter

# ceph -s
   health HEALTH_WARN 1 mons down, quorum 0,1,3,4 a,b,d,e

Log from ceph-mon.c.log:

    -1> 2013-02-20 18:22:57.594190 7f92d84db700  0 mon.c@2(peon) e1
handle_command mon_command(quorum v 0) v1
     0> 2013-02-20 18:22:57.721764 7f92d84db700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f92d84db700

 ceph version 0.56.3 (6eb7e15a4783b122e9b0c85ea9ba064145958aa5)
 1: /usr/bin/ceph-mon() [0x5379da]
 2: (()+0xfcb0) [0x7f92dd8cecb0]
 3: (std::string::compare(char const*) const+0x2c) [0x7f92dcfe382c]
 4: (bool std::operator==<char, std::char_traits<char>,
std::allocator<char> >(std::basic_string<char, std::char_traits<char>,
std::allocator<char> > const&, char const*)+0x9) [0x488919]
 5: (Monitor::handle_command(MMonCommand*)+0x13a8) [0x4741e8]
 6: (Monitor::_ms_dispatch(Message*)+0x103b) [0x484bcb]
 7: (Monitor::ms_dispatch(Message*)+0x32) [0x4945c2]
 8: (DispatchQueue::entry()+0x349) [0x63d009]
 9: (DispatchQueue::DispatchThread::entry()+0xd) [0x5d67bd]
 10: (()+0x7e9a) [0x7f92dd8c6e9a]
 11: (clone()+0x6d) [0x7f92dc767cbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

I had meant to do "ceph quorum_status".  doh.
Version is 0.56.3 all around

Looking at the source code, it is a valid command -- and the monitor
correctly responded that it needed either "exit" or "enter" after the
command.  I don't know why it segfaulted, though.  I've tried it again
a couple of times since, and no segfaults.

 - Travis
