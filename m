From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-dencoder decode PGMap failed
Date: Tue, 5 Dec 2017 03:02:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712050300410.22619@piezo.novalocal>
References: <20171205024825.98DD081000ED@webmail.sinamail.sina.com.cn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-561972034-1512442950=:22619"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:48656 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdLEDCb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Dec 2017 22:02:31 -0500
In-Reply-To: <20171205024825.98DD081000ED@webmail.sinamail.sina.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: simplemaomao@sina.cn
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-561972034-1512442950=:22619
Content-Type: TEXT/PLAIN; charset=GBK
Content-Transfer-Encoding: 8BIT

On Tue, 5 Dec 2017, simplemaomao@sina.cn wrote:
> Hi cephers
> I want to decode pgmap from leveldb£¬follow the steps below
> 1.stop monitor
> 2.ceph-kvstore-tool leveldb /var/lib/ceph/mon/ceph-lab1/store.db get pgmap first_committed out /tmp/pgmap_first_committed
> 3.ceph-dencoder import /tmp/pgmap_first_committed type PGMap decode dump_json
> the last step return error "error: buffer::malformed_input: void PGMap::decode(ceph::buffer::list::iterator&) unknown encoding version > 6"
> ceph version 10.2.10 (5dc1e4c05cb68dbf62ae6fce3f0700e4654fdbbe)

The old PGMap structure is never actually encoded and stored in its 
entirety any more (since, I think, dumpling or emperor?).  The 
first_committed value is probably just 8 bytes with the version number.

In Jewel, the contents are spread over a zillion keys, one for each PG, in 
their own format.

Starting in Luminous, we encode only a PGMapDigest object, which has only 
the summary information.

sage
--8323329-561972034-1512442950=:22619--
