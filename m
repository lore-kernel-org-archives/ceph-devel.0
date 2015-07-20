From: huang jun <hjwsm1989@gmail.com>
Subject: Re: [Documentation] Hardware recommandation : RAM and PGLog
Date: Mon, 20 Jul 2015 08:50:33 +0800
Message-ID: <CABAwU-ZsWJn-rUW9nGAoZUaQ9W7VL3y9cK6=YRRAU3NuCbKcGA@mail.gmail.com>
References: <55ABC8E5.1030304@aevoo.fr>
	<55ABCB49.1080304@aevoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:36100 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbGTAuf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jul 2015 20:50:35 -0400
Received: by lagw2 with SMTP id w2so88300292lag.3
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jul 2015 17:50:34 -0700 (PDT)
In-Reply-To: <55ABCB49.1080304@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier AEVOO <david.casier@aevoo.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hi, i don't think the pg log can  be 500MB in size, may be the osd
daemon hold the data of PULL messages in memory during recovery,
there are some options to configure it, like
"osd_client_message_size_cap" and "osd_client_message_cap".
In our test environment, the OSD daemon can consume as mush as 8GB
memory when we add new osd to the cluster.

2015-07-20 0:07 GMT+08:00 David Casier AEVOO <david.casier@aevoo.fr>:
> Hi,
> I have a question about PGLog and RAM consumption.
>
> In the documentation, we read "OSDs do not require as much RAM for regular
> operations (e.g., 500MB of RAM per daemon instance); however, during
> recovery they need significantly more RAM (e.g., ~1GB per 1TB of storage per
> daemon)"
>
> But in fact, all pg log are read in the start of ceph-osd daemon and put in
> RAM ( pg->read_state(store, bl); )
>
> Is this normal behavior or I have a defect in my environment?
>
> Cordialement,
> David Casier.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
thanks
huangjun
