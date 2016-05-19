From: Tim Serong <tserong@suse.com>
Subject: Re: Update on ceph-mgr
Date: Thu, 19 May 2016 21:17:47 +1000
Message-ID: <573DA0DB.30203@suse.com>
References: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090101010500040406050202"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:44052 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbcESLRy (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 19 May 2016 07:17:54 -0400
In-Reply-To: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090101010500040406050202
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 05/18/2016 09:02 PM, John Spray wrote:
> Hi all,
> 
> For those who are interested, I wanted to give a quick update on the
> recently-started ceph-mgr work.  This is all still very changeable,
> but now that some code exists I'm putting it out there.
> 
> Firstly, here it is: https://github.com/jcsp/ceph/tree/wip-ceph-mgr
> 
> [...]
> 
> To play with this:
>  1. Build your tree with cmake
>  2. make ceph-mgr
>  3. CALAMARI_CONFIG=<whereever>/ceph/src/pybind/mgr/calamari.conf
> PYTHONPATH=env/lib/python2.7/site-packages bin/ceph-mgr -f
>  4. Point your browser at e.g.
> http://localhost:8002/api/v2/cluster/osd and witness that you get
> calamari-like API output

Just for fun, I decided to play.  I built from a clone of your
wip-ceph-mgr branch, then grabbed a ceph.conf and admin keyring from an
existing Jewel cluster, dumped them in build/, and ran:

PYTHONPATH=../src/pybind/mgr
CALAMARI_CONFIG=../src/pybind/mgr/calamari.conf ./bin/ceph-mgr
--keyring=./ceph.client.admin.keyring --log-file=client.log

This immediately aborted with an assertion failure:

  /ceph/src/mgr/Mgr.cc: 241: FAILED assert(mds_cmd.r == 0)

I suspect the "mds metadata" command might want an MDS name.  Throwing
caution to the wind I commented out that assert, and the mon_cmd.r
assert as well (see attached patch), and got a bit further, but then it
failed with:

  ImportError: No module named rest_framework

TL;DR: I had to install pythond-datetime, django 1.8 and
djangorestframework.  The latter I let be the latest version available
via `pip install` (3.3.3).

I had earlier tried Django 1.9, which I randomly happened to have
installed, but that failed with:

RuntimeError(u"Model class django.contrib.auth.models.Permission doesn't
declare an explicit app_label and isn't in an application in
INSTALLED_APPS.",)

(Django 1.6 is no good either, BTW: AttributeError: 'module' object has
no attribute 'UUIDField')

Anyway, after all that, I can in fact get a nice looking chunk of JSON
out of http://localhost:8002/api/v2/cluster/osd :)

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com

--------------090101010500040406050202
Content-Type: text/x-patch;
 name="ditch-mon-and-mds.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ditch-mon-and-mds.patch"

diff --git a/src/mgr/Mgr.cc b/src/mgr/Mgr.cc
index e8e17b5..73df961 100644
--- a/src/mgr/Mgr.cc
+++ b/src/mgr/Mgr.cc
@@ -238,10 +238,10 @@ void Mgr::load_all_metadata()
   osd_cmd.wait();
   mon_cmd.wait();
 
-  assert(mds_cmd.r == 0);
-  assert(mon_cmd.r == 0);
+//  assert(mds_cmd.r == 0);
+//  assert(mon_cmd.r == 0);
   assert(osd_cmd.r == 0);
-
+/*
   for (auto &metadata_val : mds_cmd.json_result.get_array()) {
     json_spirit::mObject daemon_meta = metadata_val.get_obj();
 
@@ -277,7 +277,7 @@ void Mgr::load_all_metadata()
 
     dmi.insert(dm);
   }
-
+*/
   for (auto &osd_metadata_val : osd_cmd.json_result.get_array()) {
     json_spirit::mObject osd_metadata = osd_metadata_val.get_obj();
     dout(4) << osd_metadata.at("hostname").get_str() << dendl;

--------------090101010500040406050202--
