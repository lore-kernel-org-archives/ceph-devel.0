From: Tim Serong <tserong@suse.com>
Subject: debugging mgr python modules
Date: Tue, 23 Jan 2018 11:38:00 +1100
Message-ID: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------721990CC54A84BF10677B6B4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33964 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeAWAiL (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 22 Jan 2018 19:38:11 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------721990CC54A84BF10677B6B4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi All,

Right now, if you want to debug an mgr python module, you're pretty much
restricted to dumping interesting stuff to log files, right?

What about if you wanted to run an interactive python debugger?

I had two half-formed ideas for this.  One is that apparently there's
something called prdb, which could theoretically be loaded in an mgr
module to enable remote debugging over a socket (although
https://pypi.python.org/pypi/rpdb/ says it reroutes stdout and stdin,
which I assume might not work given mgr is already eating those -- not
sure, haven't had a chance to try it yet).

The second idea was to create a python wrapper which provides a stub
implementation of the pieces that ceph-mgr exposes from C++ land
(ceph_state, etc.).  This would expose some fake cluster state, much as
the minion sim thing did in calamari.  Then you could (somehow) load/run
a mgr python module completely outside mgr to experimentally poke at it.
 Having typed all that out  now, I suspect this might be a PITA to
maintain and be ultimately less useful for live debugging that the first
half-formed idea, although it might be interesting for unit testing.

Any thoughts on whether any of the above is worth pursuing?

Thanks,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com

--------------721990CC54A84BF10677B6B4
Content-Type: text/x-vcard;
 name="tserong.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="tserong.vcf"

bnVsbA==
--------------721990CC54A84BF10677B6B4--
