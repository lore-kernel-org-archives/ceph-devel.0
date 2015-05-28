From: Andrew Bartlett <abartlet@catalyst.net.nz>
Subject: Interested in ceph OSD encryption and key management
Date: Thu, 28 May 2015 16:23:25 +1200
Message-ID: <1432787005.11787.33.camel@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49805 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbE1EbC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 00:31:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id E55A232C74
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 16:23:26 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5OJ4XtXS-mX for <ceph-devel@vger.kernel.org>;
	Thu, 28 May 2015 16:23:25 +1200 (NZST)
Received: from ruth (unknown [IPv6:2404:130:0:1000:7254:d2ff:feab:168d])
	(Authenticated sender: abartlet)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 5DD5432C17
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 16:23:25 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

David Disseldorp was good enough to point me at this proposal for ceph
OSD key management:
https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_simple_ceph-mon_dm-crypt_key_management

I'm really interested in improving ceph on-disk encryption, and am
really glad folks are taking this beyond the local key storage we have
managed so far. 

So I can be part of the discussion, how do I get a login to the wiki?  I
would like to indicate my interest there.

Regarding the proposal:

In the default mode suggested in the wiki, my primary concern is that
I'm told, in a number of deployments, the monitor node is the same
server that also holds the OSDs, so we don't gain anything for those
cases over the /etc storage.

In those cases, the hooks suggested in the wiki will be key, as will be
having those configurable in ceph.conf, so ceph-deploy can just pass it
down to all the nodes as they are built, just as the other dmcrypt
options are.  

I would like to see three things hookable:
 - the command to obtain the key (on stdout)
 - to encrypt the key (so we can additionally pass it
via gpg, a HSM or remote encrypt/decrypt service)
 - to decrypt the key


Thanks,

Andrew Bartlett


-- 
Andrew Bartlett
http://samba.org/~abartlet/
Authentication Developer, Samba Team  http://samba.org
Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba




