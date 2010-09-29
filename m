From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Several patches for CEPH
Date: Wed, 29 Sep 2010 11:33:49 -0700
Message-ID: <AANLkTiko9p7dBEtNNUFXUTgoWUROxD=d4sk58vpP2SQ1@mail.gmail.com>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
	<AANLkTimSQKsa60B1i1FyxDQDu91SKCPLF9yAEARY3nks@mail.gmail.com>
	<AANLkTikbbO48kojFbV3jQ8L2A77mr5rRGd_=fKE+XB3W@mail.gmail.com>
	<AANLkTikFQZtvzhR3wcChXV0j1ZjyTU7VFU2b24Q+pVME@mail.gmail.com>
	<Pine.LNX.4.64.1009291113130.4494@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50940 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab0I2Sdv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Sep 2010 14:33:51 -0400
Received: by qyk36 with SMTP id 36so1377750qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 11:33:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009291113130.4494@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, ceph-devel@vger.kernel.org

On Wed, Sep 29, 2010 at 11:15 AM, Sage Weil <sage@newdream.net> wrote:
> I think the order in the if () should be reversed... it's not legal to
> dereference the iterator if it's == end().
Good catch -- switched in the if and the while loop condition checks.
