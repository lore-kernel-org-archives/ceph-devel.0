From: Sage Weil <sage@newdream.net>
Subject: Re: Request for subscribing to ceph-devel list
Date: Tue, 9 May 2017 13:34:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705091330280.3646@piezo.novalocal>
References: <CA+b5B09bq6qK2koVigxqaic-9c3jZfTbmznpXeLRG-2maRAvUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35340 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdEINeF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 09:34:05 -0400
In-Reply-To: <CA+b5B09bq6qK2koVigxqaic-9c3jZfTbmznpXeLRG-2maRAvUg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: saumay agrawal <saumay.agrawal@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Saumay,

On Tue, 9 May 2017, saumay agrawal wrote:
> I got selected under GSOC on project ceph-mgr: Cluster Status
> Dashboard. I have subscribed to all the ceph mailing lists. I don't
> how I missed this. Please add me to this mailing list.

Welcome to the project!

You can email majordomo@vger.kernel.org with 'subscribe ceph-devel' in the 
body of the message.  Make sure you are sending plaintext email and not 
HTML mail.

We have a barebones dashboard prototype almost ready to merge; see

	https://github.com/ceph/ceph/pull/14946

It's very basic right now, though, and there is a lot we'd like to add.  
Probably the biggest thing would be adding some visualization for the 
performance counters so you can see cluster IOPS, space utilization, and 
so on!  When do you start?

sage
