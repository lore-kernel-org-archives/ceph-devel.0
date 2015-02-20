From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Disk failing plana74
Date: Fri, 20 Feb 2015 16:34:30 -0500 (EST)
Message-ID: <1767156244.24687656.1424468070517.JavaMail.zimbra@redhat.com>
References: <54E7A2D8.7070906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40864 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbBTVeb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 16:34:31 -0500
In-Reply-To: <54E7A2D8.7070906@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sandon Van Ness <svanness@redhat.com>, ceph-devel@vger.kernel.org

I ran smart and it came back good, hmm

ubuntu@plana74:~$ /usr/libexec/smart.pl 
All 4 drives happy as clams

Thx
YuriW

----- Original Message -----
From: "David Zafman" <dzafman@redhat.com>
To: "Sandon Van Ness" <svanness@redhat.com>
Cc: ceph-devel@vger.kernel.org
Sent: Friday, February 20, 2015 1:10:48 PM
Subject: Disk failing plana74


A recent test run had an EIO on the following disk:

plana74 /dev/sdb

The machine is locked right now.

David Zafman
Senior Developer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
