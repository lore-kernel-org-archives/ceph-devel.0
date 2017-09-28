From: Sage Weil <sweil@redhat.com>
Subject: Re: CephFS HA support network appliance
Date: Thu, 28 Sep 2017 17:05:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709281703490.15939@piezo.novalocal>
References: <CAKRxpuuBHzqHK0YvTcWdR3LrsOLFYMqp8GzAg0CnPN9QgQ6sng@mail.gmail.com> <alpine.DEB.2.11.1709151841580.16664@piezo.novalocal> <CAKRxpuvCaCcQ26ZhgscRFRvvUE734Xef5G-jvVWS085=qK2TNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1105281528-1506618306=:15939"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdI1RFG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 28 Sep 2017 13:05:06 -0400
In-Reply-To: <CAKRxpuvCaCcQ26ZhgscRFRvvUE734Xef5G-jvVWS085=qK2TNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1105281528-1506618306=:15939
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 28 Sep 2017, Two Spirit wrote:
> Does Ceph support parallel reads through cephfs or is nfs-ganesha required
> to get the pNFS features?

CephFS has all of the parallelism of pNFS.

sage
--8323329-1105281528-1506618306=:15939--
