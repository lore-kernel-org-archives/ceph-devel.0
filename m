From: Casey Bodley <cbodley@redhat.com>
Subject: Branch for C++11
Date: Tue, 4 Aug 2015 11:01:14 -0400 (EDT)
Message-ID: <1153187644.1670925.1438700474782.JavaMail.zimbra@redhat.com>
References: <1035804211.1644064.1438696866303.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43177 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbbHDPBP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 11:01:15 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t74F1EJ3049767
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2015 11:01:14 -0400
In-Reply-To: <1035804211.1644064.1438696866303.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've pushed a wip-cxx11 branch to github that adds the -std=c++11 flag for both cmake and automake builds, and fixes the resulting compilation errors.

The switch to c++11 has two main implications:
* platform support: as expected, gitbuilder is reporting failures on precise and centos6 due to their older compilers
* ABI change: Sam started a discussion on the list yesterday about how to deal with librados clients

I would also like to track the state of compiler support for c++14 (and beyond), so that we can adopt them as soon as it's practical.

Casey
