From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/3] libceph: get rid of ack vs commit
Date: Thu, 23 Feb 2017 21:43:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702232142510.7782@piezo.novalocal>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com> <1487883561-32001-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47035 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdBWVnr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 16:43:47 -0500
In-Reply-To: <1487883561-32001-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Zheng Yan <zyan@redhat.com>

On Thu, 23 Feb 2017, Ilya Dryomov wrote:
> - CEPH_OSD_FLAG_ACK shouldn't be set anymore, so assert on it

Conversely, FLAG_ONDISK should *always* be set.  We should probably assert 
that as well.

sage
