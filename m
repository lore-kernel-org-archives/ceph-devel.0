From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: libuuid vs boost uuid
Date: Tue, 26 Nov 2013 05:52:56 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66608B32@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net>
 <B4DA9072-EED6-48EE-94FE-4F24CCDFA1F8@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B665EA2F6@BITCOM1.int.sbss.com.au>
 <3C1A0909-F08C-44EE-AF1A-61E91460C764@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B665EA52D@BITCOM1.int.sbss.com.au>
 <8A6E449F-E249-4655-B198-53ABA06BF1E4@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:38513 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab3KZFxB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 00:53:01 -0500
In-Reply-To: <8A6E449F-E249-4655-B198-53ABA06BF1E4@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> James,
> 
> I'm using uuid.begin()/end() to grab the 16-byte representation of the UUID.
> Did you figure out how to populate a boost::uuid_t from the bytes? In
> particular, I'm referring to FileJournal::decode.
> 
> Actually, I suppose that any Ceph usage of the 16-byte representation should
> be replaced using the Boost serialization of uuid_t?
> 

As I said I haven't actually tested it, apart from that I have librbd working under Windows now ("rbd ls" and "rbd export" both work but I don't know if they actually do anything with uuid's...)

My patch to MStatfsReply.h to make it compile is:

diff --git a/src/messages/MStatfsReply.h b/src/messages/MStatfsReply.h
index 8ceec9c..40a5bdd 100644
--- a/src/messages/MStatfsReply.h
+++ b/src/messages/MStatfsReply.h
@@ -22,7 +22,7 @@ public:

   MStatfsReply() : Message(CEPH_MSG_STATFS_REPLY) {}
   MStatfsReply(uuid_d &f, tid_t t, epoch_t epoch) : Message(CEPH_MSG_STATFS_REPLY) {
-    memcpy(&h.fsid, f.uuid, sizeof(h.fsid));
+    memcpy(&h.fsid, &f.uuid, sizeof(h.fsid));
     header.tid = t;
     h.version = epoch;
   }

So assuming this actually works, the uuid bytes are accessible as per the above.

James

