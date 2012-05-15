From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 18:23:51 -0700
Message-ID: <CADvuQRGtobTBMT3ZP-9dG85bRCe4UTFvgxFvnLc4-hXZW9MDjQ@mail.gmail.com>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
 <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
 <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu> <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
 <6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu> <CAPYLRzgn_cwk6LfYgZbC5FvBbph9z6HGh_qyveHBr3CFOocs8w@mail.gmail.com>
 <CAPYLRzgBa8Ucoqase5jQU_a8SrW0DtaZozp2ckDT5a0=Y6FoGQ@mail.gmail.com> <5133CDAC-FC95-4330-897A-A8BB63F3166F@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52905 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816Ab2EOBYM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 21:24:12 -0400
Received: by dady13 with SMTP id y13so6621350dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 18:24:12 -0700 (PDT)
In-Reply-To: <5133CDAC-FC95-4330-897A-A8BB63F3166F@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Mon, May 14, 2012 at 4:04 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> In contrast to readdir, the seek/rewinddir man pages state that these functions do not return an error (via errno or otherwise). So, presumably a client assuming man-page-ish semantics would never check errno after seekdir, which could have odd implications for arbitrary code just trying to tie into libcephfs. Then again, maybe they should use libcephfs man pages :) ?

As a POSIX nitpick, unless you are told to look at errno (e.g. get -1
from a libc call), the value of errno is arbitrary. errno != 0 does
not imply an error happened.

seekdir, and it's constant-argument friend rewinddir, *cannot* fail.

Now, if we're talking about libcephfs and not POSIX, we probably
shouldn't emulate those prototypes 100%. Be sane, return 0 or -error.

(I realize there's already an API out there, and this might mean changing it.)
