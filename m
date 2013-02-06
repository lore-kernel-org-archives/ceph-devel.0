From: Sage Weil <sage@inktank.com>
Subject: Re: json parsing/decoding
Date: Wed, 6 Feb 2013 14:23:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302061420570.13326@cobra.newdream.net>
References: <CAC-hyiG=Ar3nuEcCttG_7YMSu3aeo6KpyQ9nHi6-bYBTK3tmaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758357Ab3BFWX1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 17:23:27 -0500
In-Reply-To: <CAC-hyiG=Ar3nuEcCttG_7YMSu3aeo6KpyQ9nHi6-bYBTK3tmaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 6 Feb 2013, Yehuda Sadeh wrote:
> The matter of json decoding was brought up as part of the discussion
> of the ceph management api. I recently had to deal with it with the
> rados gateway, as I wasn't too happy was the current mechanisms that
> were used for this purpose. So I introduced a new decode_json()
> functionality (now in common/ceph_json.* at the wip-json-decode
> branch). It's very similar to the regular encode/decode stuff that we
> use to encode/decode structures. Encoding is being done using the
> already existing dump() method, and decoding will be done through the
> new decode_json() method.
> 
> As an example we'll define a new UserInfo structure:
> 
> struct UserInfo {
>   string uid;
>   string display_name;
>   int max_buckets;
>   list<Key> keys;
> 
>   void dump(Formatter *f) const;
>   void decode_json(JSONObj *obj);
> };
> 
> The dump() method will look like this:
> 
> void UserInfo::dump(Formatter *f) const
> {
>   f->open_object_section("user_info");
>   f->dump_string("user_id", uid);
>   f->dump_string("display_name", display_name);
>   f->dump_int("max_buckets", (int)max_buckets);
> 
>   f->open_array_section("keys");
>   for (list<Key>::iterator iter = keys.begin(); siter != keys.end(); ++iter) {
>     iter->dump(f);
>   }
>   f->close_section();
> 
>   f->close_section();
> }
> 
> It is recommended that every dump() method opens an object section and
> puts everything within, so that every object could be easily embedded
> within other objects. We can also probably create some template that

The current loose convention is that the dump objects do not define the 
container they dump into.  It's a bit weird, but it lets you do things 
like:

map<Key, Value> foo;

   f->open_array_section("keys");
   for (map<Key,Value>::iterator iter = keys.begin(); siter != keys.end(); ++iter) {
     f->open_object_section("thing");
     f->dump_string("key", iter->first);
     iter->second.dump(f);
     f->close_section();
   }
   f->close_section();

Admittedly that doesn't come up *that* often, but it happened enough when 
we first started doing the dump stuff that all/most of the dumpers work 
that way.

How should we deal with that?

sage


> will remove the need of doing that inner loop, e.g.:
>   ...
>   f->dump_array("keys", keys);
>   ...
> 
> In any case, the corresponding json decoding function looks like this:
> 
> void UserInfo::decode_json(JSONObj *obj) {
>   JSONDecoder::decode_json("user_id", uid, obj);
>   JSONDecoder::decode_json("display_name", display_name, obj);
>   JSONDecoder::decode_json("max_buckets", max_buckets, obj);
>   JSONDecoder::decode_json("keys", keys, obj);
> }
> 
> 
> and we'll decode the structure like this:
> 
> ...
> 
> UserInfo user_info;
> 
> JSONParser parser;
> 
> if (!parser.parse(buf, len))
>   return -EINVAL;
> ...
> try {
>   user_info.decode(&parser);
> } catch (JSONDecoder::err& e) {
> ...
> }
> 
> 
> The default behavior is that every field is optional, so that it just
> ignores fields that are not found in the json structure. If a field is
> set to be mandatory (by extra param to the decode_json()), then an
> exception will be thrown. Note that all fields should be initialized
> to the default value before decoding as passed json might not contain
> any relevant field.
> 
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
