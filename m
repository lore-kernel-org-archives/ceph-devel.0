From: Jan Fajerski <jfajerski@suse.com>
Subject: formatting bytes and object counts in ceph status ouput
Date: Tue, 2 Jan 2018 11:43:03 +0100
Message-ID: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60694 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeABKng (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 2 Jan 2018 05:43:36 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-Users <ceph-users@ceph.com>

Hi lists,
Currently the ceph status output formats all numbers with binary unit prefixes, 
i.e. 1MB equals 1048576 bytes and an object count of 1M equals 1048576 objects.  
I received a bug report from a user that printing object counts with a base 2 
multiplier is confusing (I agree) so I opened a bug and 
https://github.com/ceph/ceph/pull/19117.
In the PR discussion a couple of questions arose that I'd like to get some 
opinions on:
- Should we print binary unit prefixes (MiB, GiB, ...) since that would be 
  technically correct?
- Should counters (like object counts) be formatted with a base 10 multiplier or 
  a multiplier woth base 2?

My proposal would be to both use binary unit prefixes and use base 10 
multipliers for counters. I think this aligns with user expectations as well as 
the relevant standard(s?).

Best,
Jan
