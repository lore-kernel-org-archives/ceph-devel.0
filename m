From: Samuel Just <sjust@redhat.com>
Subject: Re: hammer mon regression I think, probably shouldn't do a hammer
 release until it's sorted
Date: Wed, 29 Jul 2015 14:20:31 -0400 (EDT)
Message-ID: <931100884.856074.1438194031932.JavaMail.zimbra@redhat.com>
References: <1709588025.854639.1438193897253.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40412 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbbG2SUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 14:20:32 -0400
In-Reply-To: <1709588025.854639.1438193897253.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <ldachary@redhat.com>, Sage Weil <sweil@redhat.com>, Kefu Chai <kchai@redhat.com>, Joao Luis <jluis@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Could also be a next/master regression, don't actually see anything recent in the mon in hammer.
-Sam

----- Original Message -----
From: "Samuel Just" <sjust@redhat.com>
To: "Loic Dachary" <ldachary@redhat.com>, "Sage Weil" <sweil@redhat.com>, "Kefu Chai" <kchai@redhat.com>, "Joao Luis" <jluis@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Wednesday, July 29, 2015 11:18:17 AM
Subject: hammer mon regression I think, probably shouldn't do a hammer release until it's sorted

http://tracker.ceph.com/issues/12410

Not sure what's going on yet, but the hammer mon doesn't seem to be sending the full map to the master osd properly.
-Sam


