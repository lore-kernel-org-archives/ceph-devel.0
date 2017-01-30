From: Nathan Cutler <ncutler@suse.cz>
Subject: hammer 0.94.10 QE: valgrind issues in RGW suite
Date: Mon, 30 Jan 2017 13:00:41 +0100
Message-ID: <0fff1b23-9e4b-507f-7192-f593620e9542@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55093 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753128AbdA3MAt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 07:00:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yuri Weinstein <yweinste@redhat.com>

Hi Yehuda,

In the course of QE testing of the hammer 0.94.10 release, Yuri found 
that the valgrind tests in rgw/verify are red when run in CentOS (7.3 
and 7.2).

I verified this is the case and attempted to bisect, but the tests are 
red in 0.94.9 as well. We suspect it might be an environmental issue in 
CentOS, because the same tests run green in Ubuntu 14.04.

Could you take a look and tell us if this should be considered a blocker 
for release? You can find all the details at 
http://tracker.ceph.com/issues/17151#note-62

Thanks,
Nathan
