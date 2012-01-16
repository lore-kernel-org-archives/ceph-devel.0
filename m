From: Sage Weil <sage@newdream.net>
Subject: wip-encoding
Date: Mon, 16 Jan 2012 15:46:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49285 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab2APXqs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 18:46:48 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C8372BC7EC
	for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2012 15:46:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 98D86BC7EC
	for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2012 15:46:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are two things going on in this branch.  The first part is a 
'standard' way of constructing the encode/decode functions to facilitate 
backward and forward compatibility and incompatibility detection.  The 
basic scheme is:

  1 byte - version of this encoding
  1 byte - incompat version.. the oldest code version we expect to be able 
           to decode this
  4 bytes - length of payload
  ... data ...

In general, when we decode, we verify that the incompat version is <= our 
(code) version.  If not, we throw an exception.  Then we decode the 
payload, using the version for any conditionals we need to (e.g. to skip 
newly added fields, etc.).  We skip any data at the end.

When we revise an encoding, we should add new fields at the end, and in 
general leave old fields in place, ideally with values that won't confuse 
old code.  When that doesn't work, we'll eventually need to bump the 
incompat version to write off old code.  This generally isn't a problem if 
people are rolling forward frequently.  Only users to make big jumps will 
have trouble having daemons with different versions interact (at least 
when it comes to encoding; if protocols change that's another matter).

When we can't handle a change with a compatible encoding change, we can 
introduce a feature bits and conditionally encode old formats for old 
peers.  This is just more work and eats into a more limited feature bit 
space.

To make this painless, there are a few new macros to do the encode/decode 
boilerplate.  If the encode/decode functions we originally

 void pool_snap_info_t::encode(bufferlist& bl) const
 {
   __u8 struct_v = 1;
   ::encode(struct_v, bl);
   ::encode(snapid, bl);
   ::encode(stamp, bl);
   ::encode(name, bl);
 }
 
 void pool_snap_info_t::decode(bufferlist::iterator& bl)
 {
   __u8 struct_v;
   ::decode(struct_v, bl);
   ::decode(snapid, bl);
   ::decode(stamp, bl);
   ::decode(name, bl);
 }

then we would revise them to be

 void pool_snap_info_t::encode(bufferlist& bl) const
 {
   ENCODE_START(2, 2, bl);

New version is 2.  v1 code can't decode this, so the second argument 
(incompat) is also 2.

   ::encode(snapid, bl);
   ::encode(stamp, bl);
   ::encode(name, bl);
   ::encode(new_thing, bl);
   ENCODE_FINISH();
 }
 
 void pool_snap_info_t::decode(bufferlist::iterator& bl)
 {
   DECODE_START_LEGACY(2, bl, 2);

We can still decode v1 code, but it doesn't have the (new) length and 
incompat version fields, so use the _LEGACY macro.  The second 2 means we 
started using the new approach with v2.

   ::decode(snapid, bl);
   ::decode(stamp, bl);
   ::decode(name, bl);
   if (struct_v >= 2)
     ::decode(new_thing, bl);
   DECODE_FINISH();
 }

This requires and initial incompat change to add the length and incompat 
fields, but then we can generally add things without breakage.

----

The second question is how to test compatibility between different 
versions of code.  There are a few parts to this.

First, a ceph-dencoder tool is compiled for each version of the code that 
is able to encode, decode, and dump (in json) whatever structures we 
support.  It works something like this:

  ceph-dencoder object_info_t -i inputfile decode dump_json

to read in encoded data, decode it, and dump it into json.  We can do a 
trivial identity check (that decode of encode matches) with

  ceph-dencoder object_info_t -i inputfile decode dump_json > /tmp/a
  ceph-dencoder object_info_t -i inputfile decode encode decode dump_json > /tmp/b
  cmp /tmp/a tmp/b

Obviously that should always pass.  For testing cross-version encoding, we 
need a ceph-dencoder and a corpus of objects encoded for each version.  
Assuming you have that, you can (a) make sure we can decode anything from 
other versions without crashing, (b) compare the dumps between version and 
whitelist changes (e.g., when fields are added or removed).  You can also 
specify feature bits to test encoding for older versions, and take, say 
everything for the v0.42 corpus, encode for the v0.40 feature bits, and 
verify that the 0.40 version of ceph-dencoder can handle it.  And 
verify+whitelist diffs.

How to build the per-version corpus?  We can write unit tests that 
explicitly generate interesting object instances.  That's tedious and time 
consuming, but probably best, since the developer knows what corner cases 
are interesting.

Alternatively/additionally, a patch in wip-encoding instruments the 
encode() wrapper to dump a sample of all encoded objects to a temporary 
directory.  This lets you run the system for a while and quickly generate 
a body of encoded objects that can feed the verification process above.  
Some moderate human attention can pick a sample of those, or we can 
randomly take the biggest, smallest, and something in between.. whatever 
seems appropriate.


Current status:
 - The ceph-dencoder tool works.
 - Capturing encoded objects works.
 - New encode/decode macros are there.
 - A simple shell script does some basic identity checks (decode of encode 
   is the same).

Still need:
 - how to structure corpus
 - scripts to do cross-version validation
 - process for whitelisting differences
 - some slightly special handline for Message, which doesn't use the 
   standard encode/decode wrapper functions.

I'm hoping for something that is relatively robust and also mostly 
painless.  In particular, it would be nice to get some decent coverage 
without a bit initial investment.  Currently, we just need to write dump() 
functions and then add types to src/test/encoding/types.h.

Thoughts on this approach?  

sage
