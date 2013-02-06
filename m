From: Yehuda Sadeh <yehuda@inktank.com>
Subject: json parsing/decoding
Date: Wed, 6 Feb 2013 14:19:04 -0800
Message-ID: <CAC-hyiG=Ar3nuEcCttG_7YMSu3aeo6KpyQ9nHi6-bYBTK3tmaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45496 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab3BFWTF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 17:19:05 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so2656055ieb.34
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 14:19:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The matter of json decoding was brought up as part of the discussion
of the ceph management api. I recently had to deal with it with the
rados gateway, as I wasn't too happy was the current mechanisms that
were used for this purpose. So I introduced a new decode_json()
functionality (now in common/ceph_json.* at the wip-json-decode
branch). It's very similar to the regular encode/decode stuff that we
use to encode/decode structures. Encoding is being done using the
already existing dump() method, and decoding will be done through the
new decode_json() method.

As an example we'll define a new UserInfo structure:

struct UserInfo {
  string uid;
  string display_name;
  int max_buckets;
  list<Key> keys;

  void dump(Formatter *f) const;
  void decode_json(JSONObj *obj);
};

The dump() method will look like this:

void UserInfo::dump(Formatter *f) const
{
  f->open_object_section("user_info");
  f->dump_string("user_id", uid);
  f->dump_string("display_name", display_name);
  f->dump_int("max_buckets", (int)max_buckets);

  f->open_array_section("keys");
  for (list<Key>::iterator iter = keys.begin(); siter != keys.end(); ++iter) {
    iter->dump(f);
  }
  f->close_section();

  f->close_section();
}

It is recommended that every dump() method opens an object section and
puts everything within, so that every object could be easily embedded
within other objects. We can also probably create some template that
will remove the need of doing that inner loop, e.g.:
  ...
  f->dump_array("keys", keys);
  ...

In any case, the corresponding json decoding function looks like this:

void UserInfo::decode_json(JSONObj *obj) {
  JSONDecoder::decode_json("user_id", uid, obj);
  JSONDecoder::decode_json("display_name", display_name, obj);
  JSONDecoder::decode_json("max_buckets", max_buckets, obj);
  JSONDecoder::decode_json("keys", keys, obj);
}


and we'll decode the structure like this:

...

UserInfo user_info;

JSONParser parser;

if (!parser.parse(buf, len))
  return -EINVAL;
...
try {
  user_info.decode(&parser);
} catch (JSONDecoder::err& e) {
...
}


The default behavior is that every field is optional, so that it just
ignores fields that are not found in the json structure. If a field is
set to be mandatory (by extra param to the decode_json()), then an
exception will be thrown. Note that all fields should be initialized
to the default value before decoding as passed json might not contain
any relevant field.


Yehuda
