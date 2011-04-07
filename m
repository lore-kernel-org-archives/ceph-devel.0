From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Where I can find the definition/meanings of options parameter in /src/common/config.cc
Date: Thu, 7 Apr 2011 09:33:05 -0700
Message-ID: <BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35308 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1DGQdH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 12:33:07 -0400
Received: by fxm17 with SMTP id 17so1789027fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 09:33:06 -0700 (PDT)
In-Reply-To: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi AnnyRen,

These parameters are set in your ceph.conf file. You can find their
value by looking in the ceph.conf file, or by running

=2E/cconf -c <path-to-ceph-conf-file> --lookup <param_name>

Also, after using injectargs to change a setting related to logging,
you must send the process a SIGHUP to get it to re-read its logging
settings.

cheers,
Colin


On Thu, Apr 7, 2011 at 2:44 AM, AnnyRen <annyren6@gmail.com> wrote:
> Hi:
>
> I'm trying to tune the options parameters defined in config.cc, like
>
> =A0OPTION(mon_osd_down_out_interval, 0, OPT_INT, 300), // seconds
> =A0OPTION(mds_replay_interval, 0, OPT_FLOAT, 1.0), // time to wait
> before starting replay again
> =A0OPTION(mds_shutdown_check, 0, OPT_INT, 0),
> =A0OPTION(mds_thrash_exports, 0, OPT_INT, 0),
> =A0OPTION(mds_thrash_fragments, 0, OPT_INT, 0),
> =A0OPTION(mds_dump_cache_on_map, 0, OPT_BOOL, false),
> =A0OPTION(mds_dump_cache_after_rejoin, 0, OPT_BOOL, false),
> =A0OPTION(mds_verify_scatter, 0, OPT_BOOL, false),
> =A0OPTION(mds_debug_scatterstat, 0, OPT_BOOL, false),
> =A0OPTION(mds_debug_frag, 0, OPT_BOOL, false),
> =A0OPTION(mds_kill_mdstable_at, 0, OPT_INT, 0),
> =A0OPTION(mds_kill_export_at, 0, OPT_INT, 0),
> =A0OPTION(mds_kill_import_at, 0, OPT_INT, 0),
> =A0OPTION(mds_kill_rename_at, 0, OPT_INT, 0),
> =A0OPTION(mds_wipe_sessions, 0, OPT_BOOL, 0),
>
> to test the functionalities and performance in ceph,
> Could you tell me where to find the definitions of all parameters, so
> I could tune Ceph to run with the best performance?
> Thanks very much!
>
> Another question is if I want to adjust a config option, but I don't
> want to modify the ceph.conf and restart the monitor,
> could I use =A0 { ceph mon injectargs 0 '--mon_osd_down_out_interval
> 600' =A0 =A0 } =A0 =A0the instruction to modify the settings?
> and how can I query the current settings I had made?
>
> For example
> I use the following command to enable debug messages
> {ceph mds injectargs 0 '--debug_ms 1 --debug_mds 10'}
> How to query the current setting and how to disable or cancel the set=
ting?
>
> Please help me~ Thank you!!!
>
>
> Best Regards,
> Anny
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
