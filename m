From: Marcel Lauhoff <ml@irq0.org>
Subject: OSD-Based Object Stubs
Date: Wed, 27 May 2015 10:39:23 +0200
Message-ID: <87a8wqct38.fsf@irq0.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:33512 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbbE0Iom (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 May 2015 04:44:42 -0400
Received: from janelane.irq0.org (x4d0891d0.dyn.telefonica.de [77.8.145.208])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 74C54800F9
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 08:39:23 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I wrote a prototype for an OSD-based object stub feature. An object stub
being an object with it's data moved /elsewhere/. I hope to get some
feedback, especially whether I'm on the right path here and if it
is a feature you are interested in.



Code is in my "osd-stubs" branch:
 https://github.com/ceph/ceph/compare/master...irq0:osd-stubs
 https://github.com/irq0/ceph/tree/osd-stubs

 Tools to toy around with osd-stubs + web server to send stubs to:
 https://github.com/irq0/ceph_osd-stub_tools



Related:
- https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd:_tiering:_object_redirects



Implementation:

Adds two new OSD OPs:
- STUB :: Move data away; Save location in xattr; Set
          object_info_t::stub_state to 'remote'
- UNSTUB :: Get data back; Remove xattr; Set object_info_t::stub_state
            to 'local'


STUB is meant to be called by an external archive agent. UNSTUB
implicitly when OPs come in that need the object's data. Operations are
classified as "may_use_obj_data" similar to how op->may_{write,read,cache} work.

The implicit UNSUB is implemented by prepending an UNSTUB operation to the
incoming OP list if "may_use_obj_data() and stub_state == REMOTE".
This sadly causes a waring in the client saying that
the reply doesn't match the request. He is of course right, but I found
it to be the simplest way to try that feature.

External storage in the prototype is just simple HTTP: PUT on STUB;
GET+DELETE on UNSTUB.

The Operations implement a kind of converter: STUB reads from the
primary OSD, store the object on the remote and then issue TRUNCATE(0)
and SETXATTR OPs. Similar UNSTUB retrieves the object, then does
WRITEFULL and RMXATTR.


~marcel

--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org
