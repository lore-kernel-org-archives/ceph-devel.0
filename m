Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201DC4332F
	for <ceph-devel@archiver.kernel.org>; Wed, 16 Nov 2022 06:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiKPGRE (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiKPGRD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2022 01:17:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E8E5;
        Tue, 15 Nov 2022 22:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WQ9NDGExlwYH/VGraV3DQPxJ/q
        eFBssFXtgWJYmRHSnr8FNQbFneSg5GI/cZwvSsk+pprX9retA+zkZWir5027kCy3rHI/0EgntBx4g
        P3W13OPQSMGZeOWCuIwh2xPFF8vrXMycRU0jBfVOykARS3QNNaNqUQInLT4c7KHho9dgTg2tio3wt
        OZtd9hy7Lu+OcPlZAAUtctYH3xPfV+YYabQTyOPeCl6V8GYXrMhuu6xNqYrE6LAtzBMl7HKybm8Y4
        8CKLHKvfQL1mQHcSCl50NSSUj8kCe4yFKf3CAhVXoRdJwT5p8j1NigU6Q52jv5H0EtOUcudDHJG7y
        HwKuvJ5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovBjE-000DkD-NM; Wed, 16 Nov 2022 06:16:56 +0000
Date:   Tue, 15 Nov 2022 22:16:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, chuck.lever@oracle.com,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
Message-ID: <Y3SAWD7caQ5txVmX@infradead.org>
References: <20221114140747.134928-1-jlayton@kernel.org>
 <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
 <54b90281-c575-5aee-e886-e4d7b50236f0@redhat.com>
 <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
