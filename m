From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 12 Jun 2017 10:26:27 -0400 (EDT)
Message-ID: <1284111406.22125094.1497277587133.JavaMail.zimbra@redhat.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <f483cee0-0a90-0571-d993-d1784e6a39ec@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbdFLO0b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 10:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D39433458C
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 14:26:30 +0000 (UTC)
In-Reply-To: <f483cee0-0a90-0571-d993-d1784e6a39ec@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dang@redhat.com
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

The nfs gateways are clients of either libcephfs or librgw, so in the first instance, I would say that librgw, for example, which creates an RGW instance, should be the client of this API.

Matt

----- Original Message -----
> From: "Daniel Gryniewicz" <dang@redhat.com>
> To: "John Spray" <jspray@redhat.com>, "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Monday, June 12, 2017 10:14:02 AM
> Subject: Re: Extra daemons/servers reporting to mgr
> 
> On 06/11/2017 08:04 AM, John Spray wrote:
> > MgrClient instances (such as those in the daemons, and those in every
> > librados instance) open a session with ceph-mgr where they identify
> > themselves by entity name and type.  ceph-mgr sends a MgrConfigure
> > message, which tells the client whether to both sending stats and how
> > often.  ceph-mgr also keeps a copy of the metadata (a la "ceph osd
> > metadata...") for OSD and MDS daemons -- it loads all that up at
> > startup, and then also freshens it when it sees a daemon restart or
> > sees a new daemon.
> >
> > We would like to have something similar so that the mgr can be aware
> > of the existence of other services like RGW gateways, RBD mirror
> > services, perhaps also NFS gateways.
> >
> > The information about each daemon would at a minimum be its identity,
> > type, and some static metadata.  It might also include some dynamic
> > state/health structure.  The challenging part here is how to expose
> > that to the various daemons, given that things like RGW are not known
> > in advance to core Ceph and that they just consume the librados
> > interface.
> >
> > It doesn't feel like a particularly natural thing for librados, but
> > ultimately whatever we expose to rgw/rbd is de-facto librados, even if
> > we put it in a different library or whatever.
> >
> > So far I've got as far as thinking we should have an extra call just
> > in the C++ bindings that lets callers say "Hi, I'm a service not just
> > a client, and here's a map of metadata", that they call one time
> > between creating their RadosClient and connecting to the cluster.
> >
> 
> This seems fine, but if we want NFS gateways, too, then a C API would be
> helpful.
> 
> Daniel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
