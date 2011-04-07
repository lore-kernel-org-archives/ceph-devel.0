From: AnnyRen <annyren6@gmail.com>
Subject: Where I can find the definition/meanings of options parameter in /src/common/config.cc
Date: Thu, 7 Apr 2011 17:44:55 +0800
Message-ID: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46385 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1DGJo4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 05:44:56 -0400
Received: by eyx24 with SMTP id 24so725989eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 02:44:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:

I'm trying to tune the options parameters defined in config.cc, like

 OPTION(mon_osd_down_out_interval, 0, OPT_INT, 300), // seconds
  OPTION(mds_replay_interval, 0, OPT_FLOAT, 1.0), // time to wait
before starting replay again
  OPTION(mds_shutdown_check, 0, OPT_INT, 0),
  OPTION(mds_thrash_exports, 0, OPT_INT, 0),
  OPTION(mds_thrash_fragments, 0, OPT_INT, 0),
  OPTION(mds_dump_cache_on_map, 0, OPT_BOOL, false),
  OPTION(mds_dump_cache_after_rejoin, 0, OPT_BOOL, false),
  OPTION(mds_verify_scatter, 0, OPT_BOOL, false),
  OPTION(mds_debug_scatterstat, 0, OPT_BOOL, false),
  OPTION(mds_debug_frag, 0, OPT_BOOL, false),
  OPTION(mds_kill_mdstable_at, 0, OPT_INT, 0),
  OPTION(mds_kill_export_at, 0, OPT_INT, 0),
  OPTION(mds_kill_import_at, 0, OPT_INT, 0),
  OPTION(mds_kill_rename_at, 0, OPT_INT, 0),
  OPTION(mds_wipe_sessions, 0, OPT_BOOL, 0),

to test the functionalities and performance in ceph,
Could you tell me where to find the definitions of all parameters, so
I could tune Ceph to run with the best performance?
Thanks very much!

Another question is if I want to adjust a config option, but I don't
want to modify the ceph.conf and restart the monitor,
could I use   { ceph mon injectargs 0 '--mon_osd_down_out_interval
600'     }    the instruction to modify the settings?
and how can I query the current settings I had made?

For example
I use the following command to enable debug messages
{ceph mds injectargs 0 '--debug_ms 1 --debug_mds 10'}
How to query the current setting and how to disable or cancel the setting?

Please help me~ Thank you!!!


Best Regards,
Anny
