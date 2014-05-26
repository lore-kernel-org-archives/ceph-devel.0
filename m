From: Guang Yang <yguang11@outlook.com>
Subject: Questions of KeyValueStore (leveldb) backend
Date: Mon, 26 May 2014 09:46:13 +0800
Message-ID: <BLU436-SMTP4071B1A51539EAA2F9D7ECDF3B0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s12.hotmail.com ([65.55.111.151]:54318 "EHLO
	BLU004-OMC4S12.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbaEZBqU convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 25 May 2014 21:46:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hello Haomai,
We are evaluating the key-value store backend which comes along with Fi=
refly release (thanks for implementing it in Ceph), it is very promisin=
g for a couple of our use cases, after going through the related code c=
hange, I have a couple of questions which needs your help:
  1. One observation is that, for object larger than 1KB, it will be st=
riped to multiple chunks (k-v in the leveldb table), with one strip as =
1KB size. Is there any particular reason we choose 1KB as the strip siz=
e (and I didn=92t find a configuration to tune this value)?

  2. This is properly a leveldb question, do we expect performance degr=
adation as the leveldb instance keeps increasing (e.g. several TB)?

Thanks,
Guang--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
