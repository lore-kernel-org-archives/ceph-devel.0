From: Casey Bodley <cbodley@redhat.com>
Subject: rgw: refactoring test_multi.py for teuthology
Date: Tue, 3 Jan 2017 15:42:50 -0500
Message-ID: <02431f0e-d420-b76f-fcfe-d240334be26f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33821 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756154AbdACUoH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 15:44:07 -0500
Received: by mail-qk0-f173.google.com with SMTP id h201so247827509qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 12:42:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shilpa Manjarabad Jagannath <smanjara@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Shilpa, Ali, and list,

The rgw multisite tests are currently running out of 
src/test/rgw/test_multi.py, and use shell scripts to set up multiple 
vstart clusters. We'd like to adapt these tests so they can run inside 
of teuthology as well (while preserving the ability to run them 
manually). Running inside of teuthology means using an existing 
multisite configuration, rather than building one up with the shell scripts.

The python script currently has classes for RGWRealm, RGWCluster, and 
RGWMulti. The RGWMulti.setup() method creates an RGWRealm and builds an 
array of RGWClusters. RGWCluster.start() calls the mstart.sh script to 
create a vstart cluster in a subdirectory. RGWRealm.init_zone() is then 
running all of the radosgw-admin commands to configure that 
zonegroup/zone/etc.

These seem like good base classes for this abstraction. For example, we 
can derive VRealm/VCluster/VMulti to represent the existing vstart 
implementation, and TRealm/TCluster/TMulti to represent their teuthology 
counterparts.

The existing unit tests only need to know the realm, which they access 
as a global variable. We can turn the generic part (the test_* functions 
and their helper functions like check_*) into a separate module like 
src/test/rgw/rgw_multi.py, and add a set_realm() function to set this 
global variable.

Then the vstart version of the test (src/test/rgw/test_multi.py) can 
import rgw_multi, instantiate its VRealm/etc to run the cluster 
creation/configuration, then pass its realm to set_realm() for the unit 
tests. In order for nosetests to find and run the test_* functions in 
rgw_multi.py, test_multi.py needs to use 'from rgw_multi import *'.

A separate python script, probably under qa/tasks/, would implement the 
TRealm/etc subclasses by making the appropriate calls into teuthology. 
Instead of creating the cluster during initialization, it would read the 
existing multisite configuration - either by interpreting the teuthology 
'config', or by running radosgw-admin commands like 'period get'.

It seems like a good first step would be to split out the generic code 
from test_multi.py into rgw_multi.py and verify that the vstart version 
still works.

Casey

