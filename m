From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph logging level
Date: Wed, 2 Jan 2013 08:28:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301020824230.11884@cobra.newdream.net>
References: <CAOLwVU=sxV3U81b3j-r-2=sEruFkOryhv46toPeRgT1Pqj19Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54154 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab3ABQ2j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:28:39 -0500
In-Reply-To: <CAOLwVU=sxV3U81b3j-r-2=sEruFkOryhv46toPeRgT1Pqj19Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Jan 2013, S?bastien Han wrote:
> Hi all,
> 
> I've been struggling with Ceph logging.
> 
> As far as I saw we can log to syslog but we can't specify any
> facility. So my question is: which facility does ceph use by default?

LOG_USER is currently hard-coded.  It would be pretty easy to make this 
configurable... LOG_DAEMON may also be a better default choice.  

> Second thing is, I'm sick of all those "log [INF]" messages from the
> ceph-mon, like:
> 
> Jan  2 13:27:07 ceph02 ceph-mon: 2013-01-02 13:27:07.749511
> 7f227b2fa700  0 log [INF] : pgmap v74529: 80 pgs: 80 active+clean;
> 9753 MB data, 17012 MB used, 383 GB / 399 GB avail
> 
> Is there a way to disable them? Which level is that? INFO? DEBUG?
> 
> Ideally I'd like to disable all INFO logs, I only want to see ERROR logs.

Not currently.  This would be very simple to add.  See mon/LogMonitor.cc:

      if (g_conf->mon_cluster_log_to_syslog) {
	syslog(clog_type_to_syslog_prio(le.type) | LOG_USER, "%s", s.c_str());
      }

We can just add a min log level configurable.

Opened #3704.

sage



> 
> Thanks you in advance :-)
> 
> --
> Regards,
> S?bastien Han.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
