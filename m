From: Mark Nelson <mark.nelson@inktank.com>
Subject: Profiling with Perf
Date: Wed, 12 Nov 2014 14:42:35 -0600
Message-ID: <5463C63B.2070502@redhat.com>
References: <5462C456.8070601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35961 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 15:42:35 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn18so3734580igb.7
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 12:42:34 -0800 (PST)
Received: from [192.168.1.3] (65-128-164-140.mpls.qwest.net. [65.128.164.140])
        by mx.google.com with ESMTPSA id au2sm8422623igc.4.2014.11.12.12.42.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:42:33 -0800 (PST)
In-Reply-To: <5462C456.8070601@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, there was a question on the performance call today about how to use 
dwarf symbols in perf.  Roughly:

1) Make sure during the kernel/perf compile that libunwind is used. 
This can be tricky depending on how you build the kernel, but 
theoretically should work.

2) invoke perf using something like:

"perf record -g dwarf -F 100 -a"

This tells perf to use dwarf symbols but limit the sampling rate.  perf 
can generate a *lot* of data with dwarf symbols and default sampling.

3) Look at results in perf report as normal.

4) Profit!

Theoretically if you have frame pointers enabled when you compile ceph 
you should get good symbol resolution without dwarf but I've never 
gotten it to work well.  Perf+Dwarf seems to give much better symbol 
resolution than anything else I've tried with Ceph.  There's some new 
LBR functionality for profiling on Haswell in perf that might work too, 
but I haven't tried it:

https://lkml.org/lkml/2014/10/19/166

Mark
