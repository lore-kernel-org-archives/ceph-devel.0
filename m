From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: json parsing/decoding
Date: Wed, 6 Feb 2013 14:36:02 -0800
Message-ID: <CAC-hyiH_EYk_urtbjQZ=GM+d0C75x_-g6Txf6dJTToWZ9g3SSg@mail.gmail.com>
References: <CAC-hyiG=Ar3nuEcCttG_7YMSu3aeo6KpyQ9nHi6-bYBTK3tmaw@mail.gmail.com>
	<alpine.DEB.2.00.1302061420570.13326@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51403 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab3BFWgD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 17:36:03 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so2229205iad.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 14:36:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302061420570.13326@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 6, 2013 at 2:23 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 6 Feb 2013, Yehuda Sadeh wrote:
>> The matter of json decoding was brought up as part of the discussion
>> of the ceph management api. I recently had to deal with it with the
>> rados gateway, as I wasn't too happy was the current mechanisms that
>> were used for this purpose. So I introduced a new decode_json()
>> functionality (now in common/ceph_json.* at the wip-json-decode
>> branch). It's very similar to the regular encode/decode stuff that we
>> use to encode/decode structures. Encoding is being done using the
>> already existing dump() method, and decoding will be done through the
>> new decode_json() method.
>>
>> As an example we'll define a new UserInfo structure:
>>
>> struct UserInfo {
>>   string uid;
>>   string display_name;
>>   int max_buckets;
>>   list<Key> keys;
>>
>>   void dump(Formatter *f) const;
>>   void decode_json(JSONObj *obj);
>> };
>>
>> The dump() method will look like this:
>>
>> void UserInfo::dump(Formatter *f) const
>> {
>>   f->open_object_section("user_info");
>>   f->dump_string("user_id", uid);
>>   f->dump_string("display_name", display_name);
>>   f->dump_int("max_buckets", (int)max_buckets);
>>
>>   f->open_array_section("keys");
>>   for (list<Key>::iterator iter = keys.begin(); siter != keys.end(); ++iter) {
>>     iter->dump(f);
>>   }
>>   f->close_section();
>>
>>   f->close_section();
>> }
>>
>> It is recommended that every dump() method opens an object section and
>> puts everything within, so that every object could be easily embedded
>> within other objects. We can also probably create some template that
>
> The current loose convention is that the dump objects do not define the
> container they dump into.  It's a bit weird, but it lets you do things
> like:
>
> map<Key, Value> foo;
>
>    f->open_array_section("keys");
>    for (map<Key,Value>::iterator iter = keys.begin(); siter != keys.end(); ++iter) {
>      f->open_object_section("thing");
>      f->dump_string("key", iter->first);
>      iter->second.dump(f);
>      f->close_section();
>    }
>    f->close_section();
>
> Admittedly that doesn't come up *that* often, but it happened enough when
> we first started doing the dump stuff that all/most of the dumpers work
> that way.
>
> How should we deal with that?
>

Modify the dumpers to not work this way? It's a matter of conventions,
not set in stone. If we keep this form then we'd need to create
decoders for these records:

struct KeyRecord {
  Key k;
  Value v;

  void decode_json(JSONObj *obj) {
    JSONDecoder::decode_json("key", key, obj);
    v.decode_json(obj);
  }
};

This will work, assuming Value doesn't have any field indexed by "key".

Yehuda
