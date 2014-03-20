From: David Zafman <david.zafman@inktank.com>
Subject: mon_command
Date: Wed, 19 Mar 2014 19:40:37 -0700
Message-ID: <39217F03-EC3A-4542-B00B-F62251B8CC98@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49896 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaCTCkq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 22:40:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so240797pad.21
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 19:40:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org


My understanding is that are going to be using rados_mon_command() to c=
reate pools according to Tracker #7586: deprecate rados_pool_create.  W=
hat I found when building a test case for EC is that after using the mo=
n_command to create the pool I need to use wait_for_latest_osdmap() in =
order to wait for the change to propagate.  The replicated pool test ca=
se using pool_create() doesn=92t need to wait_for_latest_osdmap().

Should we be deprecating librados calls in favor of the very generic mo=
n_command() interface?  I would suggest that we add the appropriate lib=
rados features to manipulate erasure coded pools.

David Zafman
Senior Developer
http://www.inktank.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
