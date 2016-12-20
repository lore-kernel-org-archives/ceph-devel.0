From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: Feeding pool utilization data to time series for trending
Date: Tue, 20 Dec 2016 12:43:51 +0100
Message-ID: <CAPed3OEP+v3z=+u03TyPq6NpvUSKjQjxz71z3bZtVLNSipP7jQ@mail.gmail.com>
References: <0dafd5ff-1ed6-cb05-05d3-dff3afb43c44@redhat.com>
 <c0ef7893-2bd2-d11f-b008-db566145ce84@redhat.com> <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33063 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbcLTLoM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 06:44:12 -0500
Received: by mail-ua0-f172.google.com with SMTP id b56so13987206uaa.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 03:44:12 -0800 (PST)
In-Reply-To: <aa72804e-767e-aaba-a2a8-e6df0e0a0536@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shubhendu Tripathi <shtripat@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 20, 2016 at 5:19 AM, Shubhendu Tripathi <shtripat@redhat.com> wrote:
> Hi Team,
>
> Our team is currently working on project named "tendrl" [1][2].
> Tendrl is a management platform for software defined storage system like
> Ceph, Gluster etc.
>
> As part of tendrl we are integrating with collectd to collect performance
> data and we maintain the time series data in graphite.
>
> I have a question at this juncture regarding pool utilization data.
> As our thought process goes, we think of using output from command "ceph df"
> and parse it to figure out pool utilization data and push it to graphite
> using collectd.
> The question here is what is/would be performance impact of running "ceph
> df" command on ceph nodes. We should be running this command only on mon
> nodes I feel.
>
> Wanted to verify with the team here if this thought process is in right
> direction and if so what ideally should be frequency of running the command
> "ceph df" from collectd.

Have you looked at Collectd's Ceph plugin
(https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_ceph)

Kind regards,

Ruben Kerkhof
