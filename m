Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD0EB64D7
	for <ceph-devel@archiver.kernel.org>; Mon, 26 Jun 2023 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFZVP4 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 26 Jun 2023 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZVPz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2023 17:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D3E71
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jun 2023 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687814112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=phZhUFy820bdckUny8npt4P9PZBQ+KMukLBIP/xsC+s=;
        b=QEqG6bDen0A/m2J9WLin23Fklbqwf+lOyVBs0DrjjE5FD+1nuWM56lvBGl4iu9k+DmUNfR
        zO4UZ0if+zGej6DNmdkp/nNi1Ar4KEgukoy9rf+PnThjVS9516MiAo40qi8J8ZFGL3iaSP
        FkLaqVEKHJpQ7WF0mwCt7vOVSbupeL4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-cIdWQumrOyiAgAevxvWBiA-1; Mon, 26 Jun 2023 17:15:07 -0400
X-MC-Unique: cIdWQumrOyiAgAevxvWBiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D97EF104458B;
        Mon, 26 Jun 2023 21:14:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E402F492B01;
        Mon, 26 Jun 2023 21:14:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
cc:     dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Is ->sendmsg() allowed to change the msghdr struct it is given?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3112096.1687814081.1@warthog.procyon.org.uk>
Date:   Mon, 26 Jun 2023 22:14:41 +0100
Message-ID: <3112097.1687814081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Hi Jakub,

Do you know if ->sendmsg() might alter the msghdr struct it is passed as an
argument?  Certainly it can alter msg_iter, but can it also modify, say,
msg_flags?

Thanks,
David

