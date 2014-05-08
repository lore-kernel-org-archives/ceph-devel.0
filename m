From: John Spray <john.spray@inktank.com>
Subject: Re: A plea for more tooling usage
Date: Thu, 8 May 2014 11:37:09 +0100
Message-ID: <CAGd4Wr2H2EGWufxi15iAxxwS5sFBsQZJLw9dv_K7NkFjUVoH1A@mail.gmail.com>
References: <20140506134826.GA17004@trvx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51344 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbaEHKhK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 May 2014 06:37:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so2665844pab.22
        for <ceph-devel@vger.kernel.org>; Thu, 08 May 2014 03:37:09 -0700 (PDT)
In-Reply-To: <20140506134826.GA17004@trvx.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Hofmann <daniel@trvx.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Couple of notes for anyone following along on ubuntu precise or
another older system:
 * make sure you're using clang >=3.3 to get support for suppressing
all the warning flags in Daniel's command line.
 * libcrypto++ 5.6.1 (the version in ubuntu) doesn't compile with
clang, unless you hack

I was looking through the warnings out of interest and made a couple notes.

On Tue, May 6, 2014 at 2:48 PM, Daniel Hofmann <daniel@trvx.org> wrote:
>> warning: anonymous types declared in an anonymous union are an extension [-Wnested-anon-types]
>
>     $ grep Wnested-anon-types uniq.txt  | wc -l
>     28

This is mostly ceph_osd_op in rados.h - code is fine but nonstandard.
We can avoid this particular warning by explicitly typedeffing the
struct types before using them, but would still have the warning that
anonymous unions are themselves nonstandard.  Anonymous unions are
nice...

>
>> warning: zero size arrays are an extension [-Wzero-length-array]
>
>     $ grep Wzero-length-array uniq.txt | wc -l
>     8134

This is mostly dout_impl, I think -- it is using an array whose size
is defined as 0 or -1 conditionally, apparently in order to detect out
of bounds severity numbers.

I wonder if there is a neater way to do this - I am not a preprocessor guru.

>> warning: '%' may not be nested in a struct due to flexible array member [-Wflexible-array-extensions]
>
>     $ grep Wflexible-array-extensions uniq.txt | wc -l
>     2

This is true (ceph_frag_tree in ceph_mds_reply_inode)... I don't see a
nice way around it.  Perhaps its a useful enough language extension
that we should continue to use it.

>> warning: cast between pointer-to-function and pointer-to-object is an extension [-Wpedantic]
>> warning: use of non-standard escape character '\%' [-Wpedantic]
>
>     $ grep Wpedantic uniq.txt | wc -l
>     15

The pointer cast thing is overly pedantic in the cases we're using
dlsym (which returns a void*), object pointer cast to fn pointer is
illegal in the language standard but guaranteed to work in POSIX.

The \% thing is easily fixed.

>> warning: use of GNU old-style field designator extension [-Wgnu-designator]
>
>     $ grep Wgnu-designator uniq.txt | wc -l
>     43

fuse_ll.cc:fuse_ll_oper and config.cc:g_default_file_layout.

Can easily just remove the field designators and initialize as {val1,
val2} but that's much less readable :-/  I don't think nice struct
initialization becomes a thing until C++11.

>> warning: using namespace directive in global context in header [-Wheader-hygiene]
>
>     $ grep Wheader-hygiene uniq.txt | wc -l
>     87

We should be able to solve these easily with a fairly mechanical procedure:
 * Remove the 'using's from the headers
 * Change type references in headers to use appropriate prefix (mostly std::)
 * Add in the 'using's to any .cc files that relied on them

>> warning: struct '%' was previously declared as a class [-Wmismatched-tags]
>
>     $ grep Wmismatched-tags uniq.txt | wc -l
>     93

At least some of these (especially Inode in libcephfs.h) appear to
have the intention of exposing POD classes in C-compatible headers.
We should probably change the C++ side to also use struct for the
things that are going to be exposed to C land.

>> warning: missing field '%' initializer [-Wmissing-field-initializers]
>
>     $ grep Wmissing-field-initializer uniq.txt | wc -l
>     3

Hmm, I only saw one of these:
test/osd/TestRados.cc:260:36: warning: missing field 'ec_pool_valid'
initializer [-Wmissing-field-initializers]

...but I'm on an older clang (3.3) so perhaps that explains it.

>> warning: private field '%' is not used [-Wunused-private-field]
>
>     $ grep Wunused-private-field uniq.txt | wc -l
>     11

This is a handy warning indeed, it appears to be accurately pointing
out unused fields.

John
