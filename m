From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: issues with adjusting the crushmap in 0.51
Date: Wed, 12 Sep 2012 12:13:04 +0100
Message-ID: <0CCF2B3E-B9BB-4121-92F1-D179D1A0C85E@tchpc.tcd.ie>
References: <20120906175821.GA32205@tchpc.tcd.ie> <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com> <20120906185104.GA6518@tchpc.tcd.ie>  <sfid-H20120906-213138-+033.83-1@marduk.tchpc.tcd.ie> <CADvuQRFz9oZr3BGRdzUhG4xhdYUu69v7UxKDuS4d0-kTisrr6Q@mail.gmail.com>  (sfid-H20120906-213138-+033.83-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:53899 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2ILLNI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 07:13:08 -0400
In-Reply-To: <CADvuQRFz9oZr3BGRdzUhG4xhdYUu69v7UxKDuS4d0-kTisrr6Q@mail.gmail.com>  (sfid-H20120906-213138-+033.83-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Hi Tommi.


On 6 Sep 2012, at 21:31, Tommi Virtanen wrote:

> On Thu, Sep 6, 2012 at 11:51 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
>> Also, the "ceph osd setcrushmap..." command doesn't up when a ceph
>> --help is run in the 0.51 release, however it is documented on the
>> wiki as far as I recall. It'd be real nice if the applications emitted
>> all the available commands, it would make experimenting much nicer and
>> fun.
> 
> "ceph" is just a client app that sends (most of) the commands to
> ceph-mon for execution; it's --help is problematic to keep up to
> date.. We're trying to do better. Patches appreciated, see ticket at
> the end..


Just to scratch an itch, here's some documentation additions from testing locally,

[jtang@x00 ceph (master)]$ git diff
diff --git a/doc/cluster-ops/control.rst b/doc/cluster-ops/control.rst
index 9af4562..9946229 100644
--- a/doc/cluster-ops/control.rst
+++ b/doc/cluster-ops/control.rst
@@ -293,6 +293,10 @@ Enables debug messages. ::
 
 Displays the status of all metadata servers.
 
+Make a pool usable by the fs with::
+
+       ceph mds add_data_pool {pool-name}
+
 .. todo:: ``ceph mds`` subcommands missing docs: set_max_mds, dump, getmap, stop, setmap
 
 
diff --git a/src/tools/ceph.cc b/src/tools/ceph.cc
index 0435771..306d67a 100644
--- a/src/tools/ceph.cc
+++ b/src/tools/ceph.cc
@@ -62,6 +62,7 @@ static void usage()
   cout << "\n";
   cout << "METADATA SERVER (MDS) COMMANDS\n";
   cout << "  ceph mds stat\n";
+  cout << "  ceph mds add_data_pool <pool>\n";
   cout << "  ceph mds tell <mds-id or *> injectargs '--<switch> <value> [--<switch> <value>...]'\n";
   cout << "\n";
   cout << "MONITOR (MON) COMMANDS\n";
@@ -82,6 +83,7 @@ static void usage()
   cout << "  ceph osd unpause\n";
   cout << "  ceph osd tell <osd-id or *> injectargs '--<switch> <value> [--<switch> <value>...]'\n";
   cout << "  ceph osd getcrushmap -o <file>\n";
+  cout << "  ceph osd setcrushmap -i <file>\n";
   cout << "  ceph osd getmap -o <file>\n";
   cout << "  ceph osd crush set <osd-id> <weight> <loc1> [<loc2> ...]\n";
   cout << "  ceph osd crush move <bucketname> <loc1> [<loc2> ...]\n";



Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

