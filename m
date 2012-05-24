From: Adam Crume <adamcrume@gmail.com>
Subject: OSDMap::apply_incremental not updating crush map
Date: Thu, 24 May 2012 10:58:56 -0700
Message-ID: <CAFu9Dv0FoiAV3Q6U6S83OXvr5a0EMPJpeEUQDSeXPhMKrdsbQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58111 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757859Ab2EXR66 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 May 2012 13:58:58 -0400
Received: by lahd3 with SMTP id d3so42437lah.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 10:58:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to simulate adding an OSD to a cluster.=A0 I set up an
OSDMap::Incremental and apply it, but nothing ever gets mapped to the
new OSD.=A0 Apparently, the crush map never gets updated.=A0 Do I have =
to
do that manually?=A0 It seems like apply_incremental should do it
automatically.=A0 My test case is below.=A0 It shows that the OSDMap is
updated to have 11 OSDs, but the crush map still shows only 10.

Thanks,
Adam Crume

#include <assert.h>
#include "osd/OSDMap.h"
#include "common/code_environment.h"

int main() {
=A0=A0=A0 OSDMap *osdmap =3D new OSDMap();
=A0=A0=A0 CephContext *cct =3D new CephContext(CODE_ENVIRONMENT_UTILITY=
);
=A0=A0=A0 uuid_d fsid;
=A0=A0=A0 int num_osds =3D 10;
=A0=A0=A0 osdmap->build_simple(cct, 1, fsid, num_osds, 7, 8);
=A0=A0=A0 for(int i =3D 0; i < num_osds; i++) {
=A0=A0=A0=A0=A0=A0=A0 osdmap->set_state(i, osdmap->get_state(i) | CEPH_=
OSD_UP |
CEPH_OSD_EXISTS);
=A0=A0=A0=A0=A0=A0=A0 osdmap->set_weight(i, CEPH_OSD_IN);
=A0=A0=A0 }

=A0=A0=A0 int osd_num =3D 10;
=A0=A0=A0 OSDMap::Incremental inc(osdmap->get_epoch() + 1);
=A0=A0=A0 inc.new_max_osd =3D osdmap->get_max_osd() + 1;
=A0=A0=A0 inc.new_weight[osd_num] =3D CEPH_OSD_IN;
=A0=A0=A0 inc.new_state[osd_num] =3D CEPH_OSD_UP | CEPH_OSD_EXISTS;
=A0=A0=A0 inc.new_up_client[osd_num] =3D entity_addr_t();
=A0=A0=A0 inc.new_up_internal[osd_num] =3D entity_addr_t();
=A0=A0=A0 inc.new_hb_up[osd_num] =3D entity_addr_t();
=A0=A0=A0 inc.new_up_thru[osd_num] =3D inc.epoch;
=A0=A0=A0 uuid_d new_uuid;
=A0=A0=A0 new_uuid.generate_random();
=A0=A0=A0 inc.new_uuid[osd_num] =3D new_uuid;
=A0=A0=A0 int e =3D osdmap->apply_incremental(inc);
=A0=A0=A0 assert(e =3D=3D 0);
=A0=A0=A0 printf("State for 10: %d, State for 0: %d\n",
osdmap->get_state(10), osdmap->get_state(0));
=A0=A0=A0 printf("10 exists: %s\n", osdmap->exists(10) ? "yes" : "no");
=A0=A0=A0 printf("10 is in: %s\n", osdmap->is_in(10) ? "yes" : "no");
=A0=A0=A0 printf("10 is up: %s\n", osdmap->is_up(10) ? "yes" : "no");
=A0=A0=A0 printf("OSDMap max OSD: %d\n", osdmap->get_max_osd());
=A0=A0=A0 printf("CRUSH max devices: %d\n", osdmap->crush->get_max_devi=
ces());
}
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
