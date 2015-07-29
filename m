From: Samuel Just <sjust@redhat.com>
Subject: hammer mon regression I think, probably shouldn't do a hammer
 release until it's sorted
Date: Wed, 29 Jul 2015 14:18:17 -0400 (EDT)
Message-ID: <1709588025.854639.1438193897253.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:47564 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbG2SSR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 14:18:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <ldachary@redhat.com>, Sage Weil <sweil@redhat.com>, Kefu Chai <kchai@redhat.com>, Joao Luis <jluis@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/12410

Not sure what's going on yet, but the hammer mon doesn't seem to be sending the full map to the master osd properly.
-Sam
