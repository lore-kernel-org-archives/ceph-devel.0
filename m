From: Victor Makarov <vitja.makarov@gmail.com>
Subject: radosgw: S3 ListBucket issue
Date: Wed, 17 Feb 2016 15:38:29 +0300
Message-ID: <CAKGHGPSDbY0Mt8PqyC8jWpfjyd7P+aYS8aEq5e_jdPiUVVqaFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33583 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934343AbcBQMia (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 07:38:30 -0500
Received: by mail-lf0-f54.google.com with SMTP id m1so9975929lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 04:38:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Reecently I've found that radosgw S3 ListBucket doesn't set
EncodingType field in ListBucketResult. That makes boto3 (python s3
library) return urlencoded keys instead of unicode keys:

def test_list_bucket(bucket):
    bucket.put_object(Key='foo/bar', Body='')
    for obj in bucket.objects.filter(Prefix='foo'):
        print repr(obj.key)

Prints 'foo%2Fbar' instead of u'foo/bar'. I it fixed here

https://github.com/vitek/ceph/commit/8052362a629fdf2ba7d9bef57fe09086446c3be1

if my commit looks ok I would open pull request.

Another issue is that AWS's S3 urlencodes only ascii characters in
range '\x00' ... '\x0a', while radosgw does full urlencode. I'm not
sure is that a bug or not. But anyway having EncodingType set in
result this wouldn't be an issue for me at least.


Thanks!

-- 
Victor Makarov.
