From: Laurent GUERBY <laurent@guerby.net>
Subject: Re: GCC -msse2 portability question
Date: Sun, 23 Mar 2014 23:34:30 +0100
Message-ID: <1395614070.15058.140.camel@pc2>
References: <532F3B0E.2050204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lists.tetaneutral.net ([91.224.149.207]:40633 "EHLO
	lists.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaCWWlv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Mar 2014 18:41:51 -0400
In-Reply-To: <532F3B0E.2050204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 2014-03-23 at 20:50 +0100, Loic Dachary wrote:
> Hi Laurent,
> 
> In the context of optimizing erasure code functions implemented by
> Kevin Greenan (cc'ed) and James Plank at
> https://bitbucket.org/jimplank/gf-complete/ we ran accross a question
> you may have the answer to: can gcc -msse2 (or -msse* for that matter
> ) have a negative impact on the portability of the compiled binary
> code ? 
> 
> In other words, if a code is compiled without -msse* and runs fine on
> all intel processors it targets, could it be that adding -msse* to the
> compilation of the same source code generate a binary that would fail
> on some processors ? This is assuming no sse specific functions were
> used in the source code.
> 
> In gf-complete, all sse specific instructions are carefully protected
> to not be run on a CPU that does not support them. The runtime
> detection is done by checking CPU id bits ( see
> https://bitbucket.org/jimplank/gf-complete/pull-request/7/probe-intel-sse-features-at-runtime/diff#Lsrc/gf_intel.cT28 )
> 
> The corresponding thread is at:
> 
> https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-the-decision-to-use-a-given-sse/diff#comment-1479296
> 
> Cheers
> 

Hi Loic,

The GCC documentation is here with lists of architecture supporting
sse/sse2:

http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options

So unless you want to run your code a very very old x86 32 bit processor
"-msse" shouldn't be an issue. "-msse2" is similar.

-mtune=xxx with xxx being a recent arch could be interesting for you
because it keeps compatibility with the generic arch while tuning
resulting code on the specific arch (for example the current fashionable
arch like corei7).

For alibrary you can choose the code you execute a load/run time
for a specific function by using the STT_GNU_IFUNC feature :

http://vger.kernel.org/~davem/cgi-bin/blog.cgi/2010/02/07
http://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/Function-Attributes.html#index-g_t_0040code_007bifunc_007d-attribute-2529

I believe recent GLIBC use this feature to tune
some performance/arch sensitive functions.

Sincerely,

Laurent


