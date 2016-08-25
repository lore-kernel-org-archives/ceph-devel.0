From: Matt Benjamin <mbenjamin@redhat.com>
Subject: cmake on jewel
Date: Thu, 25 Aug 2016 12:32:39 -0400 (EDT)
Message-ID: <1686456395.75059503.1472142759254.JavaMail.zimbra@redhat.com>
References: <1341964413.75029444.1472140127089.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:60026 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756872AbcHYQcw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 12:32:52 -0400
In-Reply-To: <1341964413.75029444.1472140127089.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Kefu Chai <kchai@redhat.com>

Hi Folks,

The current head of the jewel branch has developed some cmake breakage relative to earlier in the jewel cycle.  Lots of fixes (mostly by Kefu) landed on master, but haven't been pulled back.  I'm not sure (doubt) that all of those would make sense to backport (though I'm not sure--mostly I'm thinking about pybuild stuff).

Since we'll be relying on jewel for some time, it would still be valuable to be able to do cmake builds for it (prototyping and smoke testing backported changes, etc).  Is fixing cmake on jewel an option?

Thanks,

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
