From: Marcus Watts <mwatts@redhat.com>
Subject: wip-addr
Date: Fri, 2 Oct 2015 19:24:13 -0400
Message-ID: <20151002232413.GA8939@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbbJBXYQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Oct 2015 19:24:16 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 808D48C1CE
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2015 23:24:16 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

wip-addr

1. where is it?
2. current state
3. more info
4. cheap fixes
5. in case you were wondering why?

____ 1. where is it?

I've just pushed another update to wip-addr:

git@github.com:linuxbox2/linuxbox-ceph.git
wip-addr

____ 2. current state

This version
1/ compiles
2/ ran an extremely limited set of tests successfully
	(was able to bring up ceph-mon, ceph-osd).

In theory, it should do everything a recent "master" branch copy of ceph
can do and little or nothing past that.  Internally it adds "address vector"
support, some parsing/print logic, and lots of encoding rules to pass them
around, but there's nothing that can create and little that makes any
sensible use of this.  So this is just the back end encoding and storage rules.

Phase 2 is to add logic to actually make it useful.
	(the very start of this is on linuxbox2 "wip-addr-p2",
	just monmap changes so far...)

____ 3. more info

There's an etherpad document that describes this in more detail,

http://pad.ceph.com/p/wip_addr

____ 4. cheap fixes

a couple of minor issues that should be easy to resolve,
1.
AsyncConnection.cc
this passes addresses back and forth as it's setting up the connection,
and it also exchanges features.  As best I can tell, it looks like
it exchanges addresses before it knows what features the other end
supports.  There should be something in here that
does this after knowing what features the other end supports.

2.
(about line 2067 in src/tools/ceph_objectstore_tool.cc)
(use via ceph cmd?) tools - "object store tool".
This has a way to serialize objects which includes a watch list
which includes an address.  There should be an option here to say
whether to include exported addresses.

____ 5. in case you were wondering why?

The main current interest for this it to work with accelio,
which introduces 2 more transport types (accelio, via tcp or
infiniband.)  So that means actually 6 possible choices,
{ ipv6 or ipv6 } x { simple messenger, tcp, infiniband. }.
Infiniband typically would work within a data center but not
between them, so there are also reachability issues which
may not be obvious to the client.  (ipv6 has this too).

					-Marcus Watts
