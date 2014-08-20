From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RadosGW crashing on copy for one specific object
Date: Wed, 20 Aug 2014 15:47:25 +0200
Message-ID: <CAF6-1L6GWKmncQXA_e4NzaFzLqefzQ4O1qikW0zG6k7BrrMvHg@mail.gmail.com>
References: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
	<CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51384 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbaHTNrb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 09:47:31 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so11600915pdi.20
        for <ceph-devel@vger.kernel.org>; Wed, 20 Aug 2014 06:47:25 -0700 (PDT)
In-Reply-To: <CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


> What does 'radosgw-admin object stat --bucket=<bucket> --object=<object>' show?

{ "name": "5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b\/render-image",
  "size": 239879,
  "policy": { "acl": { "acl_user_map": [
                { "user": "kp",
                  "acl": 15}],
          "acl_group_map": [],
          "grant_map": [
                { "id": "kp",
                  "grant": { "type": { "type": 0},
                      "id": "kp",
                      "email": "",
                      "permission": { "flags": 15},
                      "name": "KP S3 User",
                      "group": 0}}]},
      "owner": { "id": "kp",
          "display_name": "KP S3 User"}},
  "etag": "bfe2df862d92f70cecbedbab324e3f78-1",
  "tag": "default.440489.1590546",
  "manifest": { "objs": [
            0,
            { "loc": { "bucket": { "name": "kp-render-image.bouygues",
                      "pool": ".rgw.kp-render-image",
                      "data_extra_pool": "",
                      "index_pool": ".rgw.kp-render-image",
                      "marker": "default.440489.58258",
                      "bucket_id": "default.440489.58258"},
                  "key": "",
                  "ns": "multipart",
                  "object":
"_multipart_5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b\/render-image.8rSDD8MVD1KIXDTQDsf3g6b71dqADP_.1"},
              "loc_ofs": 0,
              "size": 239879}],
      "obj_size": 239879,
      "explicit_objs": "true",
      "head_obj": { "bucket": { "name": "",
              "pool": "",
              "data_extra_pool": "",
              "index_pool": "",
              "marker": "",
              "bucket_id": ""},
          "key": "",
          "ns": "",
          "object": ""},
      "head_size": 0,
      "max_head_size": 0,
      "prefix": "",
      "tail_bucket": { "name": "",
          "pool": "",
          "data_extra_pool": "",
          "index_pool": "",
          "marker": "",
          "bucket_id": ""},
      "rules": []},
  "attrs": { "user.rgw.content_type": "image\/png"}}


> Also, can you bump logging up? debug rgw = 20, debug ms = 1

I'll try, but being on the production cluster, it's constantly
hammered with requests :p


Cheers,

   Sylvain
