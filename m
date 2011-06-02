From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Ceph code coverage integration proposal
Date: Thu, 2 Jun 2011 11:05:08 -0700
Message-ID: <20110602180508.GC11721@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38068 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab1FBSFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 14:05:09 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id EB4D42C166
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jun 2011 11:05:08 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

[This is mostly for Josh, but I'm sending to list for general
awareness and archival.]

Things learned:

- when you compile something to record code coverage data,
  it remembers the absolute path of the source files, even if your
  build system only used relative paths

- when you compile something to record code coverage data,
  you get a *.gcno file with extra information

- execution-time data recording needs no auxiliary files, it's a
  write-only operation

- it tries to write the *.gcda files to the full absolute path,
  creating any leading directories as needed

- in our case, the paths are /srv/autobuild-ceph/... for normal
  gitbuilder, something else for the deb builder, just about anything
  for developers' own builds; the dir will not exist just about
  anywhere, and would be ugly & unreliable to try to use; we need to
  use the gcov feature to relocate the files

- if it can't create leading dirs / write to files, stderr gets
  "profiling:/full/path/to/file.gcda:Cannot open" but execution
  continues

- we can control where the *.gcda files are written, with environment
  variables; however, GCOV_PREFIX_STRIP is annoying to use, needs
  information from build time

- the gcov command itself reads the *.gcno and *.gcda files and the
  source; there's no need to e.g. preserve the .o files; for
  gitbuilders etc that only build committed trees, we can re-fetch
  the source from git at any time if needed


Proposal:

- add autoconf flag --enable-coverage, or some such (afaik Josh has
  this already), that compiles with coverage recording

- get "make check" to record coverage for unit tests and clitests,
  do something to analyze those nicely (separate make target to avoid
  automake brain damage?)

- get "make install" to install the *.gcno to usr/local/ceph/coverage
  or such (no need to even create the directory if not --enable-coverage)

- add src/ceph-coverage.in:

--8<--
#!/bin/sh
set -e

export GCOV_PREFIX_STRIP=@@GCOV_PREFIX_STRIP@@

usage () {
      printf '%s: usage: %s OUTPUTDIR COMMAND [ARGS..]\n' "$(basename "$0")" "$(basename "$0")" 1>&2
      exit 1
}

export GCOV_PREFIX="$1"
[ -n "$GCOV_PREFIX" ] || usage
shift

case "$GCOV_PREFIX" in
    /*)
	# absolute path -> ok
	;;
    *)
	# make it absolute
	GCOV_PREFIX="$PWD/$GCOV_PREFIX"
	;;
esac

exec "$@"
--8<--

  and get Makefile.am to create ceph-coverage out of that; substitute
  @@GCOV_PREFIX_STRIP@@ at build time with value of "$(pwd|tr -dc /|wc -c)"
  and install the script to usr/local/bin/ceph-coverage

- make integration tests run everything interesting as
  "/blah/blah/usr/local/bin/ceph-coverage /blah/coverage /blah/blah/usr/local/bin/cosd ..."
  do this even when not profiling, just to have the same code path always

- get another gitbuilder (just x86_64 i guess) to build with
  --enable-profile; individual test runs can use ceph binary tarball
  url to get the profiling builds

... and this is where it gets sketchy ...

- FAILED IDEA: make integration tests post-process the gcov data to
  *.{c,cc,...}.gcov etc

  PROBLEM: this means test box would need the source on it?? this has
  previously not been true

  BETTER: postprocess them elsewhere, like the place where we want
  to draw pretty charts and aggregate data across runs? unclear.. but
  if we archive the *.gcno, *.gcda, and can re-checkout the source, we
  can always come back to this later

- UNCLEAR: do we want to archive the *.gcno, *.gcda files, or just the
  *.{c,cc,...}.gcov?

- SUGGESTION: archive *.gcno (inside the ceph binary tarball), *.gcda,
  and git sha1 for now (the same way as e.g. log files from a test are
  archived); don't automate post-processing right now; can rsync an
  archive dir from the archive server, checkout right source tree, run
  manually, and see things work right; come back to this when the
  above works



Here's a picture for you, too:


source ---build---> binary tarball  ---run---> archive
-sha1               -binaries                  -logs etc
                    -ceph-coverage             -*.gcda
                    -*.gcno
 |                    |                          |
 |                    |                          |
  \                   |                         /
    \                 |                       /
      \               |                     /
        \             |                   /
          \           |                 /
             gcov run needs all these
                      |
                      |
               *.{c,cc,...}.gcov
                      |
                      |
                  lcov etc?


Phew.

-- 
:(){ :|:&};:
