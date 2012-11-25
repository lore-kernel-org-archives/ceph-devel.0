From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Hi + question
Date: Sun, 25 Nov 2012 20:02:10 +0100
Message-ID: <CAN04cT5E3YCojDFGYa2xKMbUEbf2dvNnFdr322dCCaxcb-LPSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51960 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2KYTCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 14:02:11 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so6950358vcm.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 11:02:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,

I'm looking into ceph, and I must say I'm really delightful to see a
decent integrated object/file storage system being developed as an
open source project.

I'm a C (+ sometimes python developer) and currently looking for a
nice project to maybe invest some of my evening hours in. Did some
kernel hacking in the past (nothing upstream though, was mostly
specific for the employer's environment), worked at a 3000+ nodes
website company (most of them being photo/video storage nodes and most
others being db nodes), and I remember looking at your project some
years back. Happy to see it actually evolved quite nicely. My
compliments to the devs!

Like I said I'm toying away with ceph since an hour or two, and one of
the things I noticed was that setting up my test env and getting to
know ceph wasn't all that easy to do (gentoo btw). Things like ceph -h
not showing the setcrushmap option, the 'ceph osd crush set' only
returning '(22) Invalid argument' etc etc... So, I decided to take a
real good look at the sources - any dev's number one source for
documentation :-) There I... well.. kind of got lost. Cpp files,
devops tools (python tools, shell scripts, perl scripts), fooclass,
barclass ofcourse, valgrind supps, ... all in ~/src :-)

So I was curious if I was the only one finding this a bit confusing.
If not, I was wondering if you have some clean-up subproject running
somewhere. Might be a nice way for me to really familiarize myself
with the code base.

Let me know,

Roald
