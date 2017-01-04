From: Shilpa Manjarabad Jagannath <smanjara@redhat.com>
Subject: Re: rgw: refactoring test_multi.py for teuthology
Date: Wed, 4 Jan 2017 06:19:42 -0500 (EST)
Message-ID: <435027817.7434134.1483528782550.JavaMail.zimbra@redhat.com>
References: <02431f0e-d420-b76f-fcfe-d240334be26f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60073 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966401AbdADLTm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2017 06:19:42 -0500
In-Reply-To: <02431f0e-d420-b76f-fcfe-d240334be26f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Casey Bodley" <cbodley@redhat.com>
> To: "Shilpa Manjarabad Jagannath" <smanjara@redhat.com>
> Cc: "Ali Maredia" <amaredia@redhat.com>, "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, January 4, 2017 2:12:50 AM
> Subject: rgw: refactoring test_multi.py for teuthology
> 
> Hi Shilpa, Ali, and list,
> 
> The rgw multisite tests are currently running out of
> src/test/rgw/test_multi.py, and use shell scripts to set up multiple
> vstart clusters. We'd like to adapt these tests so they can run inside
> of teuthology as well (while preserving the ability to run them
> manually). Running inside of teuthology means using an existing
> multisite configuration, rather than building one up with the shell scripts.
> 
> The python script currently has classes for RGWRealm, RGWCluster, and
> RGWMulti. The RGWMulti.setup() method creates an RGWRealm and builds an
> array of RGWClusters. RGWCluster.start() calls the mstart.sh script to
> create a vstart cluster in a subdirectory. RGWRealm.init_zone() is then
> running all of the radosgw-admin commands to configure that
> zonegroup/zone/etc.
> 
> These seem like good base classes for this abstraction. For example, we
> can derive VRealm/VCluster/VMulti to represent the existing vstart
> implementation, and TRealm/TCluster/TMulti to represent their teuthology
> counterparts.
> 
> The existing unit tests only need to know the realm, which they access
> as a global variable. We can turn the generic part (the test_* functions
> and their helper functions like check_*) into a separate module like
> src/test/rgw/rgw_multi.py, and add a set_realm() function to set this
> global variable.
> 
> Then the vstart version of the test (src/test/rgw/test_multi.py) can
> import rgw_multi, instantiate its VRealm/etc to run the cluster
> creation/configuration, then pass its realm to set_realm() for the unit
> tests. In order for nosetests to find and run the test_* functions in
> rgw_multi.py, test_multi.py needs to use 'from rgw_multi import *'.
> 
> A separate python script, probably under qa/tasks/, would implement the
> TRealm/etc subclasses by making the appropriate calls into teuthology.
> Instead of creating the cluster during initialization, it would read the
> existing multisite configuration - either by interpreting the teuthology
> 'config', or by running radosgw-admin commands like 'period get'.
> 
> It seems like a good first step would be to split out the generic code
> from test_multi.py into rgw_multi.py and verify that the vstart version
> still works.
> 
> Casey

Sounds good. Thanks Casey!


> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
