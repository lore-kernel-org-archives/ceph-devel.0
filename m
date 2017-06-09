From: Sage Weil <sage@newdream.net>
Subject: Re: Errors in Ceph block \free\bsd jenkins
Date: Fri, 9 Jun 2017 18:23:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706091822130.3646@piezo.novalocal>
References: <838cd04c-d291-42dd-56a1-995f8bd42855@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55033 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFISXT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 14:23:19 -0400
In-Reply-To: <838cd04c-d291-42dd-56a1-995f8bd42855@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Try with this:

	https://github.com/ceph/ceph/pull/15588

mgr is probably dying trying to start up dashboard.

sage

On Fri, 9 Jun 2017, Willem Jan Withagen wrote:

> Hi
> 
> All my jenkins builds on FreeBSD get terminated in errors in
> build/bin/ceph, due to faulty command.
> Am I the only one being hampered by this?
> 
> --Wjw
> 
> Starting mgr.x
> /home/jenkins/workspace/ceph-master/build/bin/ceph-mgr -i x -c
> /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
> /home/jenkins/workspace/ceph-master/build/bin/ceph -c
> /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
> -k /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/keyring
> tell mgr.x restful create-key admin -o /tmp/tmp.ZrcYS640
> no valid command found; 10 closest matches:
> osd reweight-by-utilization {<int>} {<float>} {<int>} {--no-increasing}
> osd pool stats {<name>}
> pg repair <pgid>
> pg deep-scrub <pgid>
> osd blocked-by
> osd perf
> pg dump_stuck {inactive|unclean|stale|undersized|degraded
> [inactive|unclean|stale|undersized|degraded...]} {<int>}
> pg ls {<int>}
> {active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered
> [active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered...]}
> pg scrub <pgid>
> pg debug unfound_objects_exist|degraded_pgs_exist
> Error EINVAL: invalid command
> 
> 
> 25% tests passed, 3 tests failed out of 4
> 
> Total Test time (real) = 503.43 sec
> 
> The following tests FAILED:
> 	  4 - cephtool-test-mon.sh (Failed)
> 	  5 - cephtool-test-osd.sh (Failed)
> 	  6 - cephtool-test-rados.sh (Failed)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
