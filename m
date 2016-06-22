From: Michael Wyraz <michael@wyraz.de>
Subject: Status of cephfs / multiple mds
Date: Wed, 22 Jun 2016 07:00:33 +0200
Message-ID: <576A1B71.6030300@wyraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vpsprod2.wyraz.de ([188.68.49.93]:51833 "EHLO mail.wyraz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcFVFBZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 01:01:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.wyraz.de (Postfix) with ESMTP id 8AC998EDE3
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 07:00:54 +0200 (CEST)
Received: from mail.wyraz.de ([127.0.0.1])
	by localhost (mail.wyraz.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id chZWS70nuQeI for <ceph-devel@vger.kernel.org>;
	Wed, 22 Jun 2016 07:00:34 +0200 (CEST)
Received: from [192.168.10.10] (p50992bfa.dip0.t-ipconnect.de [80.153.43.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.wyraz.de (Postfix) with ESMTPSA
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 07:00:34 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I'm curious what is the current state of the stability of cephfs when
using multiple mds and/or snapshots. It seems that the "Early Adaptors"
documentation has not changed since hammer, about 1 year ago. We have 2
major releases and many releases meanwhile. SO probably things have
changed and there is more experience. Is it save now to run cephfs with
more than 1 active mds?

Kind regards,
Michael.


