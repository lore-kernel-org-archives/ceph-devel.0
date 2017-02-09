From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Breakage in Clang compile....
Date: Thu, 9 Feb 2017 16:35:27 +0100
Message-ID: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:55978 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbdBIPgI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 10:36:08 -0500
Received: from [192.168.101.50] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 6FC3D3815D
        for <ceph-devel@vger.kernel.org>; Thu,  9 Feb 2017 16:35:28 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I think this is a recent addition to the game?
And Clang does not really like it.

In file included from
/home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21:
/home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
error: array initializer must be an initializer list
      : m_axes_config(other.m_axes_config) {
        ^
/home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
note: in instantiation of member function
'PerfHistogram<2>::PerfHistogram' requested here
        histogram.reset(new PerfHistogram<>(*other.histogram));
                            ^
1 error generated.

--WjW
