From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Wed, 29 Aug 2012 11:50:47 +0200
Message-ID: <CAF6-1L51cF5xQLXXGWqLX2UDG=f2HrF1ji6KSz=5ErD38-z_NA@mail.gmail.com>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37107 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2H2Jus (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 05:50:48 -0400
Received: by vcbfk26 with SMTP id fk26so369396vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 02:50:48 -0700 (PDT)
In-Reply-To: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

>      I am facing problem while I am explicitly  trying to set
> "pg_number" of "data" pool.

You can't change pg_num of an existing pool, you can only specify this
number when creating the pool.
Support for online pg split/merge is an upcoming feature.

Cheers,

    Sylvain
