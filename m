Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FCECCA47C
	for <ceph-devel@archiver.kernel.org>; Mon, 13 Jun 2022 13:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378307AbiFMNlC (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 13 Jun 2022 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379260AbiFMNkJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2022 09:40:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB10DF44;
        Mon, 13 Jun 2022 04:31:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26BDD1F993;
        Mon, 13 Jun 2022 11:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655119860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IDa1kJucFyYiUdEScqt2Srl5YeKpuJ8KbKlZ0o8dwfE=;
        b=Zu8uZbbbsGsEJ1bLqluUisrx/fJdpcsQrXPi+RAtyU7FrDtfhX3cuAt2LtSPTHkpHi/oLs
        ewW7zkLEvmxZm6EyrINMwsOnh+fvAbuqQj4A8GxlQyoo51Nvi6DgW6I5TwMCVavXtq+77z
        yq9VUs4NNui9dLI9S//sQ7Ki753urn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655119860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IDa1kJucFyYiUdEScqt2Srl5YeKpuJ8KbKlZ0o8dwfE=;
        b=Woua8HQWHIhZXLHL1QNz9qJObZW8ahRU4XCPS6ek+y59mE1rmRaXfLcK1xheLpwWpPV76n
        YICCFboztPJYGOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A341134CF;
        Mon, 13 Jun 2022 11:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2T7LIvMfp2ICeQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 13 Jun 2022 11:30:59 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8e2ad942;
        Mon, 13 Jun 2022 11:31:43 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        ceph-devel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v3 0/2] Two xattrs-related fixes for ceph
Date:   Mon, 13 Jun 2022 12:31:40 +0100
Message-Id: <20220613113142.4338-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Hi!

A bug fix in ceph has made some changes in the way xattr limits are
enforced on the client side.  This requires some fixes on tests
generic/020 and generic/486.

* Changes since v2:

  - patch 0001:
    Add logic to compute the *real* maximum.  Kudos to David Disseldorp
    for providing the right incantation to do the maths.  Also split
    _attr_get_max() in two, so that they can be invoked from different
    places in the test script.

  - patch 002:
    attr_replace_test now has an extra param as suggested by Dave Chinner,
    and added fs-specific logic to the script.  No need to have an exact
    maximum in this test, a big-enough value suffices.

* Changes since v1:

  - patch 0001:
    Set the max size for xattrs values to a 65000, so that it is close to
    the maximum, but still able to accommodate any pre-existing xattr

  - patch 0002:
    Same thing as patch 0001, but in a more precise way: actually take
    into account the exact sizes for name+value of a pre-existing xattr.

Luís Henriques (2):
  generic/020: adjust max_attrval_size for ceph
  generic/486: adjust the max xattr size

 src/attr_replace_test.c | 30 ++++++++++++++++++++++++++----
 tests/generic/020       | 33 +++++++++++++++++++++++++--------
 tests/generic/486       | 11 ++++++++++-
 3 files changed, 61 insertions(+), 13 deletions(-)

