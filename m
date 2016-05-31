From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Sizes of attributes and attributenames....
Date: Tue, 31 May 2016 10:06:05 +0200
Message-ID: <eeeec6f0-3aff-e1e1-8e85-5e7922fa2e15@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:20158 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756342AbcEaIG3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 04:06:29 -0400
Received: from [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2] (unknown [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 3016A1534C7
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 10:06:16 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi,

I'm getting bitten in tests/ceph-disk.sh by.

 2 osd.0 0 boot
-1 osd.0 0 backend (filestore) is unable to support max object
name[space] len
-1 osd.0 0    osd max object name len = 2048
-1 osd.0 0    osd max object namespace len = 256
-1 osd.0 0 (63) File name too long
 1 journal close test-ceph-disk/dir/journal
-1  ** ERROR: osd init failed: (63) File name too long	

And it seems that I did have this fixed in one run or another, but now
it raises it scary head again.
Now I think it is posible to fix this by starting vstart -short, but
that does not cut it with other tests, so it seems.

Now the actual test is:

int FileStore::validate_hobject_key(const hobject_t &obj) const
{
  unsigned len = LFNIndex::get_max_escaped_name_len(obj);
  return len > m_filestore_max_xattr_value_size ? -ENAMETOOLONG : 0;
}

So the actual question is:
It is not about file size, but the maximum length for an attribute NAME
to be stored with a file?

--WjW
