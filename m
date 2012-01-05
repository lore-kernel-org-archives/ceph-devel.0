From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: [PATCH 0/2] Add Ceph integration with OCF-compliant HA resource managers
Date: Fri, 06 Jan 2012 00:07:14 +0100
Message-ID: <1392105.DlScea8uhi@mranderson>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:63507 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757717Ab2AEXNz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Jan 2012 18:13:55 -0500
In-Reply-To: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On 2011. December 29. 20:58:00 Florian Haas wrote:
> please consider reviewing the following patches. These add
> OCF-compliant cluster resource agent functionality to Ceph, allowing
> MDS, OSD and MON to run as cluster resources under compliant managers
> (such as Pacemaker, http://www.clusterlabs.org).

Nice work, however, I don't really see the point of running Ceph in a HA 
cluster. If you have more than one machine, then why not deploy Ceph as an 
active-active (Ceph) cluster? If you want an active-backup cluster, then why 
use Ceph?

There might be situations however, where this feature can come handy, although 
I can't think of any right now. Can you sketch up one?

-- 
cc


