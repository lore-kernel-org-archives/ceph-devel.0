From: Tim Serong <tserong@suse.com>
Subject: fun with ccache
Date: Wed, 19 Apr 2017 23:34:06 +1000
Message-ID: <33e54077-10a8-96e7-ae37-f99d46d85159@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43186 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbdDSNeP (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 19 Apr 2017 09:34:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I'm just going to leave this here in case it's helpful for anyone else.

Earlier today I decided to try this:

  ./do_cmake.sh -DWITH_LTTNG=OFF -DHAVE_BABELTRACE=OFF -DWITH_CCACHE=ON
  cd build
  make -j8

Ignore the WITH_LTTNG and HAVE_BABELTRACE bits, that's because I don't
have dependencies for those right now on my openSUSE Tumbleweed system.
The important part is WITH_CCACHE=ON.  `do_cmake.sh` succeeded, but the
subsequent `make` failed with a rather weird error:

~/src/common/crc32c_intel_fast_asm.S:1: error: instruction expected
after label

Turns out due to an oddity of the way ccache invokes the compiler
command (yasm-wrapper in this case), one of the source files was being
overwritten with junk from stderr.  I've got a fix for that:

  https://github.com/ceph/ceph/pull/14633

Some more detailed explanation is in the commit message.

The next problem was possibly weirder (at least, I never figured out WTF
the root cause was), but I wound up with various build failures along
the lines of:

../lib/libcommon.a(crc32c_intel_fast.c.o): In function
`ceph_crc32c_intel_fast':
~/src/common/crc32c_intel_fast.c:17: undefined reference to
`crc32_iscsi_zero_00'

...and conversely, at other times, alleged multiple definitions of
crc32_iscsi_* functions (sorry, I've lost the log of that piece :-/).

This latter oddity was fixed by some combination of:

- Upgrading from ccache 3.3.3 to 3.3.4
- Clearing the entire ccache (`ccache -C`)
- Rebuilding everything from scratch (`rm -rf build; do_cmake.sh; ...`)

I should note that builds *without* ccache worked fine throughout this
whole debacle.

If nobody else has ever experienced the second problem (undefined
references and/or multiple definitions of the crc32_iscsi_* functions) I
shall assume I somehow mangled my build directory and/or ccache while
testing the fix for the first problem in yasm-wrapper.

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
