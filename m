From: Ning Yao <zay11022@gmail.com>
Subject: problem about pgmeta object?
Date: Wed, 18 Nov 2015 10:35:58 +0800
Message-ID: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36653 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbKRCgA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Nov 2015 21:36:00 -0500
Received: by wmww144 with SMTP id w144so179051067wmw.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2015 18:35:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage

pgmeta object is a meta-object (like __head_00000000__2) without
significant information. It is created when in PG::_init() when
handling pg_create and split_coll and always exits there during pg's
life cycle until pg is removed in RemoveWQ. The real content related
to pgmeta-data is stored in omap. we may just treat pgmeta-object as a
logical object and not present it physically so that we can avoid
recursive searching object path by if(hoid.pgmeta())?
such as:
int FileStore::_omap_setkeys(coll_t cid, const ghobject_t &hoid,
    const map<string, bufferlist> &aset,
    const SequencerPosition &spos) {
  dout(15) << __func__ << " " << cid << "/" << hoid << dendl;
  Index index;
  int r;
  if(hoid.pgmeta())
    goto out;
***
***
***
out:
  r = object_map->set_keys(hoid, aset, &spos);
  dout(20) << __func__ << " " << cid << "/" << hoid << " = " << r << dendl;
  return r;
}



Regards
Ning Yao
