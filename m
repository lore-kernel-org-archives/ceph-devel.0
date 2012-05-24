From: Greg Farnum <greg@inktank.com>
Subject: Re: OSDMap::apply_incremental not updating crush map
Date: Thu, 24 May 2012 11:07:56 -0700
Message-ID: <B4A642B87C954FDD99D1ABAB48083AA7@inktank.com>
References: <CAFu9Dv0FoiAV3Q6U6S83OXvr5a0EMPJpeEUQDSeXPhMKrdsbQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38975 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927Ab2EXSIA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:08:00 -0400
Received: by dady13 with SMTP id y13so79775dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:07:59 -0700 (PDT)
In-Reply-To: <CAFu9Dv0FoiAV3Q6U6S83OXvr5a0EMPJpeEUQDSeXPhMKrdsbQw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Crume <adamcrume@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, May 24, 2012 at 10:58 AM, Adam Crume wrote:
> I'm trying to simulate adding an OSD to a cluster. I set up an
> OSDMap::Incremental and apply it, but nothing ever gets mapped to the
> new OSD. Apparently, the crush map never gets updated. Do I have to
> do that manually?

Yes. If you need help, check out the OSDMonitor::prepare_command code "crush" section. :)
 
> It seems like apply_incremental should do it
> automatically.

apply_incremental has no idea where the new ID is located in terms of failure domains.
 
> My test case is below. It shows that the OSDMap is
> updated to have 11 OSDs, but the crush map still shows only 10.
> 
> Thanks,
> Adam Crume
> 
> #include <assert.h>
> #include "osd/OSDMap.h"
> #include "common/code_environment.h"
> 
> int main() {
> OSDMap *osdmap = new OSDMap();
> CephContext *cct = new CephContext(CODE_ENVIRONMENT_UTILITY);
> uuid_d fsid;
> int num_osds = 10;
> osdmap->build_simple(cct, 1, fsid, num_osds, 7, 8);
> for(int i = 0; i < num_osds; i++) {
> osdmap->set_state(i, osdmap->get_state(i) | CEPH_OSD_UP |
> CEPH_OSD_EXISTS);
> osdmap->set_weight(i, CEPH_OSD_IN);
> }
> 
> int osd_num = 10;
> OSDMap::Incremental inc(osdmap->get_epoch() + 1);
> inc.new_max_osd = osdmap->get_max_osd() + 1;
> inc.new_weight[osd_num] = CEPH_OSD_IN;
> inc.new_state[osd_num] = CEPH_OSD_UP | CEPH_OSD_EXISTS;
> inc.new_up_client[osd_num] = entity_addr_t();
> inc.new_up_internal[osd_num] = entity_addr_t();
> inc.new_hb_up[osd_num] = entity_addr_t();
> inc.new_up_thru[osd_num] = inc.epoch;
> uuid_d new_uuid;
> new_uuid.generate_random();
> inc.new_uuid[osd_num] = new_uuid;
> int e = osdmap->apply_incremental(inc);
> assert(e == 0);
> printf("State for 10: %d, State for 0: %d\n",
> osdmap->get_state(10), osdmap->get_state(0));
> printf("10 exists: %s\n", osdmap->exists(10) ? "yes" : "no");
> printf("10 is in: %s\n", osdmap->is_in(10) ? "yes" : "no");
> printf("10 is up: %s\n", osdmap->is_up(10) ? "yes" : "no");
> printf("OSDMap max OSD: %d\n", osdmap->get_max_osd());
> printf("CRUSH max devices: %d\n", osdmap->crush->get_max_devices());
> }
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



