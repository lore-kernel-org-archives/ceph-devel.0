From: Casey Bodley <cbodley@redhat.com>
Subject: ObjectStore interface and std::list
Date: Thu, 3 Dec 2015 12:46:05 -0500 (EST)
Message-ID: <1412841180.28305561.1449164765461.JavaMail.zimbra@redhat.com>
References: <1147769245.28299019.1449164516705.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:37468 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbLCRqG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:46:06 -0500
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB3Hk5fY011889
	for <ceph-devel@vger.kernel.org>; Thu, 3 Dec 2015 12:46:05 -0500
In-Reply-To: <1147769245.28299019.1449164516705.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I missed out on the context leading up to the discussion about
queue_transactions and the use of raw vs. smart pointers, but I'm curious
whether the use of std::list in the ObjectStore interface has come up as
well. That's another source of allocations that could be avoided.

A naive approach could just replace the list with vector, which could at
least reduce the number of allocations to one if you reserve() space for
all of your elements up front.

An interface based on iterators could also help, by allowing the caller to
put an array on the stack and pass that in. Iterators are tricky because
the generic form requires templates, and template functions can't be
virtual. But if we require the elements to be sequential in memory (i.e.
raw array, std::array<Transaction*> or std::vector<Transaction*>), the
interface could take (Transaction** begin, Transaction** end) without
requiring templates. This interface can also be made compatible with
unique_ptrs.

Casey
