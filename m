From: Laurent GUERBY <laurent@guerby.net>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 10:43:25 +0100
Message-ID: <1395740605.15058.205.camel@pc2>
References: <532F3B0E.2050204@dachary.org> <1395614070.15058.140.camel@pc2>
	 <5330A328.9060203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lists.tetaneutral.net ([91.224.149.207]:48326 "EHLO
	lists.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaCYJnd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 05:43:33 -0400
In-Reply-To: <5330A328.9060203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 2014-03-24 at 22:27 +0100, Loic Dachary wrote:
> 
> On 23/03/2014 23:34, Laurent GUERBY wrote:
> > http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options
> > 
> > So unless you want to run your code a very very old x86 32 bit processor
> > "-msse" shouldn't be an issue. "-msse2" is similar.
> 
> This is good to know :) Should I be worried about unintended side effects of -msse4.2 -mssse3 -msse4.1 or -mpclmul ? These are the flags that gf-complete are using, specifically.

Hi,

SSE4.2 will be available only in more recent
processors as documented on the page above.

If your library already is dynamically checking for processor
feature I would advise to be conservative in your
-m flags, ie using what debian would use for maximum
x86 portability.

Sincerely,

Laurent

