From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Help debugging RGW bug in jewel 10.2.8 integration branch
Date: Sun, 9 Apr 2017 09:02:31 -0700
Message-ID: <CAMMFjmEZjc8H_RwWubOGg-yC=WJaH7hTBfAu_CzzivHPt1LKyQ@mail.gmail.com>
References: <b0339864-0d92-704e-597a-77981e057999@suse.cz> <7a6ea2c2-0f49-177d-e2f6-28b97b620280@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:32774 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdDIQCd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Apr 2017 12:02:33 -0400
Received: by mail-wr0-f176.google.com with SMTP id l28so5317552wre.0
        for <ceph-devel@vger.kernel.org>; Sun, 09 Apr 2017 09:02:33 -0700 (PDT)
In-Reply-To: <7a6ea2c2-0f49-177d-e2f6-28b97b620280@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just a note that rgw passed for v10.2.7
So we may need to split PRs in smaller batches to find offending one.

On Sun, Apr 9, 2017 at 8:28 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> All the failures appear to be in rgw/verify and rgw/multifs
>
>
> On 04/09/2017 03:33 PM, Nathan Cutler wrote:
>>
>> Hello RGW developers:
>>
>> Since 10.2.7 is almost out, I'm now running integration tests for
>> 10.2.8. As usual, there is quite a crop of RGW backports. The
>> integration branch is "wip-jewel-backports" and the RGW suite [1] is not
>> looking good: over 50 failures, and most of them are this:
>>
>> ======================================================================
>> FAIL: s3tests.functional.test_s3.test_versioning_obj_suspend_versions
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>   File
>>
>> "/home/ubuntu/cephtest/s3-tests/virtualenv/local/lib/python2.7/site-packages/nose/case.py",
>> line 197, in runTest
>>     self.test(*self.arg)
>>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
>> line 6385, in test_versioning_obj_suspend_versions
>>     overwrite_suspended_versioning_obj(bucket, objname, k, c, 'null
>> content 2')
>>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
>> line 6243, in overwrite_suspended_versioning_obj
>>     check_obj_versions(bucket, objname, k, c)
>>   File "/home/ubuntu/cephtest/s3-tests/s3tests/functional/test_s3.py",
>> line 6080, in check_obj_versions
>>     eq(keys[i].version_id or 'null', key.version_id)
>> AssertionError: u'yGSvpxjEbJRBE.JL76y4OzeJISqDtmJ' != u'null'
>>
>> Does anyone have an idea which of these PRs [2] might be the culprit?
>>
>> [1]
>>
>> http://pulpito.ceph.com/smithfarm-2017-04-07_09:30:57-rgw-wip-jewel-backports-distro-basic-smithi/
>>
>> [2]
>>
>> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel+label%3Argw
>>
>>
>> Thanks in advance,
>> Nathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
