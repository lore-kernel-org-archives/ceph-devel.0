From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RadosGW crashing on copy for one specific object
Date: Wed, 20 Aug 2014 10:44:08 -0700
Message-ID: <CABBk=J8B-Ph_Ju7uHOuXydXdSXw1tL4v1dvPvy7P=A19XtTTTQ@mail.gmail.com>
References: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
	<CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
	<CAF6-1L6GWKmncQXA_e4NzaFzLqefzQ4O1qikW0zG6k7BrrMvHg@mail.gmail.com>
	<CABBk=J8G=fWC5_m0qxAaYAH0UioYA++87S84J9+23B2BxNs39g@mail.gmail.com>
	<CABBk=J851yHsd05Lk7JzBk0jDFAM8HRKC0Yz7XmntrpFkCZh=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:53586 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbaHTRoK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 13:44:10 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so11606199igc.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Aug 2014 10:44:09 -0700 (PDT)
In-Reply-To: <CABBk=J851yHsd05Lk7JzBk0jDFAM8HRKC0Yz7XmntrpFkCZh=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If by any chance you applied the previous patch, revert it, as it's
wrong. This might fix the issue:

diff --git a/src/rgw/rgw_rados.h b/src/rgw/rgw_rados.h
index d50fb59..0f13590 100644
--- a/src/rgw/rgw_rados.h
+++ b/src/rgw/rgw_rados.h
@@ -298,6 +298,9 @@ public:

   bool has_tail() {
     if (explicit_objs) {
+      if (objs.size() == 1) {
+        return head_obj != objs[0];
+      }
       return (objs.size() >= 2);
     }
     return (obj_size > head_size);

Let me know if it works for you.

Thanks,
Yehuda

On Wed, Aug 20, 2014 at 10:33 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> Looking at the code some more, that change isn't going to fix it for
> you. I'll send an updated fix soon.
>
> Yehuda
>
> On Wed, Aug 20, 2014 at 10:25 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> On Wed, Aug 20, 2014 at 6:47 AM, Sylvain Munaut
>> <s.munaut@whatever-company.com> wrote:
>>> Hi,
>>>
>>>
>>>> What does 'radosgw-admin object stat --bucket=<bucket> --object=<object>' show?
>>>
>>> { "name": "5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b\/render-image",
>>>   "size": 239879,
>>>   "policy": { "acl": { "acl_user_map": [
>>>                 { "user": "kp",
>>>                   "acl": 15}],
>>>           "acl_group_map": [],
>>>           "grant_map": [
>>>                 { "id": "kp",
>>>                   "grant": { "type": { "type": 0},
>>>                       "id": "kp",
>>>                       "email": "",
>>>                       "permission": { "flags": 15},
>>>                       "name": "KP S3 User",
>>>                       "group": 0}}]},
>>>       "owner": { "id": "kp",
>>>           "display_name": "KP S3 User"}},
>>>   "etag": "bfe2df862d92f70cecbedbab324e3f78-1",
>>>   "tag": "default.440489.1590546",
>>>   "manifest": { "objs": [
>>>             0,
>>>             { "loc": { "bucket": { "name": "kp-render-image.bouygues",
>>>                       "pool": ".rgw.kp-render-image",
>>>                       "data_extra_pool": "",
>>>                       "index_pool": ".rgw.kp-render-image",
>>>                       "marker": "default.440489.58258",
>>>                       "bucket_id": "default.440489.58258"},
>>>                   "key": "",
>>>                   "ns": "multipart",
>>>                   "object":
>>> "_multipart_5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b\/render-image.8rSDD8MVD1KIXDTQDsf3g6b71dqADP_.1"},
>>>               "loc_ofs": 0,
>>>               "size": 239879}],
>>>       "obj_size": 239879,
>>>       "explicit_objs": "true",
>>>       "head_obj": { "bucket": { "name": "",
>>>               "pool": "",
>>>               "data_extra_pool": "",
>>>               "index_pool": "",
>>>               "marker": "",
>>>               "bucket_id": ""},
>>>           "key": "",
>>>           "ns": "",
>>>           "object": ""},
>>>       "head_size": 0,
>>>       "max_head_size": 0,
>>>       "prefix": "",
>>>       "tail_bucket": { "name": "",
>>>           "pool": "",
>>>           "data_extra_pool": "",
>>>           "index_pool": "",
>>>           "marker": "",
>>>           "bucket_id": ""},
>>>       "rules": []},
>>>   "attrs": { "user.rgw.content_type": "image\/png"}}
>>>
>>>
>>>> Also, can you bump logging up? debug rgw = 20, debug ms = 1
>>>
>>> I'll try, but being on the production cluster, it's constantly
>>> hammered with requests :p
>>>
>>>
>>
>> The object has a zero sized head, which is ok, but I think it triggers
>> an issue. Can you try this:
>>
>> diff --git a/src/rgw/rgw_dencoder.cc b/src/rgw/rgw_dencoder.cc
>> index e6dc2ba..fd12c4f 100644
>> --- a/src/rgw/rgw_dencoder.cc
>> +++ b/src/rgw/rgw_dencoder.cc
>> @@ -104,7 +104,7 @@ void RGWObjManifest::obj_iterator::update_location()
>>
>>    const rgw_obj& head = manifest->get_head();
>>
>> -  if (ofs < manifest->get_head_size()) {
>> +  if (ofs <= manifest->get_head_size()) {
>>      location = head;
>>      return;
>>    }
>> diff --git a/src/rgw/rgw_rados.cc b/src/rgw/rgw_rados.cc
>> index 7ca4a9d..877c130 100644
>> --- a/src/rgw/rgw_rados.cc
>> +++ b/src/rgw/rgw_rados.cc
>> @@ -558,7 +558,7 @@ void RGWObjManifest::obj_iterator::operator++()
>>    }
>>
>>    /* are we still pointing at the head? */
>> -  if (ofs < head_size) {
>> +  if (ofs <= head_size) {
>>      rule_iter = manifest->rules.begin();
>>      RGWObjManifestRule *rule = &rule_iter->second;
>>      ofs = MIN(head_size, obj_size);
>>
>>
>> Thanks,
>> Yehuda
