From: John Spray <jspray@redhat.com>
Subject: Re: how to get io statistics data
Date: Fri, 16 Feb 2018 12:41:14 +0000
Message-ID: <CALe9h7dJSsGyNQ0Bh86bcLABWdN_Sqhx-qz=piqnjExOE1JmEw@mail.gmail.com>
References: <CAE63xUOJzZnQ9DGrvXM2p2a8OtB3dRRg5zgxw8Z4P0fUYtR_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34672 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967151AbeBPMlg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Feb 2018 07:41:36 -0500
Received: by mail-wm0-f46.google.com with SMTP id j21so5374847wmh.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Feb 2018 04:41:36 -0800 (PST)
In-Reply-To: <CAE63xUOJzZnQ9DGrvXM2p2a8OtB3dRRg5zgxw8Z4P0fUYtR_pg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 16, 2018 at 11:21 AM, Ugis <ugis22@gmail.com> wrote:
> Hi,
>
> I'm working on zabbix template for ceph(I am aware of several existing
> ones but those do not fit well for our needs).
>
> Data form ceph is gathered from cli commands with output in format "-f
> json-pretty", this works nice, but I cannot find a way to read:
> 1) cluster "io" data from "ceph -s" - it does not appear in
> json-pretty format. This is example data:
> "  io:
>     client:   112 kB/s rd, 41058 B/s wr, 6162 op/s rd, 8 op/s wr"
> Is there any cli command to get that "global cluster io" data in json?

The zabbix module (included in Ceph since 12.2.0) gives you the global
wr_ops, rd_ops, wr_bytes, rd_bytes fields.

http://docs.ceph.com/docs/master/mgr/zabbix/

Cheers,
John

> 2) In web GUI (monitorIP:7000/->OSD->OSDs) we see nice "Read bytes",
> "Write bytes", "Read ops", "Write ops".
> How can we get that data per osd in cli in json-pretty format?
> I browsed the source of dashborad here
> https://github.com/ceph/ceph/blob/66838565bd0830a397a4d673bb5584023ee603a5/src/pybind/mgr/dashboard/osds.html
> but did not get clue are there any cli commands related.
>
> Best regards,
> Ugis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
