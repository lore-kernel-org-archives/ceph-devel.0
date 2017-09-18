From: Nathan Cutler <ncutler@suse.cz>
Subject: Time to drop 11429.yaml from jewel?
Date: Mon, 18 Sep 2017 15:45:39 +0200
Message-ID: <86a21353-e714-df8c-9b31-3dbde91fe2f6@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753586AbdIRNpl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Sep 2017 09:45:41 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yuri Weinstein <yweinste@redhat.com>

Hi Josh:

rados/singleton-nomsgr/{all/11429.yaml rados.yaml} recently started to 
fail in the jewel integration branch - here are the two most recent runs:

http://qa-proxy.ceph.com/teuthology/smithfarm-2017-09-12_17:11:54-rados-wip-jewel-backports-distro-basic-smithi/1623590/teuthology.log

http://qa-proxy.ceph.com/teuthology/smithfarm-2017-09-13_02:44:35-rados-wip-jewel-backports-distro-basic-smithi/1625890/teuthology.log

Could you help analyze these failures?

I noticed that this test was dropped in the Infernalis development 
cycle. Is it time to drop it in Jewel as well?

Nathan
