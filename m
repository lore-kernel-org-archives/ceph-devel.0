From: Sage Weil <sage@newdream.net>
Subject: Re: question about setuser-match-path
Date: Thu, 5 Mar 2020 14:17:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.2003051414310.29770@piezo.novalocal>
References: <56829C2A36C2E542B0CCB9854828E4D8562BB8A8@CDSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:57159 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEORb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2020 09:17:31 -0500
In-Reply-To: <56829C2A36C2E542B0CCB9854828E4D8562BB8A8@CDSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Haochuan Z" <haochuan.z.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "dev@ceph.io" <dev@ceph.io>

On Thu, 5 Mar 2020, Chen, Haochuan Z wrote:
> Hi
> 
> I wonder what's this arg "--setuser-match-path=", and with this arg set, 
> what will do for ceph daemon.

This is a workaround to enable easier upgrades from ceph version when 
the ceph-osd daemon ran as root.  When we first started running as user 
'ceph', it was necessary to either (1) chown -R ceph:ceph all of the 
files on the HDD/SSD (filestore!), which could take hours, or (2) somehow 
conditionally make ceph-osd continue to run as root instead of dropping to 
user ceph.  This flag allows that by checking whether the path is owned by 
the intended uid/gid to setuid too.. and if it doesn't match, we 
skip the calls to setuid (and continue running as root).

This all happened back in the giant or hammer release, I think.  But we 
need to keep this around since there are still OSDs with filestore that 
were created back then that are owned by root.

sage
