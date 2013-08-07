From: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Subject: Re: Reduce cluster log verbosity
Date: Wed, 7 Aug 2013 12:33:42 +0900
Message-ID: <CANB=HGiYoUJoUS_WtSQj50=wQfWNfd=wyS4g73E86E6Jbd4LXw@mail.gmail.com>
References: <CANB=HGgN44+2V7eCe5yzcEwSgc7bS1ihVVuXnR1yi=csbi-aiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46555 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab3HGDeC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 23:34:02 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so2397278oag.15
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 20:34:02 -0700 (PDT)
In-Reply-To: <CANB=HGgN44+2V7eCe5yzcEwSgc7bS1ihVVuXnR1yi=csbi-aiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Terribly sorry for the double post my bad


On Wed, Aug 7, 2013 at 12:29 PM, Jean-Daniel BUSSY
<silversurfer972@gmail.com> wrote:
> Hi all,
>
> We have log aggregation on our ceph cluster and verbosity is a problem
> on the cluster log file at /etc/ceph/ceph.conf
> I got advice from some nice folk on IRC and I tried to use syslog and
> setup the log level to WARN but the INF logs are still pouring.
> I confirmed settings are changed in the admin socked and got these:
>
>   "clog_to_syslog_level": "warn",
>   "clog_to_syslog_facility": "daemon",
>   "mon_cluster_log_to_syslog": "true",
>   "mon_cluster_log_to_syslog_level": "warn",
>   "mon_cluster_log_to_syslog_facility": "daemon",
>   "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",
>
> I guess I am missing some option flag or something. Any hint?
>
> Thanks
>
> BUSSY Jean-Daniel
> Cloud Engineer
