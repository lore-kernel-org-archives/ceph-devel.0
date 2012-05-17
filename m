From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/16] ceph: messenger cleanups and fixes
Date: Thu, 17 May 2012 08:54:49 -0500
Message-ID: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58908 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760910Ab2EQNyr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 09:54:47 -0400
Received: by gglu4 with SMTP id u4so1792025ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 06:54:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series culminates in fixing a bug in which ceph connection
header might get sent over the wire before its associated authorizer
structure has been fully prepared.  More info is found here:
     http://tracker.newdream.net/issues/2424

Sage preemptively reviewed them before I got them posted to the
list, and the patches that follow indicate that.  These patches are
being tested now, and unless I get actionable feedback (and if they
successfully pass testing) I'll be committing them as-is.

Along the way a few other small bugs are fixed (or avoided) and some
data structures and interfaces are modified a bit to simplify
things.  Here is a bit of summary information about them.

These first four rearrange some places where a connection's out_kvec
fields get reset, and where/when a banner gets put out prior to a
connection header.  A couple of functions can then eliminate a
parameter as a result.
     libceph: don't reset kvec in prepare_write_banner()
     ceph: messenger: reset connection kvec caller
     ceph: messenger: send banner in process_connect()
     ceph: drop msgr argument from prepare_write_connect()

This defers setting WRITE_PENDING when a connection header has been
queued to write but not its associated authorizer buffer.
     ceph: don't set WRITE_PENDING too early

These add error checking in two spots, and rearranges a function so
a simple case can be handled without dropping a connection's mutex.
     ceph: messenger: check prepare_write_connect() result
     ceph: messenger: rework prepare_connect_authorizer()
     ceph: messenger: check return from get_authorizer

This defines a type to group some authorizer-related fields, then
uses it to simplify some function interfaces.  It also adds some
additional checking before using method function pointers.
     ceph: define ceph_auth_handshake type
     ceph: messenger: reduce args to create_authorizer
     ceph: ensure auth ops are defined before use
     ceph: have get_authorizer methods return pointers
     ceph: use info returned by get_authorizer
     ceph: return pointer from prepare_connect_authorizer()

These final two implement the final fix for bug 2424 mentioned
above.  It doesn't place the connection header into out_kvec until
it is fully initialized, and then ensures the associated authorizer
buffer is also added before marking the WRITE_PENDING flag on the
connection (and also before dropping the connection mutex).
     ceph: rename prepare_connect_authorizer()
     ceph: add auth buf in prepare_write_connect()

					-Alex
