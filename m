From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Ceph code coverage integration proposal
Date: Thu, 02 Jun 2011 14:09:26 -0700
Message-ID: <4DE7FC06.9020704@dreamhost.com>
References: <20110602180508.GC11721@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38193 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab1FBVJ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 17:09:27 -0400
In-Reply-To: <20110602180508.GC11721@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 06/02/2011 11:05 AM, Tommi Virtanen wrote:
<snip>
> Proposal:
>
> - add autoconf flag --enable-coverage, or some such (afaik Josh has
>    this already), that compiles with coverage recording

This is in the wip_gcov branch as --with-gcov.

> - get "make check" to record coverage for unit tests and clitests,
>    do something to analyze those nicely (separate make target to avoid
>    automake brain damage?)
>
> - get "make install" to install the *.gcno to usr/local/ceph/coverage
>    or such (no need to even create the directory if not --enable-coverage)
>
> - add src/ceph-coverage.in:
>
> --8<--
> #!/bin/sh
> set -e
>
> export GCOV_PREFIX_STRIP=@@GCOV_PREFIX_STRIP@@
>
> usage () {
>        printf '%s: usage: %s OUTPUTDIR COMMAND [ARGS..]\n' "$(basename "$0")" "$(basename "$0")" 1>&2
>        exit 1
> }
>
> export GCOV_PREFIX="$1"
> [ -n "$GCOV_PREFIX" ] || usage
> shift
>
> case "$GCOV_PREFIX" in
>      /*)
> 	# absolute path ->  ok
> 	;;
>      *)
> 	# make it absolute
> 	GCOV_PREFIX="$PWD/$GCOV_PREFIX"
> 	;;
> esac
>
> exec "$@"
> --8<--
>
>    and get Makefile.am to create ceph-coverage out of that; substitute
>    @@GCOV_PREFIX_STRIP@@ at build time with value of "$(pwd|tr -dc /|wc -c)"
>    and install the script to usr/local/bin/ceph-coverage
>
> - make integration tests run everything interesting as
>    "/blah/blah/usr/local/bin/ceph-coverage /blah/coverage /blah/blah/usr/local/bin/cosd ..."
>    do this even when not profiling, just to have the same code path always
>
> - get another gitbuilder (just x86_64 i guess) to build with
>    --enable-profile; individual test runs can use ceph binary tarball
>    url to get the profiling builds
>
> ... and this is where it gets sketchy ...
>
> - FAILED IDEA: make integration tests post-process the gcov data to
>    *.{c,cc,...}.gcov etc
>
>    PROBLEM: this means test box would need the source on it?? this has
>    previously not been true
>
>    BETTER: postprocess them elsewhere, like the place where we want
>    to draw pretty charts and aggregate data across runs? unclear.. but
>    if we archive the *.gcno, *.gcda, and can re-checkout the source, we
>    can always come back to this later

This all sounds good.

> - UNCLEAR: do we want to archive the *.gcno, *.gcda files, or just the
>    *.{c,cc,...}.gcov?
>
> - SUGGESTION: archive *.gcno (inside the ceph binary tarball), *.gcda,
>    and git sha1 for now (the same way as e.g. log files from a test are
>    archived); don't automate post-processing right now; can rsync an
>    archive dir from the archive server, checkout right source tree, run
>    manually, and see things work right; come back to this when the
>    above works

This seems to be the way to go so we can change our post-processing later.

Josh
