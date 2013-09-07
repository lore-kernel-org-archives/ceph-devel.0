From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Sat, 7 Sep 2013 22:11:10 +0200
Message-ID: <CAN04cT4P4ELASm1VoxmHKaje8DHiCpB-bSyMWugjOo19k6j4hg@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
	<CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
	<CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com>
	<CAN04cT6FOspeq0NEN798ChLAJUuXsV2cFnzDLbQVNj0=pO6PPw@mail.gmail.com>
	<CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com>
	<CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43409 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IGULL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Sep 2013 16:11:11 -0400
Received: by mail-oa0-f54.google.com with SMTP id j10so5358765oah.27
        for <ceph-devel@vger.kernel.org>; Sat, 07 Sep 2013 13:11:10 -0700 (PDT)
In-Reply-To: <CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Sep 7, 2013 at 7:47 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
> Oh, and one question about the non-recursive approach. If I stick a
> Makefile.am in the test/ directory I can do things like:
>
>   LDADD = all-the-test-dependencies
>
> and then avoid redundant per-target primaries like test_LDADD = (deps)
> $(LDADD), because it applies to everything in the Makefile.
>
> Is that possible with the include approach, or would a naked LDADD in
> an included Makefile fragment affect all the targets in the file
> including it?

LDADD = xyz would indeed affect all targets. However, it's not
something you want to do anyway; using an _LDADD at a target is less
confusing and less prone to errors because you know exactly what
libraries a target needs.

For instance, in test/Makefile.am you can have a debug target
depending on libglobal, which has dependencies set by libglobal
itself;

CEPH_GLOBAL = $(LIBGLOBAL) $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)

And then in test/Makefile.am;

ceph_test_crypto_SOURCES = test/testcrypto.cc
ceph_test_crypto_LDADD = $(CEPH_GLOBAL)
bin_DEBUGPROGRAMS += ceph_test_crypto

And a unittest also depending on libosd;

unittest_pglog_SOURCES = test/osd/TestPGLog.cc
unittest_pglog_LDADD = $(LIBOSD) $(CEPH_GLOBAL)
check_PROGRAMS += unittest_pglog

However, libosd requires libos and libosdc, but that dependency is set
by libosd;

LIBOSD += $(LIBOSDC) $(LIBOS)

This way, you have the dependencies in the right place. With recusive
builds you'll need an "LDADD = libosd.la libosdc.la libos.la
libglobal.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)", so
basically you're setting the dependencies of the required libraries in
the makefile requiring those libraries, which is IMHO way to complex.

>> I think the benefits of using recursive builds are that it may be
>> familiar to the most people, it reflects the methods/suggestions in
>> the automake manual, and, most importantly, it would seem that its use
>> forces good decomposition where as a non-recursive approach relies on
>> guidelines that are easily broken.

I don't know how which method is more familiar, but I personally think
that anyone understanding recursive automake is capable of
understanding a simple include :-)

The decomposition is a valid argument. I think that there are some
libraries which might benefit from complete separation, like librados
and a "libceph_client" or something like it. Those can be separated,
but most other can't. The mon, mds, os, and osd subdirs have
inter-dependencies for instance.

We might need to restructure the source tree anyway because at some
points it has grown messy (for instance, libcommon including stuff
from mds, mon but also from include). However, I think implementing a
recursive automake right now forces us to do two things at once;
cleanup the makefiles and do some restructuring in the subdirs. I
personally think it's best to start with cleaning up makefiles and use
an include per subdir, so we can restructure the subdirs into
segregated libraries later on.

So I all boils down to; what to do first :-) Because I agree some
things are better of with recursive builds, but it might be wise not
to do that before we have revisited the source tree layout.

Roald
