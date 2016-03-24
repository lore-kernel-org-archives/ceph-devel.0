From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RBD Utilization
Date: Thu, 24 Mar 2016 12:42:38 +0200
Message-ID: <20160324104237.GA16548@gmail.com>
References: <1674621217.33764396.1458725323072.JavaMail.zimbra@redhat.com>
 <807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36188 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbcCXKmm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 06:42:42 -0400
Received: by mail-lb0-f176.google.com with SMTP id qe11so27220894lbc.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 03:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anmol Babu <anbabu@redhat.com>
Cc: ceph-devel@vger.kernel.org, "Team discussions around SDS management program (aka \"USM\" or \"RHS
	Controller\")" <sds-mgmt@redhat.com>

On Wed, Mar 23, 2016 at 05:35:28AM -0400, Anmol Babu wrote:

> I would like to know how much of my storage is rbd consumed.

rbd du

-- 
Mykola Golub
