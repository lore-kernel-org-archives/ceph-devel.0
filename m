From: John Spray <jspray@redhat.com>
Subject: Re: For calamari <= 1.3.x, ceph.client.admin.keyring on all nodes, or
 just mons?
Date: Mon, 23 May 2016 10:18:33 +0100
Message-ID: <CALe9h7f3b+Sj8bjEyH6op96yzT_Qtfyzxcg=g4Tt++exWSw88Q@mail.gmail.com>
References: <574263AE.3010401@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33138 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbcEWJSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2016 05:18:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id k23so61262433oih.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 02:18:53 -0700 (PDT)
In-Reply-To: <574263AE.3010401@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 23, 2016 at 2:58 AM, Tim Serong <tserong@suse.com> wrote:
> Hi All,
>
> Quick question: for Calamari <= 1.3.x, the ceph salt module that does
> cluster heartbeats and whatnot needs
> /etc/ceph/ceph.client.admin.keyring.  Does that need to exist on all
> cluster nodes, or only on the MONs?

Unless it changed since my days with the code, it should only be
needed on the mon.  See get_heartbeats(), where the cluster_heartbeat
part only acts if mon_sockets was populated.

John

> Thanks,
>
> Tim
> --
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
