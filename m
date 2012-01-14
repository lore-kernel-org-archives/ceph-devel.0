From: Sage Weil <sage@newdream.net>
Subject: Re: 0.40 OSD - Address family not supported by protocol
Date: Sat, 14 Jan 2012 09:28:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201140923530.2935@cobra.newdream.net>
References: <20120114145550.GN4585@rcn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33846 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab2ANR27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 12:28:59 -0500
In-Reply-To: <20120114145550.GN4585@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Pieper <jjp@pobox.com>
Cc: ceph-devel@vger.kernel.org

Hi Josh,

On Sat, 14 Jan 2012, Josh Pieper wrote:
> I just upgraded our test cluster to 0.40, and immediately after
> starting up get asserts in all the OSDs.  I've inlined a relevant
> backtrace below, is there anything else that would be useful for
> debugging?

Are you coming from 0.39 or something older?

You might try reverting 4728f4f8e09878c583c65cd882e031d37f8d903e and see 
if that does it..

Can you reproduce it with --debug-osd 10 and --debug-ms 10?

sage

> 
> Our test cluster is 3 ubuntu 11.10 amd64 machines, each with a mon and
> osd.
> 
> Looking at an strace, it is pretty clearly asking for an invalid
> address family, although I'm not sure where it is coming from.
> 
> [pid 30648] socket(PF_UNSPEC, SOCK_STREAM, 0 <unfinished ...>
> [pid 30648] <... socket resumed> )      = -1 EAFNOSUPPORT (Address family not supported by protocol)
> 
> -Josh
> 
> -------
> 2012-01-14 09:31:03.395266 7f67edf08700 -- 10.1.10.71:6801/27529 >> 10.1.10.73:6801/8127 pipe(0x14e0780 sd=19 pgs=0 cs=0 l=0).connect claims to be 10.1.10.73:6801/24029 not 10.1.10.73:6801/8127 - wrong node!
> 2012-01-14 09:31:03.395579 7f67ede07700 -- :/27530 >> :/0 pipe(0x14e0500 sd=-1 pgs=0 cs=0 l=0).connect couldn't created socket Address family not supported by protocol
> msg/SimpleMessenger.cc: In function 'int SimpleMessenger::Pipe::connect()', in thread '7f67ede07700'
> msg/SimpleMessenger.cc: 1038: FAILED assert(0)
>  ceph version 0.40 (commit:7eea40ea37fb3a68a2042a2218c9b8c9c40a843e)
>  1: (SimpleMessenger::Pipe::connect()+0x87c) [0x5be81c]
>  2: (SimpleMessenger::Pipe::writer()+0x456) [0x5c1536]
>  3: (SimpleMessenger::Pipe::Writer::entry()+0xd) [0x4b228d]
>  4: (()+0x7efc) [0x7f67ffdf4efc]
>  5: (clone()+0x6d) [0x7f67fe42589d]
>  ceph version 0.40 (commit:7eea40ea37fb3a68a2042a2218c9b8c9c40a843e)
>  1: (SimpleMessenger::Pipe::connect()+0x87c) [0x5be81c]
>  2: (SimpleMessenger::Pipe::writer()+0x456) [0x5c1536]
>  3: (SimpleMessenger::Pipe::Writer::entry()+0xd) [0x4b228d]
>  4: (()+0x7efc) [0x7f67ffdf4efc]
>  5: (clone()+0x6d) [0x7f67fe42589d]
> *** Caught signal (Aborted) **
>  in thread 7f67ede07700
>  ceph version 0.40 (commit:7eea40ea37fb3a68a2042a2218c9b8c9c40a843e)
>  1: /usr/bin/ceph-osd() [0x5fd926]
>  2: (()+0x10060) [0x7f67ffdfd060]
>  3: (gsignal()+0x35) [0x7f67fe37a3a5]
>  4: (abort()+0x17b) [0x7f67fe37db0b]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f67fec38d7d]
>  6: (()+0xb9f26) [0x7f67fec36f26]
>  7: (()+0xb9f53) [0x7f67fec36f53]
>  8: (()+0xba04e) [0x7f67fec3704e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x193) [0x5cfd33]
>  10: (SimpleMessenger::Pipe::connect()+0x87c) [0x5be81c]
>  11: (SimpleMessenger::Pipe::writer()+0x456) [0x5c1536]
>  12: (SimpleMessenger::Pipe::Writer::entry()+0xd) [0x4b228d]
>  13: (()+0x7efc) [0x7f67ffdf4efc]
>  14: (clone()+0x6d) [0x7f67fe42589d]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
