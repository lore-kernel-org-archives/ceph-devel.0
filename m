From: Gregory Farnum <greg@inktank.com>
Subject: Re: Limitaion of CephFS
Date: Tue, 30 Oct 2012 10:56:27 +0100
Message-ID: <CAPYLRzgBt8vPWYFR8B4D4avTDSAc=5Swo1jW6QkMpegb8o6Zfg@mail.gmail.com>
References: <60E83269D669544E8069A09CB69135EA03DC5E@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52077 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab2J3J41 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 05:56:27 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so41846iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 02:56:27 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA03DC5E@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 30, 2012 at 10:45 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Hi all:
>
> I have some question about the limitation of CephFS.
> Would you please help to answer these questions? Thanks!
>
> 1. Max file size
It's currently set to an (arbitrary) 1TB. It can be set wherever you
like but is limited by the "mds max file size" at MDSMap create time
in order to bound the time the MDS can spend checking one file under
failure scenarios.

> 2. Max number of files
Well, you'll have problems past 2^64 due to wraparound. There might be
some more earlier than that but our inodes are always 64-bit so the
number would be large.
There are some more practical limitations related to scale. Currently
we don't enable directory fragmentation by default (stability
concerns), so your directories should be a fractional size of your MDS
cache size. Your working set should be smaller than your MDS cache
size. Etc.

> 3. Max filename length
POSIX/Linux limits. 1024 characters, I think?

> 4. filename character set, ex: any byte, except null, "/"
POSIX. I believe you're correct.

> 5. max pathname length
POSIX/Linux limits. 4096 characters, I think?

> And one question about RBD
> 1. max RBD size
Hmm, I'm actually not sure on on this. Again, any limit here is either
arbitrary or imposed by somebody else.
-Greg
