From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 12:59:13 -0700
Message-ID: <2ABC17E7-A9D9-4D27-A77B-BE4DBA7EB9BE@cs.ucsc.edu>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu> <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com> <AFC48281-A237-442F-A9FA-98861A32E363@cs.ucsc.edu> <A0B382C5B48F4832B9DFA685943B5BF4@inktank.com> <alpine.DEB.2.00.1303141239030.32317@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:57027 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab3CNT7O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:59:14 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so2715907pbc.17
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:59:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303141239030.32317@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Greg Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mar 14, 2013, at 12:39 PM, Sage Weil <sage@inktank.com> wrote:

> Unless those old bindings are already broken because of the preferred=
 osd=20
> thing=85

Well, for preferred_pg EOPNOTSUPP will be ignored by the old bindings, =
so I guess it still works :)--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
