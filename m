From: Abhishek L <abhishek@suse.com>
Subject: RGW & Object Tagging
Date: Wed, 01 Mar 2017 18:13:49 +0100
Message-ID: <874lzcq5rm.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:42315 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdCARfe (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 1 Mar 2017 12:35:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>

Last November, S3 introduced a new set of APIs for Object Tagging[1],
which are simply key value metadata associated with objects, this
however doesn't seem to be an API wrapped around the already existing
x-amz-meta-* tags[2]. Also, beyond an API to GET/PUT/POST tags, S3 also
seems to have support for tags in their LifeCycle, ACL and CloudWatch
Metrics.

Would such an API make sense for RGW?
I'd imagine implementing the API itself wouldn't be that difficult and
would fit similar to the way we handle object metadata & ACLs etc
currently. Adding this to elasticsearch might be interesting, but
supporting this in ACLs & LifeCycle might require much more work.
Thoughts?

[1]:
https://aws.amazon.com/about-aws/whats-new/2016/11/revolutionizing-s3-storage-management-with-4-new-features/
[2]: http://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html

Best,
Abhishek


