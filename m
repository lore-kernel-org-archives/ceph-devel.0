From: Wido den Hollander <wido@42on.com>
Subject: Safe maximum number of RADOS namespaces
Date: Fri, 6 Jan 2017 14:44:03 +0100 (CET)
Message-ID: <592054113.6138.1483710244101@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:55422 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdAFNpS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 08:45:18 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 730B83FC8D
        for <ceph-devel@vger.kernel.org>; Fri,  6 Jan 2017 14:44:04 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Together with a customer we are looking in to writing a application which will store a few PB of data using raw RADOS (librados C) and we are looking into using the RADOS namespaces to separate data.

For each 'section' we want to use a namespace in RADOS, but that would mean we would start off with 30M namespaces and this number might grow to 50M within a few years.

Is the a limitation for RADOS/FileStore/BlueStore for the amount of namespaces it can handle? (In a single pool?)

I want to test this, but writing a minimal of 30M objects takes a bit of time, so I figured I'd ask first.

Wido
