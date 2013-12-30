From: Noah Watkins <noah.watkins@inktank.com>
Subject: Shared library symbol visibility
Date: Mon, 30 Dec 2013 09:56:22 -0800
Message-ID: <CA+Hcz59Z3_4_je=DfRKeg_SF9kEuusdi9t7TrdA8KeokuqCqpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:58489 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab3L3R4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 12:56:25 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so10929645qaq.12
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 09:56:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Harper <james.harper@bendigoit.com.au>, Alan Somers <asomers@gmail.com>

It looks like we may be outgrowing the use of export-symbols-regex and
friends to control symbol visibility for published shared libraries.
On Linux, ld seems to be quite content linking against hidden symbols,
but at least on OSX with Clang it seems the visibility is strictly
enforced.

For instance, librados exports only the prefix "rados_", but that
regex hides everything in the C++ interface. Unfortunately,
export-symbols-regex doesn't play nice with C++ name mangling.

Large projects that I've been looking at for examples (chromium, v8,
Java) seem to use a different approach based on the compiler flag
"-fvisibility=hidden" that hides everything by default and uses
explicit exporting.

These are the basics, and there are variants that work on Windows for
DLL's as well with more macro magic.

#define CEPH_EXPORT __attribute__((__visibility__("default")))

  class CEPH_EXPORT ObjectOperation {
    public:
      ObjectOperation();
      virtual ~ObjectOperation();
      ...

There is a sample branch up with this approach at:

   http://github.com/ceph/ceph port/visibility

More info

https://www.gnu.org/software/gnulib/manual/html_node/Exported-Symbols-of-Shared-Libraries.html
http://gcc.gnu.org/wiki/Visibility

- Noah
