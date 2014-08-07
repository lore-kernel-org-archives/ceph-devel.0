From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RadosGW storage format
Date: Thu, 7 Aug 2014 10:20:20 -0700
Message-ID: <CABBk=J8UUxTPgQ7uprpVMs2nQea9m78_bezNBMxqV7_ShCwu8g@mail.gmail.com>
References: <CAF6-1L5XC+dFeOAx3bV34qL8T=cFif1xPg=o_L=NotZO4ehx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42914 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264AbaHGRUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 13:20:21 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so5030762ieb.21
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 10:20:20 -0700 (PDT)
In-Reply-To: <CAF6-1L5XC+dFeOAx3bV34qL8T=cFif1xPg=o_L=NotZO4ehx+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I don't think there's one document that describes everything.
Definitely not one that is up to date. It would really be great to
have something like that. Some of the stuff was described in messages
to the mailing list when it was conceived, but things have since might
have gone major revisions and changes.
As a starting point, I can provide a few pointers.

 - How objects are cut:

An object is split into a 'head' part and a logical 'tail' part. The
head will never be more than a predefined chunk size (default is
512k). Objects can either have data in the head or not, and smaller
objects might not have tail (if they fit into the head, and the head
is actually used to hold the data). The head is mapped to a single
rados object. It has a deterministic name, and it is mutable. The tail
is immutable and may map into more than a single rados object.
The tail is made of one or more logical parts, and each part is
striped, using a specific stripe size. Each stripe is mapped into one
rados object.

 - What manifest are:

Manifests are object descriptors. They specify how an object is built.
Prior to firefly, the manifest was just mapping offsets into rados
objects ('explicit' object mapping). Currently, the manifest provides
rules that specify how the different object parts are built and named,
so that it scales much better than the previous method. For example,
the following is a manifest for object 'f4' in bucket 'buck3':

{ "name": "f4",
  "size": 104857600,
  "policy": { "acl": { "acl_user_map": [
                { "user": "yehsad",
                  "acl": 15}],
          "acl_group_map": [],
          "grant_map": [
                { "id": "yehsad",
                  "grant": { "type": { "type": 0},
                      "id": "yehsad",
                      "email": "",
                      "permission": { "flags": 15},
                      "name": "yehuda",
                      "group": 0}}]},
      "owner": { "id": "yehsad",
          "display_name": "yehuda"}},
  "etag": "0b224491a3c207b05a0296cb29dcbbbb-17",
  "tag": "swab-1.4326.42",
  "manifest": { "objs": [],
      "obj_size": 104857600,
      "explicit_objs": "false",
      "head_obj": { "bucket": { "name": "buck3",
              "pool": ".rgw.buckets",
              "index_pool": ".rgw.buckets",
              "marker": "swab-1.4326.2",
              "bucket_id": "swab-1.4326.2"},
          "key": "f4",
          "ns": "",
          "object": "f4"},
      "head_size": 0,
      "max_head_size": 0,
      "prefix": "f4.2\/5uI2Tf5UalEXgbB150JS_YUD-BB4q_v",
      "rules": [
            { "key": 0,
              "val": { "start_part_num": 1,
                  "start_ofs": 0,
                  "part_size": 6291456,
                  "stripe_max_size": 4194304}},
            { "key": 100663296,
              "val": { "start_part_num": 17,
                  "start_ofs": 100663296,
                  "part_size": 4194304,
                  "stripe_max_size": 4194304}}]},
  "attrs": {}}

 The head size for it is 0, so all its data is contained in the tail.
It defines two rules for the different parts, the first one starts at
offest 0 (which is part 1), and the second one starts at offset
100663296 (at part 17). As you can see, the stripe size for both rules
is 4M. The first 16 parts are 6M, which means that each will consist
two rados objects, one will hold 4M and the second one will hold 2M.
The last part holds only 4M. There is a deterministic way to name the
tail's rados objects, using the bucket id, the object name, the
prefix, the part number, and the stripe number within that part.


 - what rados features are used

This is a very general question and it is hard to answer. Can you be
more specific?



Yehuda

On Thu, Aug 7, 2014 at 2:11 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
> Is there a document somewhere describing the mapping from S3 to RADOS
> ? (things like how files are cut, what manifest are, what rados
> features are used ....)
>
> Reading the source code, it is not always obvious how things are
> organized internally and you're never sure if you're understanding is
> correct or not (which can be dangerous when you try to build stuff
> based on that).
>
>
> Cheers,
>
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
