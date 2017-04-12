From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Help debugging RGW bug in jewel 10.2.8 integration branch
Date: Wed, 12 Apr 2017 15:28:05 +0200
Message-ID: <1325c536-9bd0-2708-271a-2c05abca5e16@suse.cz>
References: <b0339864-0d92-704e-597a-77981e057999@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbdDLN2H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Apr 2017 09:28:07 -0400
In-Reply-To: <b0339864-0d92-704e-597a-77981e057999@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Orit Wasserman <owasserm@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

Hi Orit, Yehuda:

Regarding the 
s3tests.functional.test_s3.test_versioning_obj_suspend_versions failure 
that we were seeing in the 10.2.8 integration branch (see quoted email 
below), Abhishek and I bisected it with the conclusion that 
https://github.com/ceph/ceph/pull/13552 is causing the failure. I marked 
that PR "DNM" and will schedule a new round of jewel integration tests.

Nathan

On 04/09/2017 03:33 PM, Nathan Cutler wrote:
> Hello RGW developers:
>
> Since 10.2.7 is almost out, I'm now running integration tests for
> 10.2.8. As usual, there is quite a crop of RGW backports. The
> integration branch is "wip-jewel-backports" and the RGW suite [1] is not
> looking good: over 50 failures, and most of them are this:
>
> ======================================================================
> FAIL: s3tests.functional.test_s3.test_versioning_obj_suspend_versions
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File
> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-packages/nose/case.py",
> line 197, in runTest
>     self.test(*self.arg)
>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
> line 6385, in test_versioning_obj_suspend_versions
>     overwrite_suspended_versioning_obj(bucket, objname, k, c, 'null
> content 2')
>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
> line 6243, in overwrite_suspended_versioning_obj
>     check_obj_versions(bucket, objname, k, c)
>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
> line 6080, in check_obj_versions
>     eq(keys[i].version_id or 'null', key.version_id)
> AssertionError: u'yGSvpxjEbJRBE.JL76y4OzeJISqDtmJ' != u'null'
>
> Does anyone have an idea which of these PRs [2] might be the culprit?
>
> [1]
> http://pulpito.ceph.com/smithfarm-2017-04-07_09:30:57-rgw-wip-jewel-backports-distro-basic-smithi/
>
> [2]
> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel+label%3Argw
>
>
> Thanks in advance,
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
