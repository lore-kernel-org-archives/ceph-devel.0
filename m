From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Clocks out of sync
Date: Fri, 20 Feb 2015 18:14:38 -0500 (EST)
Message-ID: <855846157.24852759.1424474078493.JavaMail.zimbra@redhat.com>
References: <54E7BE6D.5040503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:44586 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbbBTXOi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 18:14:38 -0500
In-Reply-To: <54E7BE6D.5040503@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

David,

We had ntp server issue tot too long ago, could be the same or new

http://tracker.ceph.com/issues/10675

Thx
YuriW

----- Original Message -----
From: "David Zafman" <dzafman@redhat.com>
To: ceph-devel@vger.kernel.org
Sent: Friday, February 20, 2015 3:08:29 PM
Subject: Clocks out of sync


On 2 of my rados thrash runs clocks out of sync.   Is this an occasional 
issue or did we have an infrastructure problem?

On burnupi19 and burnupi25:
2015-02-20 12:52:52.636017 mon.1 10.214.134.14:6789/0 177 : cluster 
[WRN] message from mon.0 was stamped 0.501458s in the future, clocks not 
synchronized

On plana62 and plana64:
2015-02-20 10:00:56.842533 mon.0 10.214.132.14:6789/0 3 : cluster [WRN] 
message from mon.1 was stamped 0.855106s in the future, clocks not 
synchronized


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
