From: Matt Benjamin <mbenjamin@redhat.com>
Subject: boost::container::static_vector
Date: Wed, 25 May 2016 11:24:07 -0400 (EDT)
Message-ID: <1185676289.39418531.1464189847415.JavaMail.zimbra@redhat.com>
References: <312082555.39416278.1464189616544.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:38160 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcEYPYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 11:24:09 -0400
In-Reply-To: <312082555.39416278.1464189616544.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Hi Radek (CC's),

It seems that static_vector isn't on the boost on RHEL/Centos 7;  I'm not sure if small_vector is;  I think we were approaching consensus on solving this... I'll revisit this in #ceph-devel and on standup.  

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
