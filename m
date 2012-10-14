From: Chris Dunlop <chris@onthe.net.au>
Subject: libceph: error -2 building auth method x request
Date: Mon, 15 Oct 2012 09:57:35 +1100
Message-ID: <20121014225735.GA9509@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:35140 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2JNXHs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Oct 2012 19:07:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 09537612DE
	for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 09:57:37 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKUxbvrCjjuY for <ceph-devel@vger.kernel.org>;
	Mon, 15 Oct 2012 09:57:36 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 355BD60EC1
	for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 09:57:36 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 5D22E2AB2BC
	for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 09:58:03 +1100 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

In case anyone else might be getting the $subject error, and to
make the issue visible to a google search...

When trying to map an rdb block device whilst using cephx
authentication, if you get kernel messages like:

[79683.055935] libceph: client0 fsid c6618970-0ce0-4cb2-bc9a-dd5f29b62e24
[79683.059286] libceph: error -2 building auth method x request

...ensure you have the appropriate encryption available in the
kernel (built in or modules). I'm a bit unclear as to precisely
what is required, but Josh Durgin's comment was:

  The only path I'm seeing that could lead to that error is if
  the kernel wasn't compiled with support for "cbc(aes)" with
  the CRYPTO_ALG_ASYNC flag. I'd guess any of the CRYTPO_AES*
  build options (with CRYPTO_BLKCIPHER2?) would be sufficient.

These modules were required to get my mapping working whilst
using cephx:

  aes_x86_64
  aes_generic
  cbc

See also: http://tracker.newdream.net/issues/3285

Cheers,

Chris.
