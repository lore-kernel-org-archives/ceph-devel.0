From: Noah Watkins <noah.watkins@inktank.com>
Subject: __bitwise__ annotation in inttypes
Date: Fri, 12 Jul 2013 19:32:53 -0700
Message-ID: <CA+Hcz5_iZhcC35Jda-Vc7HyQEN-QH76bpXdvU0eqEGVWYi+OdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43102 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053Ab3GMCcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 22:32:54 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so8072233vcb.5
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jul 2013 19:32:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The following is in include/inttypes.h

  #define __bitwise__

  typedef __u16 __bitwise__ __le16;
  typedef __u16 __bitwise__ __be16;
  ...

In linux, the same definition of __bitwise__ is used when not being
run through Sparse.

Is there any purpose in Ceph for _always_ removing those annotations,
as is done here?
