From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v2] Samba RADOS service registration
Date: Thu, 15 Feb 2018 19:52:19 +0100
Message-ID: <20180215195219.259acfc8@suse.de>
References: <20180213022540.5f9686b7@suse.de>
        <20180213202727.77175e21@suse.de>
        <1518718185.4086.45.camel@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162019AbeBOSwV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:52:21 -0500
In-Reply-To: <1518718185.4086.45.camel@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@samba.org>
Cc: Samba Technical <samba-technical@lists.samba.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jeff,

On Thu, 15 Feb 2018 13:09:45 -0500, Jeff Layton wrote:

> IIUC, if the program (samba in this case) dies, and then is restarted
> (maybe host reboots?), it'll get a new instance_guid, right? Or am I
> misunderstanding what rados_get_instance_id will return here?

Yes, that's right. On smbd restart it'll reconnect and get a new
instance ID. The hostname is carried in the metadata, which makes it a
little easier to identify what's going on from the Ceph side.

AFAICT the service record (unfortunately) remains present after
rados_shutdown() until a timeout on the manager is tripped, so
it's quite possible to have to registrations for the same host for a
short amount of time.

Cheers, David
