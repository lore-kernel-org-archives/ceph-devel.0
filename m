From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGWUserInfo encode/decode
Date: Thu, 13 Aug 2015 12:01:51 -0700
Message-ID: <CADRKj5Set_ZjV1zo4nZzPfyZAT66AUsQxnjweFPBdNN5db4oWg@mail.gmail.com>
References: <20150813125016.5276db24@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33114 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbbHMTBw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Aug 2015 15:01:52 -0400
Received: by obbhe7 with SMTP id he7so44452589obb.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2015 12:01:51 -0700 (PDT)
In-Reply-To: <20150813125016.5276db24@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 13, 2015 at 11:50 AM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> Hi,
>
> I stumpbled upon a code like this in src/rgw/rgw_common.h:
>
> struct RGWUserInfo {
>   map<string, RGWAccessKey> swift_keys;  // not one swift_key, a whole map
>   void decode(bufferlist::iterator& bl) {
>     string swift_key;
>     if (struct_v >= 4) ::decode(swift_key, bl);
>     // that's all, folks
>   }
> }
>
> Looks like swift_key is never set when RGWUserInfo is deserialized.
> It looks like a bug on the surface, but nobody cared thus far, so maybe
> it's not actually a problem.

It's a backward compatibility issue, we used to keep a single key as a
string, later changed it into a map (decoded later). What I'd expect
to see here is populating the map with the string we read here (if not
empty), however, I'm pretty sure no one will hit this issue as it'd
require a *real* old structure (circa 2009) that no one would have.
>
> Do you happen to recall where this is used... Does radosgw-admin send
> a whole RGWUserInfo to RADOS, ever? It appears to go the other way, in
> show_user_info(), but strangely enough the tool shows Swift keys just fine.
>

Whenever we read user's info (e.g., when authenticating user) this is
getting decoded.

Yehuda
