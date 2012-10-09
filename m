From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Client Location
Date: Tue, 09 Oct 2012 09:43:28 -0700
Message-ID: <50745430.6090607@inktank.com>
References: <1467968321.440.1349788446710.JavaMail.root@corellia.pncl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65133 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2JIQnf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 12:43:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5390822pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 09:43:35 -0700 (PDT)
In-Reply-To: <1467968321.440.1349788446710.JavaMail.root@corellia.pncl.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Horner <james.horner@precedent.co.uk>
Cc: ceph-devel@vger.kernel.org

I'm not a real engineer, so please forgive me if I misunderstand,
but can't you create a separate rule for each data center (choosing
first a local copy, and then remote copies), which should ensure
that the primary is always local.  Each data center would then
use a different pool, associated with the appropriate location-
sensitive rule.

Does this approach get you the desired locality preference?

