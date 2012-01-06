From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Thu, 5 Jan 2012 20:09:26 -0800
Message-ID: <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
References: <4EEFF614.8040207@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53191 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2AFEJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 23:09:28 -0500
Received: by wibhm6 with SMTP id hm6so826511wib.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 20:09:27 -0800 (PST)
In-Reply-To: <4EEFF614.8040207@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Dec 19, 2011 at 6:42 PM, Mark Kampe <mark.kampe@dreamhost.com> =
wrote:
> I'd like to keep this ball moving ... as I believe that the
> limitations of our current logging mechanisms are already
> making support difficult, and that is about to become worse.
>
> As a first step, I'd just like to get opinions on the general
> requirements we are trying to satisfy, and decisions we have
> to make along the way.
>
> Comments?
>
> I Requirements
>
> =A0A. Primary Requirements (must have)
> =A0 =A0 1. information captured
> =A0 =A0 =A0 =A0a. standard: time, sub-system, level, proc/thread

We already do capture all this stuff, just not efficiently.

One easy way to get a lot of efficiency would be to add a thread-local
variable to store the thread name / ID.

Getting the system time is a surprisingly expensive operation, and
this poses a problem for logging system designers.  You can use the
rdtsc CPU instruction, but unfortunately on some architectures CPU
frequency scaling makes it very inaccurate.  Even when it is accurate,
it's not synchronized between multiple CPUs.

Another option is to without time for most messages and just have a
periodic timestamp that gets injected every so often-- perhaps every
second, for example.

> =A0 =A0 =A0 =A0b. additional: operation and parameters
> =A0 =A0 =A0 =A0c. extensible for new operations
> =A0 =A0 2. efficiency
> =A0 =A0 =A0 =A0a. run time overhead < 1%
> =A0 =A0 =A0 =A0 =A0 (I believe this requires delayed flush circular b=
ufferring)

The current code could be changed to support delayed flush without too
much trouble.  In order to do that:

1. The message timestamp needs to be added by dout() rather than by
DoutStreambuf::overflow()

2. dendl needs to stop flushing the stream.  This part is simple...
just change the dendl macro to add "\n" rather than std::endl.

3. A signal handler needs to be added that flushes the dout stream
before program exit.

#1 is probably the most complex part.

I never added support for delayed flush because I was afraid that it
would prevent us from debugging bugs which killed processes without
triggering the signal handlers.  For example, when a process is killed
by the OOM killer, it does not get a chance to clean up, and so the
logs will be incomplete unless they are being continuously flushed.

Perhaps Ceph has matured to the point where this makes sense to add,
at least as an option.

> =A0 =A0 =A0 =A0b. persistent space O(Gigabytes per node-year)
> =A0 =A0 3. configurability
> =A0 =A0 =A0 =A0a. capture level per sub-system
> =A0 =A0 4. persistence
> =A0 =A0 =A0 =A0a. flushed out on process shut-down
> =A0 =A0 =A0 =A0b. recoverable from user-mode core-dumps
> =A0 =A0 5. presentation
> =A0 =A0 =A0 =A0a. output can be processed w/grep,less,...
>
> =A0B. Secondary Requirements (nice to have)
> =A0 =A0 1. ease of use
> =A0 =A0 =A0 =A0a. compatible with/convertable from existing calls
> =A0 =A0 =A0 =A0b. run-time definition of new event records
> =A0 =A0 2. configurability
> =A0 =A0 =A0 =A0a. size/rotation rules per sub-system
> =A0 =A0 =A0 =A0b. separate in-memory/on-disk capture levels
>
> II Decisions to be made
>
> =A0 A. Capture Circumstances
> =A0 =A0 =A01. some subset of procedure calls
> =A0 =A0 =A0 =A0 (I'm opposed to this, but it is an option)

Logging all function calls is very slow.  Trust me on this, I wrote a
profiler that did this once...  I used -finstrument-functions.

> =A0 =A0 =A02. explicit event logging calls
>
> =A0 B. Capture Format
> =A0 =A0 =A01. ASCII text
> =A0 =A0 =A02. per-event binary format
> =A0 =A0 =A03. binary header + ASCII text
>
> =A0 C. Synchronization
> =A0 =A0 =A01. per-process vs per-thread buffers
>
> =A0 D. Flushing
> =A0 =A0 =A01. last writer flushes vs dedicated thread
> =A0 =A0 =A02. single- vs double-bufferred output
>
> =A0 E. Available open source candidates

Pantheios and log4cpp are two potential candidates.  I don't know that
much about either, unfortunately.

Honestly, I feel like logging is something that you will end up
customizing pretty extensively to suit the needs of your application.
But perhaps it's worth checking out what these libraries provide--
especially in terms of efficiency.

The biggest efficiency killer in logging right now is that dout lock.
However, even if that lock was replaced by an atomic operation, there
would still be the issue of cacheline ping-pong to contend with.  In
order to scale to the hundred-core systems of the future, you have to
get rid of that shared state.

P.S. Happy new year.

cheers,
Colin


>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
