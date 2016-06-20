From: Odintsov Vladislav <VlOdintsov@croc.ru>
Subject: Re: [rgw][hammer] quota. how it should work?
Date: Mon, 20 Jun 2016 16:27:44 +0000
Message-ID: <1466440058085.65588@croc.ru>
References: <1454656838403.96770@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ironport2.croc.moscow ([195.38.23.105]:38829 "EHLO
	ironport2.croc.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbcFTQju convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 12:39:50 -0400
In-Reply-To: <1454656838403.96770@croc.ru>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all again,

I've performed some investigation, and I see, that quoting doesn't work with POST methods (I checked hammer branch, because I've got no ability to check others right now).
I found, that if we PUT object, here https://github.com/ceph/ceph/blob/v0.94.6/src/rgw/rgw_op.cc#L497 s->object has object's name and successfully loads quota's config. It gets name from uri (correct me if I'm wrong), because it's PUT request.
we can see it from logs:
2016-06-17 15:02:16.326193 7f3a075fe700 10 s->object=4 s->bucket=222
2016-06-17 15:02:16.326210 7f3a075fe700  2 req 4:0.000116:s3:PUT /4::getting op

But if we POST object, we can't determine the object's name here: https://github.com/ceph/ceph/blob/v0.94.6/src/rgw/rgw_rest_s3.cc#L2094 and init_quota() doesn't load right quota configuration, it loads default disabled quotas.
Related logs:
2016-06-17 15:00:58.236971 7f39cabdd700 10 s->object=<NULL> s->bucket=222
2016-06-17 15:00:58.236993 7f39cabdd700  2 req 1:0.000204:s3:POST /222::getting op

It seems, that we have a backdoor to avoid bucket/user quotas just using POST method?
Is this fixed in master and we should move to jewel or these tickets should be reopened?:
http://tracker.ceph.com/issues/11323
http://tracker.ceph.com/issues/11727
http://tracker.ceph.com/issues/11728

or I don't understand anything?

Regards,
Vladislav Odintsov

________________________________________
From: Odintsov Vladislav
Sent: Friday, February 5, 2016 10:20
To: ceph-users@lists.ceph.com
Subject: [rgw][hammer] quota. how it should work?

Hi all,

I'm trying to set up a bucket quotas in hammer and I don't get any errors using S3 API and ceph documentation, when I exceed the limit (of total count of objects in a bucket, of bucket size), so I've got questions:

There are two places, where I can configure quotas: user and bucket of this user.

User:

# radosgw-admin user info --uid=6e4cc9e4-2262-4dc9-b3b5-f94c7878991c
{
    "user_id": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
    "display_name": "user@cloud.croc.ru",
    "email": "",
    "suspended": 0,
    "max_buckets": 100000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
            "access_key": "user:user@cloud.croc.ru",
            "secret_key": "key"
        }
    ],
    "swift_keys": [],
    "caps": [],
    "op_mask": "read, write, delete",
    "default_placement": "",
    "placement_tags": [],
    "bucket_quota": {
        "enabled": true,
        "max_size_kb": 2,
        "max_objects": -1
    },
    "user_quota": {
        "enabled": false,
        "max_size_kb": -1,
        "max_objects": -1
    },
    "temp_url_keys": []
}

# radosgw-admin bucket stats --bucket=eee
{
    "bucket": "eee",
    "pool": ".rgw.buckets",
    "index_pool": ".rgw.buckets.index",
    "id": "default.4554.5",
    "marker": "default.4554.5",
    "owner": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
    "ver": "0#1",
    "master_ver": "0#0",
    "mtime": "2016-02-05 10:05:41.000000",
    "max_marker": "0#",
    "usage": {},
    "bucket_quota": {
        "enabled": false,
        "max_size_kb": -1,
        "max_objects": -1
    }
}


Well, in user object bucket_quota is enabled and limited to 2 kb, but in bucket object bucket_quota is disabled. Which quota is respectable?
I will not be rejected if I put in bucket of this user object larger, then the quota.

I POSTed 5kb object to this bucket without any problems:
# radosgw-admin bucket stats --bucket=eee
{
    "bucket": "eee",
    "pool": ".rgw.buckets",
    "index_pool": ".rgw.buckets.index",
    "id": "default.4554.5",
    "marker": "default.4554.5",
    "owner": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
    "ver": "0#3",
    "master_ver": "0#0",
    "mtime": "2016-02-05 10:05:41.000000",
    "max_marker": "0#",
    "usage": {
        "rgw.main": {
            "size_kb": 5,
            "size_kb_actual": 8,
            "num_objects": 1
        }
    },
    "bucket_quota": {
        "enabled": false,
        "max_size_kb": -1,
        "max_objects": -1
    }
}

Now, I'm trying to set quota on bucket and empty the bucket:

# radosgw-admin quota set --bucket=eee --max-size=2048
# radosgw-admin quota enable --bucket=eee
# radosgw-admin bucket stats --bucket=eee
{
    "bucket": "eee",
    "pool": ".rgw.buckets",
    "index_pool": ".rgw.buckets.index",
    "id": "default.4554.5",
    "marker": "default.4554.5",
    "owner": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
    "ver": "0#5",
    "master_ver": "0#0",
    "mtime": "2016-02-05 10:13:02.000000",
    "max_marker": "0#",
    "usage": {
        "rgw.main": {
            "size_kb": 0,
            "size_kb_actual": 0,
            "num_objects": 0
        }
    },
    "bucket_quota": {
        "enabled": true,
        "max_size_kb": 2,
        "max_objects": -1
    }
}

POSTing 5 kb object, and it again works.

af27: ==> /var/log/httpd/rgw-ssl-access.log <==
af27: 172.20.33.121 - - [05/Feb/2016:10:18:39 +0300] "POST /eee HTTP/1.1" 204 - "https://console.c2.croc.ru/storage" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36"

# radosgw-admin bucket stats --bucket=eee
{
    "bucket": "eee",
    "pool": ".rgw.buckets",
    "index_pool": ".rgw.buckets.index",
    "id": "default.4554.5",
    "marker": "default.4554.5",
    "owner": "6e4cc9e4-2262-4dc9-b3b5-f94c7878991c",
    "ver": "0#7",
    "master_ver": "0#0",
    "mtime": "2016-02-05 10:13:02.000000",
    "max_marker": "0#",
    "usage": {
        "rgw.main": {
            "size_kb": 5,
            "size_kb_actual": 8,
            "num_objects": 1
        }
    },
    "bucket_quota": {
        "enabled": true,
        "max_size_kb": 2,
        "max_objects": -1
    }
}


What am I doing wrong?
Or, maybe there's a bug? I'm using 0.94.5 version of ceph, rhel 6.6.
There was a bug, but it seems to be fixed:
http://tracker.ceph.com/issues/11727

Thanks for any thoughts.

---
Regards,

Vladislav Odintsov
System Engineer of Croc Cloud Development Team
