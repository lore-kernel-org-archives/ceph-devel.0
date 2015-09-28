From: Shinobu Kinjo <skinjo@redhat.com>
Subject: [Workaround] Keystone VPI v3
Date: Mon, 28 Sep 2015 18:54:15 -0400 (EDT)
Message-ID: <577037893.22950080.1443480855722.JavaMail.zimbra@redhat.com>
References: <1054018927.22946539.1443479402327.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:49046 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbbI1WyQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 18:54:16 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8SMsFMS013050
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 18:54:15 -0400
In-Reply-To: <1054018927.22946539.1443479402327.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Since the OpenStack Keystone team will move to use v3 API and try to decommission v2 completely, probably we need to modify codes in /src/rgw/.

    ./src/common/config_opts.h
    ./src/rgw/rgw_json_enc.cc
    ./src/rgw/rgw_swift.cc
    ./src/rgw/rgw_swift_auth.cc
    ./src/rgw/rgw_rest_swift.cc
    ./src/rgw/rgw_keystone.h

I think that there is no backward compatibility for v2 anymore because of security reason.
What do you think?

I'm pretty sure I've missed something anyhow -;

Shinobu
