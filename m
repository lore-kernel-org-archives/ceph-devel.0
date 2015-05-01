From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: K/V store optimization
Date: Fri, 1 May 2015 04:55:05 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD84052@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0083.outbound.protection.outlook.com ([65.55.169.83]:15127
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750838AbbEAEzW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 May 2015 00:55:22 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Haomai,
I was doing some investigation with K/V store and IMO we can do the following optimization on that.

1. On every write KeyValueStore is writing one extra small attribute with prefix _GHOBJTOSEQ* which is storing the header information. This extra write will hurt us badly in case flash WA. I was thinking if we can get rid of this in the following way.

      Seems like persisting headers during creation time should be sufficient. The reason is the following..
       a. The header->seq for generating prefix will be written only when header is generated. So, if we want to use the _SEQ * as prefix, we can read the header and use it during write.
       b. I think we don't need the stripe bitmap/header->max_len/stripe_size as well. The bitmap is required to determine the already written extents for a write. Now, any K/V db supporting range queries (any popular db does), we can always send down
           range query with prefix say _SEQ_0000000000039468_STRIP_ and it should return the valid extents. No extra reads here since anyway we need to read those extents in read/write path.


2. I was thinking not to read this GHobject at all during read/write path. For that, we need to get rid of the SEQ stuff and calculate the object keys on the fly. We can uniquely form the GHObject keys and add that as prefix to attributes like this.

                _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head     -----> for header (will be created one time)
                _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head __OBJOMAP * -> for all omap attributes

        _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head__OBJATTR__*  -> for all attrs
        _GHOBJTOSEQ_1%e59_head!9DD29B68!!1!!rbd_data%e100574b0dc51%e000000000000c18a!head__STRIP_<stripe-no> -> for all strips.

 Also, keeping the similar prefix to all the keys for an object will be helping k/v dbs in general as lot of dbs do optimization based on similar key prefix.

3. We can aggregate the small writes in the buffer transaction and issue one single key/value write to the dbs. If dbs are already doing small write aggregation , this won't help much though.

Please share your thought around this.

Thanks & Regards
Somnath




________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

