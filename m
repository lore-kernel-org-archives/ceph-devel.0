From: Daniel Smith <viscous.liquid@gmail.com>
Subject: SegFault using C binding for RADOS
Date: Wed, 8 Dec 2010 09:55:38 -0500
Message-ID: <AANLkTik9bL9eTOKqUyu3jD7qzfL7uUBfzNnfLLQUygA1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60213 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab0LHOzk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Dec 2010 09:55:40 -0500
Received: by yxt3 with SMTP id 3so690013yxt.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Dec 2010 06:55:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Daniel Smith <viscous.liquid@gmail.com>

Greetings,

I have been attempting work with the C bindings for librados so that I
may write a set of Ruby bindings using the RubyFFI library. I was
having difficult writing to the cluster from my bindings, so I wrote a
contrived example below in an attempt to better understand the
bindings. I know my C is rusty, but the simple example should have
worked. As you can see from the snippets from my gdb session below
this sample app segfaults when attempting write. The backtrace shows
that inside of librados the fault occurs during a list append. I would
prefer to avoid having to write raw C++ if at all possible. Any help
would be greatly appreciated.

Thanks in Advance,
Daniel P. Smith

## Source##
#include <stdlib.h>
#include <stdio.h>
#include <rados/librados.h>

int main(int argc, const char **argv) {
=A0=A0=A0 rados_initialize(0,NULL);

=A0=A0=A0 rados_pool_t my_pool =3D malloc(sizeof(rados_pool_t));

=A0=A0=A0 if ( rados_open_pool("testpool", &my_pool) < 0) {
=A0=A0=A0=A0=A0=A0=A0 puts("Failed to open pool!");
=A0=A0=A0 } else {
=A0=A0=A0=A0=A0=A0=A0 puts("Success opening pool!");
=A0=A0=A0=A0=A0=A0=A0 if (rados_write(my_pool, "54b0c58c7ce9f2a8b551351=
102ee0938",
0, "this is a test", 14) < 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 puts("Failed writing to the pool!");
=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0 }

=A0=A0=A0 rados_close_pool(my_pool);
=A0=A0=A0 rados_deinitialize();
}


## Last step ##
14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rados_write(my_pool,
"54b0c58c7ce9f2a8b551351102ee0938", 0, "this is a test\0", 15) < 0) {

Program received signal SIGSEGV, Segmentation fault.
0x003cb2b0 in ?? () from /lib/libc.so.6

## Back trace ##
#0=A0 0x003cb2b0 in ?? () from /lib/libc.so.6
#1=A0 0x00183cee in ceph::buffer::list::append(char const*, unsigned
int) () from /usr/lib/librados.so.1
#2=A0 0x0017c1e6 in rados_write () from /usr/lib/librados.so.1
#3=A0 0x0804866f in main (argc=3D1, argv=3D0xbffff404) at test.c:14
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
