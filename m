From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Wed, 7 Mar 2012 13:40:46 -0800
Message-ID: <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com>
References: <4F516A20.8060901@cs.ucsc.edu>
 <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
 <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58958 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2CGVku convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Mar 2012 16:40:50 -0500
Received: by pbcun15 with SMTP id un15so905385pbc.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Mar 2012 13:40:49 -0800 (PST)
In-Reply-To: <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

I went over all this today and had several line notes. Overall it looks=
 good, though! =20

To emphasize what Sage said about the package name: We should change th=
at to com.ceph.fs.
CephMount::conf_get requires a buf_size. But we freely adjust that if w=
e need more space, so is there any point to it? I can't see callers rea=
lly having a better idea of size than we do.
(Oh, now I see there's another one that doesn't take buf_size. Do we ha=
ve a use case for the with-size option, though?)
Similarly with getdnames
We don't implement CephMount::mkdir, just mkdirs? I *can* see use cases=
 for not wanting recursive creates...
The ordering is a little funny for some functions =E2=80=94 we see clos=
e() before open(), for instance. Maybe we should reorder these?
set_default_file_replication doesn't actually do anything internally =E2=
=80=94 I thought that was documented somewhere. Even if it's not, it ce=
rtainly should be here (and elsewhere, patches welcome! ;). (It passes =
the value to the Client, and the Client passes it to the MDS, but the M=
DS never looks at it).
I like the states and require_state() stuff. It's making me notice that=
 you need a little more documentation on stuff like closedir and what h=
appens to the CephDirectory under success and error returns. :)
The CHECK_ARG_* stuff could use some docs. I see now that CHECK_ARG_BOU=
NDS is expecting a full comparison, so it's probably just my lack of pr=
eprocessor idiom knowledge, but it weirded me out. And CHECK_ARG_COND a=
ppears to be unused.
do we need mount() when we can just run mount(null)? Similarly, I don't=
 think we need an if-else in CephMountCreateTest::setupMount. :)




On Wednesday, March 7, 2012 at 10:02 AM, Noah Watkins wrote:

> I've kept an eye on how much things are deviating from the current im=
plementation and its pretty minimal, so I think producing a new version=
 to use the generic libcephfs interface will happen quickly.
> =20
> As for producing an upstream patch, I think the two biggest concerns =
are:
> =20
> 1. Reporting hostname/racks rather than IPs for object location.
> 2. Address (or at least document) the time synchronization issue.
> =20
> These are largely orthogonal to getting the code ready for upstream, =
but may be a "political" road block? I can put together the details of =
these two issues in a separate thread=E2=80=A6

Please do! I know I've seen most of these issues come up, but I'm still=
 a bit fuzzy on the time sync issue.

Thanks!
-Greg


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
