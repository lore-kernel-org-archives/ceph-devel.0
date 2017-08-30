From: Sage Weil <sweil@redhat.com>
Subject: build-integration-branch
Date: Wed, 30 Aug 2017 20:58:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708302045570.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbdH3U6z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Aug 2017 16:58:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A52467E43D
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 20:58:55 +0000 (UTC)
Received: from ovpn-112-5.rdu2.redhat.com (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B3CE77DE4
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 20:58:55 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I got tired of doing this by hand and finally wrote a script to do it 
instead:

	https://github.com/ceph/ceph/pull/17382

Go tag your PRs with wip-whatever-testing, then

 git checkout master
 git pull
 ../src/script/build-integration-branch wip-whatever-testing
 make && ctest -j12 && git push ci $(git rev-parse --abbrev-ref HEAD)

All I need to do now is make the ceph-disk tox test pass on Fedora...

sage
