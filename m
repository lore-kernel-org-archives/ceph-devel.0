From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: what could go wrong with two clusters on the same network?
Date: Mon, 31 Dec 2012 18:17:17 +0800
Message-ID: <50E1662D.6000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35384 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab2LaKRO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 05:17:14 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so7042193pad.13
        for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 02:17:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

If I run two clusters on the same network, each with its own set of
monitors and config files (assuming that we didn't make any error
in the config files), would there be anything wrong with that?

Ceph seems to be quite chatty, so would they mess up their
messages?

Just want to make sure, and just want to know if anyone is
doing that.

Thanks

Xiaopong
