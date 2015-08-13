From: Pete Zaitcev <zaitcev@redhat.com>
Subject: RGWUserInfo encode/decode
Date: Thu, 13 Aug 2015 12:50:16 -0600
Message-ID: <20150813125016.5276db24@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbbHMSuS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Aug 2015 14:50:18 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 88FBC91DB7
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2015 18:50:18 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, zaitcev@redhat.com

Hi,

I stumpbled upon a code like this in src/rgw/rgw_common.h:

struct RGWUserInfo {
  map<string, RGWAccessKey> swift_keys;  // not one swift_key, a whole map
  void decode(bufferlist::iterator& bl) {
    string swift_key;
    if (struct_v >= 4) ::decode(swift_key, bl);
    // that's all, folks
  }
}

Looks like swift_key is never set when RGWUserInfo is deserialized.
It looks like a bug on the surface, but nobody cared thus far, so maybe
it's not actually a problem.

Do you happen to recall where this is used... Does radosgw-admin send
a whole RGWUserInfo to RADOS, ever? It appears to go the other way, in
show_user_info(), but strangely enough the tool shows Swift keys just fine.

-- Pete
